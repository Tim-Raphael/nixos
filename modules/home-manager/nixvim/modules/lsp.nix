{
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;

        servers = {
          clangd = {
            enable = true;
            filetypes = [
              "c"
              "cpp"
              "objc"
              "objcpp"
              "cuda"
              "hpp"
            ];
          };

          nixd = {
            enable = true;
            settings = {
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixpkgs.expr = "import <nixpkgs> { }";
              };
            };
          };

          cssls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          lua_ls.enable = true;
          markdown_oxide.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
          terraformls.enable = true;
          ts_ls.enable = true;

          yamlls = {
            enable = true;
            settings = {
              schemaStore = {
                enable = false;
                url = "";
              };
            };
          };
        };
      };

      none-ls = {
        enable = true;
        settings = {
          should_attach = ''
            function(bufnr)
              local bufname = vim.fn.bufname(bufnr)
              return not string.find(bufname, "%.git/")
            end
          '';
        };

        sources = {
          completion = {
            spell.enable = true;
          };

          diagnostics = {
            protolint.enable = true;
          };
        };
      };

      lspkind.enable = true;

      lspsaga = {
        enable = true;

        lightbulb.virtualText = false;

        ui = {
          codeAction = "";
        };

        definition = {
          keys = {
            edit = "<CR>";
            vsplit = "v";
            split = "h";
            tabe = "t";
            quit = "q";
          };
        };
      };

      trouble.enable = true;

      rustaceanvim = {
        enable = true;

        settings = {
          server = {
            cmd = [ "rust-analyzer" ];
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };

                inlayHints = {
                  enable = "always";

                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };

            standalone = false;
          };
        };
      };

      crates.enable = true;
      fidget.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "gh";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }

      {
        mode = "n";
        key = "g?";
        action = ":Trouble toggle diagnostics<CR>";
      }

      {
        mode = "n";
        key = "gf";
        action = "<cmd> lua vim.diagnostic.open_float(nil, {focusable=false, source='always', border='rounded'})<cr>";
      }

      {
        mode = "n";
        key = "gj";
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
      }

      {
        mode = "n";
        key = "gk";
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
      }

      {
        mode = "n";
        key = "ga";
        action = ":Lspsaga code_action<cr>";
      }

      {
        mode = "n";
        key = "gd";
        action = ":Lspsaga goto_definition<cr>";
      }

      {
        mode = "n";
        key = "gi";
        action = ":Lspsaga finder imp<cr>";
      }

      {
        mode = "n";
        key = "gp";
        action = ":Lspsaga peek_type_definition<cr>";
      }

      {
        mode = "n";
        key = "gf";
        action = "<cmd>lua require('telescope.builtin').lsp_references({})<cr>";
      }

      {
        mode = "n";
        key = "ge";
        action = "<cmd>lua require('telescope.builtin').diagnostics({})<cr>";
      }

      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      }
    ];
  };
}
