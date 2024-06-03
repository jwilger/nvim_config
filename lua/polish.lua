-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function cmd(command) return table.concat { "<Cmd>", command, "<CR>" } end
local function set(mode, key, command) vim.keymap.set(mode, key, cmd(command)) end

set("n", "<Leader>;", "b#")
set("n", "<Leader>a", "AerialToggle")

vim.o.scrolloff = 20
vim.o.sidescrolloff = 20
vim.o.relativenumber = false

-- Autocommand group for adjusting Telescope window settings
vim.api.nvim_create_augroup("TelescopeCustomizations", { clear = true })

-- Adjust settings when entering a Telescope window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt,TelescopeResults",
  group = "TelescopeCustomizations",
  callback = function()
    vim.wo.scrolloff = 0
    vim.wo.sidescrolloff = 0
  end,
})

-- Reset settings when leaving a Telescope window
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  group = "TelescopeCustomizations",
  callback = function()
    if not vim.bo.filetype:match "Telescope" then
      vim.wo.scrolloff = 20
      vim.wo.sidescrolloff = 20
    end
  end,
})

vim.diagnostic.config {
  virtual_text = false,
}
