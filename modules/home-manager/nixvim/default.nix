{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";
    globals.localmapleader = " ";

    keymaps = [
      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          noremap = true;
          silent = true;
        };
      }

      # LSP keymaps (functions via lua)
      {
        mode = "n";
        key = "<leader>gj";
        action = ''
          function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        lua = true;
        options = {
          desc = "Jump to next error";
        };
      }
      {
        mode = "n";
        key = "<leader>gk";
        action = ''
          function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        lua = true;
        options = {
          desc = "Jump to previous error";
        };
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "vim.lsp.buf.code_action";
        lua = true;
        options = {
          desc = "LSP Code Action";
        };
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "vim.lsp.buf.definition";
        lua = true;
        options = {
          desc = "LSP Goto Definition";
        };
      }
    ];

    plugins = {
      lualine.enable = true;
      oil.enable = true;
    };
  };
}
