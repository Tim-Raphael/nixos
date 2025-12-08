{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Additional dependency
      nvim-autopairs.enable = true;

      # Autocomplete for:
      # Treesitter (incremental parser)
      cmp-treesitter.enable = true;
      # Language server suggestions
      cmp-nvim-lsp.enable = true;
      # File paths
      cmp-path.enable = true;
      # Items in current buffer.
      cmp-buffer.enable = true;
      # Luasnip (snippets)
      cmp_luasnip.enable = true;
      # The Neovim command line
      cmp-cmdline.enable = true;
      # Emoji completion :smile:
      cmp-emoji.enable = true;

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };

          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "treesitter";
              priority = 900;
            }
            {
              name = "luasnip";
              priority = 750;
            }
            {
              name = "buffer";
              priority = 500;
              keyword_length = 3;
            }
            {
              name = "path";
              priority = 300;
            }
            {
              name = "nvim_lua";
              priority = 400;
            }
            {
              name = "git";
              priority = 250;
            }
            {
              name = "emoji";
              priority = 100;
              keyword_length = 2;
            }
          ];

          mapping = {
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
          };

          window = {
            completion = {
              scrollbar = false;
              border = [
                "┌"
                "─"
                "┐"
                "│"
                "┘"
                "─"
                "└"
                "│"
              ];
            };
            documentation = {
              scrollbar = false;
              border = [
                "┌"
                "─"
                "┐"
                "│"
                "┘"
                "─"
                "└"
                "│"
              ];
            };
          };

          confirmation = {
            default_behavior = "Replace";
          };

          experimental = {
            # A bit too annoying
            ghost_text = false;
          };
        };
      };
    };

    # Command line completion setup
    extraConfigLuaPost = ''
      local cmp = require('cmp')

      -- Command line completion for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.insert({
          ["<Down>"] = { c = cmp.mapping.select_next_item() },
          ["<Up>"] = { c = cmp.mapping.select_prev_item() },
        }),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Command line completion for '/' and '?'
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.insert({
          ["<Down>"] = { c = cmp.mapping.select_next_item() },
          ["<Up>"] = { c = cmp.mapping.select_prev_item() },
        }),
        sources = {
          { name = 'buffer' }
        }
      })      

      -- Auto-pairs integration
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    '';
  };
}
