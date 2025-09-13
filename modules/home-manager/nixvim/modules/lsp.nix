{ lib, pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = lib.mkAfter [ pkgs.rust-bin.nightly.latest.rust-analyzer ];

    plugins = {
      lsp = {
        enable = true;
        inlayHints = false;

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
          jdtls.enable = true;

          yamlls = {
            enable = true;
            settings = {
              schemaStore.enable = false;
            };
          };
        };
      };

      lspkind.enable = true;
      nix.enable = true;
      crates.enable = true;
      typescript-tools.enable = true;

      rustaceanvim = {
        enable = true;

        settings = {
          server = {
            cmd = [
              "${pkgs.rust-bin.nightly.latest.rust-analyzer}/bin/rust-analyzer"
            ];
          };
        };
      };
    };

    keymaps = lib.mkAfter [
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

      {
        mode = "n";
        key = "ga";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      }

      {
        mode = "n";
        key = "gr";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
      }
    ];
  };
}
