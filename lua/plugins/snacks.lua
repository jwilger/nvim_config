return {
	{
		"folke/snacks.nvim",
		dependencies = {
			"echasnovski/mini.icons",
			"nvim-tree/nvim-web-devicons",
		},
		priority = 1000,
		lazy = false,
		opts = {
			animate = { enabled = true },
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			dashboard = {
        width = 68,
				sections = {
					{
						section = "terminal",
						cmd = "colorscript -e space-invaders",
            height = 25,
            width = 68,
            gap = 1,
            padding = 0
					},
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
			debug = { enabled = true },
			dim = { enabled = true },
			explorer = { enabled = true },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			layout = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			picker = {
				win = {
					input = {
						keys = {
							["<a-c>"] = {
								"toggle_cwd",
								mode = { "n", "i" },
							},
						},
					},
				},
				actions = {
					---@param p snacks.Picker
					toggle_cwd = function(p)
						local current_buf = p.input.filter.current_buf
						local root = vim.fs.dirname(vim.api.nvim_buf_get_name(current_buf))
						local cwd = vim.fs.normalize(vim.fn.getcwd())
						local current = p:cwd()
						p:set_cwd(current == root and cwd or root)
						p:find()
					end,
				},
				enabled = true,
			},
			profiler = { enabled = true },
			quickfile = { enabled = true },
			rename = { enabled = true },
			scope = { enabled = true },
			scratch = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			toggle = { enabled = true },
			win = { enabled = true },
			words = { enabled = true },
			zen = { enabled = true },
		},
		keys = {
			{
				"<Leader>e",
				function()
					Snacks.explorer.open()
				end,
				desc = "Toggle file explorer",
			},
			{
				"<Leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<Leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<Leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<Leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<Leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<Leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<Leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<Leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<Leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<Leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit File History",
			},
			{
				"<Leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<Leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				"<Leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss Notifications",
			},
			{
				"<C-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
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
					vim.print = _G.dd -- Override print to use Snacks for inspection

					Snacks.toggle.animate():map("<leader>ua")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.dim():map("<leader>uD")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle
						.option(
							"conceallevel",
							{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
						)
						:map("<leader>uc")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle
						.option(
							"showtabline",
							{ off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
						)
						:map("<leader>uA")
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.profiler():map("<leader>dpp")
					Snacks.toggle.profiler_highlights():map("<leader>dph")
					Snacks.toggle.scroll():map("<leader>uS")
					Snacks.toggle.treesitter():map("<leader>uT")

					if vim.lsp.inlay_hint then
						Snacks.toggle.inlay_hints():map("<leader>uh")
					end
				end,
			})
		end,
	},
}
