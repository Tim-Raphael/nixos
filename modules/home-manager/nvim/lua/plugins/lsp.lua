return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Function to attach autoformat on save
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format({ async = false }) end,
                    })
                end
            end

            lspconfig.lua_ls.setup {
                cmd = { "lua-language-server" },
                on_attach = on_attach,
                settings = {},
            }
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require("cmp")

            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            -- Use cmdline & path source for ":"
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" } }, { { name = "cmdline" }
                })
            })

            -- Set up LSP capabilities for nvim-cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
        end,
    },
}
