-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Jump to next LSP error
vim.keymap.set("n", "<leader>gj", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    { desc = "Jump to next error" })

-- Jump to previous LSP error
vim.keymap.set("n", "<leader>gk", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    { desc = "Jump to previous error" })

-- Trigger Code Action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Goto Defintion
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP Goto Definition" })

-- Editor settings
vim.o.relativenumber = true
vim.o.number         = true
vim.o.expandtab      = true
vim.o.tabstop        = 4
vim.o.softtabstop    = 4
vim.o.shiftwidth     = 4
vim.o.textwidth      = 80
vim.o.colorcolumn    = "+1"
vim.o.wrap           = true
vim.o.linebreak      = true
vim.o.breakindent    = true
vim.o.showbreak      = "ͱ"
vim.o.swapfile       = false

-- Special treatment for TS
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.expandtab = true
    end,
})
