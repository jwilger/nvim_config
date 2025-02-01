return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
				end,
				mode = "n",
				desc = "Format buffer",
			},
			{
				"<leader>cF",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
			},
			-- These options will be merged with the builtin formatters.
			-- You can also define any custom formatters here.
			formatters = {
				injected = { options = { ignore_errors = true } },
				-- Example: Use dprint only if a dprint.json file is present:
				-- dprint = {
				--   condition = function(ctx)
				--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
				--   end,
				-- },
				-- Example: Use shfmt with extra args:
				-- shfmt = {
				--   prepend_args = { "-i", "2", "-ci" },
				-- },
			},
		},
		config = function(_, opts)
			-- Initialize conform with the provided options.
			require("conform").setup(opts)

			-- Define a user command to format the current buffer.
			-- This replaces LazyVim.format.register functionality.
			vim.api.nvim_create_user_command("FormatBuffer", function()
				require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { desc = "Format current buffer using conform.nvim" })
		end,
	},
}
