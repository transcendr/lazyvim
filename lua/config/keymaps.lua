-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- RSTLNE keymaps
-- Ctrl + k to move down
vim.keymap.set("n", "<C-k>", "j", { noremap = true, silent = true, desc = "Move down" })

-- Tabs
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab", silent = true })
vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab", silent = true })

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
vim.keymap.set("n", "<leader>bW", ":wa<cr>", { noremap = true, silent = true, desc = "save all buffers" })

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
vim.keymap.set(
  "n",
  "<leader>sR",
  ":%s//gI<Left><Left><Left>",
  { noremap = true, silent = true, desc = "Find and replace a word in the current buffer" }
)

-- Movement
-- Move to first character of line when pressing `gh`, in normal mode
vim.keymap.set("n", "gh", "^", { noremap = true, silent = true, desc = "Move to first character of line" })
-- Now in visual mode, pressing `gh` will move to first character of line
vim.keymap.set("v", "gh", "^", { noremap = true, silent = true, desc = "Move to first character of line" })
-- Move to last character of line when pressing `gl`, in normal mode
vim.keymap.set("n", "gl", "$", { noremap = true, silent = true, desc = "Move to last character of line" })
-- Now in visual mode, pressing `gl` will move to last character of line
vim.keymap.set("v", "gl", "$", { noremap = true, silent = true, desc = "Move to last character of line" })
-- Now in insert mode, pressing `gll` will move to last character of line
vim.keymap.set("i", "gll", "<ESC>$a", { noremap = true, silent = true, desc = "Move to last character of line" })
-- Now in insert mode, holding down `ghh` will move to first character of line
vim.keymap.set("i", "ghh", "<ESC>^i", { noremap = true, silent = true, desc = "Move to first character of line" })
-- Move the the last linge of the document when pressing `ge`, in normal mode
vim.keymap.set("n", "ge", "G", { noremap = true, silent = true, desc = "Move to last line of document" })

-- Windows
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split window vertically" })
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

-- Run ":Neorg index" when pressing <leader><C-ni>
vim.keymap.set("n", "<leader><C-n>i", ":Neorg index<CR>", { noremap = true, silent = true, desc = "Run :Neorg index" })
-- Run ":Neorg return" when pressing <leader><C-nr>
vim.keymap.set(
  "n",
  "<leader><C-n>r",
  ":Neorg return<CR>",
  { noremap = true, silent = true, desc = "Run :Neorg return" }
)
-- Run ":Neorg workspace" when pressing <leader><C-n>w
vim.keymap.set(
  "n",
  "<leader><C-n>w",
  ":Neorg workspace<CR>",
  { noremap = true, silent = true, desc = "Run :Neorg workspace" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>be",
  "<cmd>lua require('config.functions').reload_buffer()<CR>",
  { noremap = true, silent = true }
)

-- Conver the below to a keymap
-- {
--   "<leader>acd",
--   '<cmd>lua AiderBackground("--model=gpt-3.5-turbo", "add documentation comments to all structs, functions, etc that are missing them")<CR>',
--   desc = "[A]ider [C]omment [D]ocumentation (3.5t, bg)",
--   -- adds documentation comments to all structs, functions, etc that are missing them on the current buffer
-- },

-- ####### AIDER KEYMAPS #######

--  Add documentation comments to all structs, functions, etc that are missing them on the current buffer
-- aider_add_comments_35
vim.api.nvim_set_keymap(
  "n",
  "<leader>acd",
  "<cmd>lua require('config.functions').aider_add_comments_35()<CR>",
  { noremap = true, silent = true }
)

-- Fix the diagnostic line
-- aider_fix_diagnostic_line
vim.api.nvim_set_keymap(
  "n",
  "<leader>adl",
  "<cmd>lua require('config.functions').aider_fix_diagnostic_line()<CR>",
  { noremap = true, silent = true, desc = "[A]ider Fix the [D]iagnostic [L]ine" }
)

-- Run "let @+=@:" when pressing <leader><C-y>
-- vim.keymap.set("n", "<leader><C-y>", "let @+=@:", { noremap = true, silent = true, desc = "Run let @+=@:" })
