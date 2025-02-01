-- Basic settings
vim.g.mapleader = " "
vim.wo.number = true
vim.cmd("syntax on")

vim.opt.encoding = "utf-8"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.updatetime = 300
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wildmenu = true

-- Setup lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim plugin setup
require("lazy").setup({
  -- Catppuccin colorscheme plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Which-key plugin
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter"
  },
  

  -- Mason plugin for managing external tools
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- Optional: Updates registry contents
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig bridge for easier LSP configuration
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" }, -- Specify LSP servers to install
        automatic_installation = true,
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end

  },


  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'enter' },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { "sources.default" }
  },
  "saghen/blink.compat", -- For compatibility with other plugins

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  -- Snacks.nvim plugin: enables all modules and sets up key mappings
  {
    "folke/snacks.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons"
    },
    priority = 1000,
    lazy = false,
    opts = {
      animate      = { enabled = true },
      bigfile      = { enabled = true },
      bufdelete    = { enabled = true },
      dashboard    = { enabled = true },
      debug        = { enabled = true },
      dim          = { enabled = true },
      explorer     = { enabled = true },
      git          = { enabled = true },
      gitbrowse    = { enabled = true },
      indent       = { enabled = true },
      input        = { enabled = true },
      layout       = { enabled = true },
      lazygit      = { enabled = true },
      notifier     = { enabled = true, timeout = 3000 },
      picker       = { enabled = true },
      profiler     = { enabled = true },
      quickfile    = { enabled = true },
      rename       = { enabled = true },
      scope        = { enabled = true },
      scratch      = { enabled = true },
      scroll       = { enabled = true },
      statuscolumn = { enabled = true },
      terminal     = { enabled = true },
      toggle       = { enabled = true },
      win          = { enabled = true },
      words        = { enabled = true },
      zen          = { enabled = true },
    },
    keys = {
      { "<Leader>e",  function() Snacks.explorer.open() end, desc = "Toggle file explorer" },
      { "<Leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<Leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<Leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<Leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<Leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<Leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<Leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<Leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<Leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit File History" },
      { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<Leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<Leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
      { "<C-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Global debugging functions for convenience
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd  -- Override print to use Snacks for inspection

          -- Set up toggle keymaps with a consistent <Leader>U prefix
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>Us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>Uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>UL")
          Snacks.toggle.diagnostics():map("<Leader>Ud")
          Snacks.toggle.line_number():map("<Leader>Ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<Leader>Uc")
          Snacks.toggle.treesitter():map("<Leader>UT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<Leader>Ub")
          Snacks.toggle.inlay_hints():map("<Leader>Uh")
          -- Use <Leader>Ui for toggling indent guides (as you requested)
          Snacks.toggle.indent():map("<Leader>Ui")
          Snacks.toggle.dim():map("<Leader>UD")
        end,
      })
    end,
  },
})
