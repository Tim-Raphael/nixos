return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Extend LSP capabilities for `nvim-cmp` integration
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(client, bufnr)
                -- Autoformat on save
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format({ async = false }) end,
                    })
                end

                -- (trying to) enable inlay hints
                if client.server_capabilities.inlayHintProvider then
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.inlay_hint.enable(true, { bufnr })
                        end,
                    })
                end
            end

            -- Lua
            lspconfig.lua_ls.setup({
                cmd = { "lua-language-server" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        telemetry = {
                            enable = false,
                        }
                    }
                }
            })

            -- Rust Analyzer
            lspconfig.rust_analyzer.setup({
                cmd = { "rust-analyzer" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                        inlayHints = {
                            typeHints = {
                                enable = true,
                            },
                            chainingHints = {
                                enable = true,
                            },
                            parameterHints = {
                                enable = true,
                            },
                        },
                        formatting = {
                            enable = true,
                        },
                    }
                }
            })

            -- Nix
            lspconfig.nixd.setup({
                cmd = { "nixd" },
                on_attach = on_attach,
                capabilities = capabilities,
                nixpkgs = {
                    expr = "import <nixpkgs> { }"
                },
                settings = {
                    nixd = {
                        formatting = {
                            command = { "nixfmt" },
                        },
                    },
                },
            })

            -- JavaScript / Typescript
            lspconfig.ts_ls.setup({
                cmd = { "typescript-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "javascript", "typescript" },
            })

            -- CSS / SCSS
            lspconfig.cssls.setup({
                cmd = { "vscode-css-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "css", "scss" },
            })

            -- HTML
            lspconfig.html.setup({
                cmd = { "vscode-html-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "html" },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
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
