-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "gl", "$", { desc = "Move to end of line" })
vim.api.nvim_set_keymap("n", "gh", "^", { desc = "Move to start of line" })
vim.api.nvim_set_keymap("i", "<C-l>", "<esc>$a", { desc = "Move to end of line in insert mode" })
