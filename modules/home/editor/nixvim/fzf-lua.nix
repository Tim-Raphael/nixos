{ pkgs, ... }:

{
  programs.nixvim = {
    dependencies = {
      ripgrep.enable = true;
      fd.enable = true;
    };

    extraPackages = [ pkgs.bat ];

    extraConfigLua = ''
      require('fzf-lua').register_ui_select()
    '';

    plugins.fzf-lua = {
      enable = true;
      profile = "max-perf";

      settings = {
        defaults = {
          headers = false;
          cwd_prompt = false;
          prompt = "> ";
        };
      };

      keymaps = {
        "<leader>'" = {
          action = "resume";
          options.desc = "Continue Search";
        };

        "<leader>F" = {
          action = "files";
          options.desc = "Find Files in Current Directory";
        };

        "<leader>g" = {
          action = "git_status";
          options.desc = "Changed Files";
        };

        "<leader>b" = {
          action = "buffers";
          options.desc = "Buffers";
        };

        "<leader>j" = {
          action = "jumps";
          options.desc = "Jumplist";
        };

        "<leader>d" = {
          action = "diagnostics_document";
          options.desc = "Document Diagnostics";
        };

        "<leader>D" = {
          action = "diagnostics_workspace";
          options.desc = "Diagnostics";
        };

        "<leader>S" = {
          action = "lsp_live_workspace_symbols";
          options.desc = "Workspace Symbol Search";
        };

        "<leader>s" = {
          action = "lsp_document_symbols";
          options.desc = "Document Symbols";
        };

        "<leader>?" = {
          action = "commands";
          options.desc = "Command Palette";
        };

        "gd" = {
          action = "lsp_definitions";
          options.desc = "Go to definition";
        };

        "gr" = {
          action = "lsp_references";
          options.desc = "Go to references";
        };

        "gi" = {
          action = "lsp_implementations";
          options.desc = "Go to implementations";
        };

        "gt" = {
          action = "lsp_typedefs";
          options.desc = "Go to type definitions";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action.__raw = ''
          function()
            local root = vim.fn.getcwd()
            local clients = vim.lsp.get_clients({ bufnr = 0 })

            for _, client in ipairs(clients) do
              if client.config.root_dir then
                root = client.config.root_dir
                break
              end
            end

            require('fzf-lua').files({ cwd = root })
          end
        '';
        options.desc = "Find Files in Workspace";
      }
      {
        mode = "n";
        key = "<leader>/";
        action.__raw = ''
          function()
            local root = vim.fn.getcwd()
            local clients = vim.lsp.get_clients({ bufnr = 0 })

            for _, client in ipairs(clients) do
              if client.config.root_dir then
                root = client.config.root_dir
                break
              end
            end

            require('fzf-lua').live_grep({ cwd = root })
          end
        '';
        options.desc = "Grep in Workspace";
      }
    ];
  };
}
