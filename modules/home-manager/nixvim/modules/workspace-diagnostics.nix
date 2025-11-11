{ pkgs, ... }:

let
  workspace-diagnostics = pkgs.vimUtils.buildVimPlugin {
    pname = "workspace-diagnostics.nvim";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "workspace-diagnostics.nvim";
      rev = "main";
      sha256 = "sha256-jSpKaKnGyip/nzqU52ypWLgoCtvccYN+qb5jzlwAnd4=";
    };
  };
in
{
  programs.nixvim = {

    extraPlugins = [ workspace-diagnostics ];

    keymaps = [
      {
        mode = "n";
        key = "td";
        action = ''<cmd>Trouble diagnostics toggle<CR>'';
        options.desc = "Open diagnostics";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = ''<cmd>Scan<CR>'';
        options.desc = "Scan workspace diagnostics";
      }
    ];

    extraConfigLua = ''
      vim.api.nvim_create_user_command("Scan", function (args)
        for _, client in ipairs(vim.lsp.buf_get_clients()) do
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end

        print("Scanning workspace.. 🔍")
      end, { desc = "Scan workspace for diagnostics" })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
          texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
          },
        },
        underline = true,
        virtual_text = {
          prefix = ">",
          spacing = 2,
          source = "always",
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
      })
    '';
  };
}
