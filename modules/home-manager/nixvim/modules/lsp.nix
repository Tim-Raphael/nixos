{ pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = false; # Toggle via th
        servers = {
          nixd = {
            enable = true;
            settings = {
              options = {
                nixpkgs.expr = "import <nixpkgs> { }";
              };
            };
          };
          clangd.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          html.enable = true;
          lua_ls.enable = true;
          markdown_oxide.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
          yamlls.enable = true;
        };
      };

      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            default_settings = {
              rust-analyzer = {
                cargo = {
                  features = "all";
                };
              };
            };
          };
        };
      };

      lspkind.enable = true;
      crates.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<C-r>";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<C-a>";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<CMD>lua vim.lsp.buf.hover({ border = 'single' })<CR>";
      }
      {
        mode = "n";
        key = "th";
        action = "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      }
      {
        mode = "n";
        key = "gj";
        action = "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'single' }})<CR>";
      }
      {
        mode = "n";
        key = "gk";
        action = "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'single' }})<CR>";
      }
    ];
  };
}
