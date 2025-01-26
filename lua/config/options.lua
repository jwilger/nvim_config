-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.layzvim_rust_diagnostics = "bacon-ls"

vim.opt.relativenumber = false
vim.opt.scrolloff = 20

local diagnostic_float_win = nil
local function toggle_diagnostic_float()
  if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
    -- If the window is open, close it
    vim.api.nvim_win_close(diagnostic_float_win, true)
    diagnostic_float_win = nil
  else
    -- If the window is not open, show it
    diagnostic_float_win = vim.diagnostic.open_float(nil, { focus = false })
  end
end
vim.diagnostic.config({
  virtual_text = false, -- Disable inline text diagnostics
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline the problem text
  update_in_insert = false, -- Don't update diagnostics in insert mode
  float = {
    show_header = true,
    source = true, -- Show source of the diagnostics
    border = "rounded", -- Rounded border for floating window
    focusable = false, -- Make the floating window non-focusable
  },
})
vim.keymap.set("n", "<Leader>v", toggle_diagnostic_float, { noremap = true, desc = "Toggle diagnostic float" })

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
}
