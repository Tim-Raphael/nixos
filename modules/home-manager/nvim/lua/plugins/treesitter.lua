return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        local telescopeconfig = require("nvim-treesitter.configs")
        telescopeconfig.setup({
            ensure_installed = { "lua", "javascript", "html", "rust", "toml" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
