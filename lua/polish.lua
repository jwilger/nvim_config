-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function cmd(command) return table.concat { "<Cmd>", command, "<CR>" } end

vim.keymap.set("n", "<C-w>z", cmd "WindowsMaximize")
vim.keymap.set("n", "<C-w>_", cmd "WindowsMaximizeVertically")
vim.keymap.set("n", "<C-w>|", cmd "WindowsMaximizeHorizontally")
vim.keymap.set("n", "<C-w>=", cmd "WindowsEqualize")
