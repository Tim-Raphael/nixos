{ pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        # Toggled via "th"
        inlayHints = false;
        servers = {
          nixd = {
            enable = true;
            settings = {
              options = {
                nixpkgs.expr = "import <nixpkgs> { }";
              };
            };
          };
          rust_analyzer = {
            enable = true;
            package = pkgs.rust-bin.stable."1.92.0".default.override {
              extensions = [
                "rust-src"
                "rust-analyzer"
              ];
            };
            # Provided by default rust toolchain profile
            installCargo = false;
            installRustc = false;
            settings = {
              cargo.features = "all";
              rustc.source = "discover";
              check = {
                #command = "clippy";
                command = "check";
                features = "all";
              };
            };
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
        key = "<leader>";
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
