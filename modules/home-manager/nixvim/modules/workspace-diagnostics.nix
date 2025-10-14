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
      vim.api.nvim_create_user_command('Scan', function (args)
        for _, client in ipairs(vim.lsp.buf_get_clients()) do
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end

        print("Scanning workspace.. 🔍")
      end, { desc = "Scan workspace for diagnostics" })

      vim.fn.sign_define("DiagnosticSignError", {
        texthl = "DiagnosticSignError",
        text = "E",
        numhl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DiagnosticSignWarn", {
        texthl = "DiagnosticSignWarn",
        text = "W",
        numhl = "DiagnosticSignWarn",
      })

      vim.fn.sign_define("DiagnosticSignInfo", {
        texthl = "DiagnosticSignInfo",
        text = "I",
        numhl = "DiagnosticSignInfo",
      })

      vim.fn.sign_define("DiagnosticSignHint", {
        texthl = "DiagnosticSignHint",
        text = "H",
        numhl = "DiagnosticSignHint",
      })

      vim.diagnostic.config({
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
