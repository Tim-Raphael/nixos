return {
    {
        "williamboman/mason.nvim",
        config = function() 
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function() 
            require("mason-lspconfig").setup()
        end,
    },
    {"neovim/nvim-lspconfig"},
        -- Completion plugins
      { 'hrsh7th/nvim-cmp',
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'hrsh7th/cmp-vsnip', -- For vsnip users
          'hrsh7th/vim-vsnip', -- For vsnip users
        },
        config = function()
          local cmp = require'cmp'

          cmp.setup({
            snippet = {
              -- REQUIRED - you must specify a snippet engine
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item.
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' }, -- For vsnip users.
            }, {
              { name = 'buffer' },
            })
          })

          -- Use buffer source for `/` and `?`
          cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          })

          -- Use cmdline & path source for ':'
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            })
          })
          
          -- Set up LSP capabilities for nvim-cmp
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local lspconfig = require('lspconfig')
        end
      },
    {
      'mrcjkb/rustaceanvim',
      version = '^5', 
      ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
} 

