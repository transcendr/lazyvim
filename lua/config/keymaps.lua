-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape from insert mode when pressing jj
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "Escape from insert mode" })
-- Delete the entire document text when pressing <leader>dd
vim.keymap.set(
  "n",
  "<leader>dd",
  --":%d<CR>",
  "<cmd>lua require('config.functions').delete_buffer_if_empty()<CR>",
  { noremap = true, silent = true, desc = "Delete the entire document text" }
)
-- Select the entire document text when pressing <leader>vv
vim.keymap.set("n", "<leader>vv", "ggVG", { noremap = true, silent = true, desc = "Select the entire document text" })
-- Copy the entire document text when pressing <leader>yy
vim.keymap.set("n", "<leader>yy", "ggVGy", { noremap = true, silent = true, desc = "Copy the entire document text" })

-- leader b, w saves the current buffer
vim.keymap.set("n", "<leader>bw", ":w<cr>", { noremap = true, silent = true, desc = "save current buffer" })
vim.keymap.set("n", "<leader>bw", ":wa<cr>", { noremap = true, silent = true, desc = "save all buffers" })

-- Search
vim.keymap.set(
  "n",
  "<leader>fg",
  ":Telescope live_grep<CR>",
  { noremap = true, silent = true, desc = "Find text using Telescope" }
)
vim.keymap.set(
  "n",
  "<leader>fh",
  ":Telescope help_tags<CR>",
  { noremap = true, silent = true, desc = "Find help tags using Telescope" }
)

-- Windows
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split window vertically" })
vim.keymap.set(
  "n",
  "<leader><C-f>",
  ":%s//gI<Left><Left><Left>",
  { noremap = true, silent = true, desc = "Find and replace a word in the current buffer" }
)
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write the current buffer to disk" })

-- require("config.functions")
vim.api.nvim_set_keymap(
  "n",
  "<leader><C-a>",
  "<cmd>lua require('config.functions').open_selected_text_in_vsplit()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader><C-a>",
  "y<cmd>lua require('config.functions').open_selected_text_in_vsplit()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader><C-m>",
  "<cmd>lua require('config.functions').toggle_ai_model()<CR>",
  { noremap = true, silent = true }
)
