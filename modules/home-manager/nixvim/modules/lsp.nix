{ lib, ... }:

{
  programs.nixvim = {
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
            cmd = [ "rust-analyzer" ];
            default_settings = {
              rust-analyzer = {
                # Reduce completion limit (default is null/unlimited)
                completion = {
                  limit = 50;
                  postfix = {
                    enable = false;
                  };
                };

                # Optimize inlay hints
                inlayHints = {
                  maxLength = 20;
                  lifetimeElisionHints = {
                    enable = "skip_trivial";
                    useParameterNames = false;
                  };
                  closureReturnTypeHints = {
                    enable = "with_block";
                  };
                  typeHints = {
                    hideClosureInitialization = true;
                    hideNamedConstructor = true;
                  };
                  chainingHints = {
                    maxLength = 15; # Custom limit for performance
                  };
                  parameterHints = {
                    maxLength = 15; # Custom limit for performance
                  };
                };

                # Disable expensive lens features
                lens = {
                  references = {
                    adt.enable = false;
                    enumVariant.enable = false;
                    method.enable = false;
                    trait.enable = false;
                  };
                };

                # Cargo optimizations
                cargo = {
                  buildScripts = {
                    features = "all"; # Enable all feature flags
                    invocationStrategy = "once"; # Default is "per_workspace", faster caching
                  };
                };

                checkOnSave = true;

                # Import optimization for faster resolution
                imports = {
                  granularity = {
                    group = "module";
                  };
                  prefix = "crate";
                };

                # Workspace symbol search optimization
                workspace = {
                  symbol = {
                    search = {
                      kind = "only_types";
                      limit = 64;
                    };
                  };
                };

                # File watching optimization
                files = {
                  excludeDirs = [
                    "target"
                    "node_modules"
                    ".git"
                    "dist"
                    "build"
                  ];
                };

                # Disable expensive experimental features
                diagnostics = {
                  experimental = {
                    enable = false;
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
