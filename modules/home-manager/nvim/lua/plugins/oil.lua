return {
    "stevearc/oil.nvim",
    dependencies = {  "nvim-tree/nvim-web-devicons"  },
    config = function()
        local oil = require("oil");
        oil.setup({
            columns = { "icon" },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,
                ["<M-h>"] = "actions.select_split",
            },
            view_options = {
                show_hidden = true,
            },
        });

        vim.keymap.set("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open parent directory" });
    end,
}
