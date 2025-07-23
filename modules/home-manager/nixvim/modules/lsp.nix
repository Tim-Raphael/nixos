{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;

        lazyLoad.settings = {
          event = [
            "BufReadPre"
            "BufNewFile"
          ];
        };

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
          ts_ls.enable = true;

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
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "K";
        action = "<CMD>lua vim.lsp.buf.hover()<CR>";
      }

      {
        mode = "n";
        key = "th";
        action = "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      }

      {
        mode = "n";
        key = "gj";
        action = "<CMD>lua vim.diagnostic.goto_next()<CR>";
      }

      {
        mode = "n";
        key = "gk";
        action = "<CMD>lua vim.diagnostic.goto_prev()<CR>";
      }

      {
        mode = "n";
        key = "ga";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      }

      {
        mode = "n";
        key = "gd";
        action = "<CMD>lua vim.lsp.buf.definition()<CR>";
      }

      {
        mode = "n";
        key = "gf";
        action = "<CMD>lua vim.lsp.buf.references()<CR>";
      }

      {
        mode = "n";
        key = "gr";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
      }
    ];
  };
}
