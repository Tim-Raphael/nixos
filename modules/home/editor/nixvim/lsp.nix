{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            # The home Rust toolchain already provides Cargo and rustc.
            installCargo = false;
            installRustc = false;
          };
          clangd.enable = true;
          cssls.enable = true;
          vtsls.enable = true;
          eslint.enable = true;
          html.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
          yamlls.enable = true;
          jdtls.enable = true;
          typos_lsp.enable = true;
          protols.enable = true;
        };
      };

      lspkind.enable = true;
      crates.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<leader>r";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<leader>a";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "th";
        action = "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      }
      {
        mode = "n";
        key = "gj";
        action = "<CMD>lua vim.diagnostic.jump({ count = 1, float = { border = 'single' }})<CR>";
      }
      {
        mode = "n";
        key = "gk";
        action = "<CMD>lua vim.diagnostic.jump({ count = -1, float = { border = 'single' }})<CR>";
      }
    ];

    extraConfigLua = ''
      local workspace_markers = {
        nixd = { "flake.nix", "default.nix", "shell.nix" },
        rust_analyzer = { "Cargo.toml", "rust-project.json" },
        clangd = { ".clangd", "compile_commands.json", "compile_flags.txt", "CMakeLists.txt" },
        vtsls = { "tsconfig.json", "jsconfig.json", "package.json" },
        pyright = { "pyproject.toml", "pyrightconfig.json", "setup.py", "requirements.txt" },
        lua_ls = { ".luarc.json", ".luarc.jsonc" },
        jdtls = { "pom.xml", "build.gradle", "build.gradle.kts" },
        protols = { "buf.yaml" },
      }

      local function find_workspace_marker(directory, markers, callback)
        local index = 1

        local function check_next()
          local marker = markers[index]
          if not marker then
            local parent = vim.fs.dirname(directory)
            if parent and parent ~= directory then
              find_workspace_marker(parent, markers, callback)
            end
            return
          end

          local path = vim.fs.joinpath(directory, marker)
          vim.uv.fs_stat(path, function(err, stat)
            if not err and stat.type == "file" then
              vim.schedule(function()
                callback(path)
              end)
              return
            end

            index = index + 1
            check_next()
          end)
        end

        check_next()
      end

      local function start_workspace_servers()
        local cwd = vim.fn.getcwd()
        local bufnr = vim.api.nvim_get_current_buf()

        for name, markers in pairs(workspace_markers) do
          if vim.lsp.is_enabled(name) then
            find_workspace_marker(cwd, markers, function(marker)
              if vim.fn.getcwd() ~= cwd or not vim.api.nvim_buf_is_valid(bufnr) then
                return
              end
              if not vim.lsp.is_enabled(name) then
                return
              end

              local config = vim.deepcopy(vim.lsp.config[name])
              local marker_bufnr = vim.fn.bufadd(marker)

              local function start(root_dir)
                vim.schedule(function()
                  if not root_dir or not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                  end
                  if vim.fn.getcwd() ~= cwd or not vim.lsp.is_enabled(name) then
                    return
                  end

                  config.root_dir = root_dir
                  local filetype = vim.bo[bufnr].filetype
                  local attach = filetype == "" or vim.tbl_contains(config.filetypes or {}, filetype)
                  vim.lsp.start(config, { bufnr = bufnr, attach = attach })
                end)
              end

              -- Keep server-specific workspace and monorepo resolution.
              if type(config.root_dir) == "function" then
                config.root_dir(marker_bufnr, start)
              else
                local root_dir = config.root_dir
                if not root_dir and config.root_markers then
                  root_dir = vim.fs.root(marker, config.root_markers)
                end
                start(root_dir or vim.fs.dirname(marker))
              end
            end)
          end
        end
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("WorkspaceLsp", { clear = true }),
        once = true,
        callback = function()
          vim.defer_fn(start_workspace_servers, 100)
        end,
      })
    '';
  };
}
