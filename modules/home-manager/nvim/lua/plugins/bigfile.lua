return {
    "LunarVim/bigfile.nvim",
    config = function()
        require("bigfile").setup({
            filesize = 2,
            pattern = { "*" },
            features = {
                "treesitter",
                "lsp",
            },
        })
    end,
}
