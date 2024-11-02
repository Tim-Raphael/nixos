return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Extend LSP capabilities for `nvim-cmp` integration
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Function to attach autoformat on save
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format({ async = false }) end,
                    })
                end
            end

            -- Lua Language Server
            lspconfig.lua_ls.setup {
                cmd = { "lua-language-server" },
                on_attach = on_attach,
                capabilities = capabilities,
            }

            -- Rust Analyzer
            lspconfig.rust_analyzer.setup {
                cmd = { "rust-analyzer" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        }
                    }
                }
            }

            -- Nix Language Server
            lspconfig.nixd.setup {
                cmd = { "nixd" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    nixd = {
                        formatting = {
                            command = { "nixfmt" },
                        },
                    },
                },
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
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }, { { name = "buffer" } }),
            })

            -- Additional completion settings for command mode ("/", "?")
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            -- Completion for command line mode with path and cmdline sources
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
