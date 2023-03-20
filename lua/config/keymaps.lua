-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape from insert mode when pressing jj
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "Escape from insert mode" })

-- Leader b, w saves the current buffer
vim.keymap.set("n", "<leader>bw", ":w<CR>", { noremap = true, silent = true, desc = "Save current buffer" })
vim.keymap.set("n", "<leader>bW", ":wa<CR>", { noremap = true, silent = true, desc = "Save all buffers" })
