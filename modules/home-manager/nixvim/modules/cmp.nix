{ ... }:
{
  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true; # Additional dependency

      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp_luasnip.enable = true;
      cmp-cmdline.enable = true;
      cmp-nvim-lua.enable = true; # Neovim Lua API completion
      cmp-emoji.enable = true; # Emoji completion :smile:
      cmp-calc.enable = true; # Calculator completion
      cmp-treesitter.enable = true;

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
              name = "treesitter";
              priority = 200;
            }
            {
              name = "calc";
              priority = 150;
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
            scrollbar = false;
            completion = {
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

          # A bit annoying
          experimental = {
            ghost_text = false; # Show preview of completion
          };

          performance = {
            debounce = 60;
            throttle = 30;
            fetching_timeout = 500;
            confirm_resolve_timeout = 80;
            async_budget = 1;
            max_view_entries = 200;
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
