-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Editor settings
vim.o.expandtab      = true
vim.o.tabstop        = 4
vim.o.softtabstop    = 4
vim.o.shiftwidth     = 4
vim.o.relativenumber = true
vim.o.wrap           = true
vim.o.linebreak      = true
vim.o.breakindent    = true
vim.o.showbreak      = "ͱ"
