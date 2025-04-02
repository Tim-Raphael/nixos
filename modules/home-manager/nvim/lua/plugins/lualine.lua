return {
    {
        "arkav/lualine-lsp-progress",
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = "gruvbox_dark",
                sections = {
                    lualine_c = {
                        "filename",
                        "lsp_progress",
                    }
                }
            })
        end,
    }
}
