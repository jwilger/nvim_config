return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "giuxtaposition/blink-cmp-copilot" },
		},

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "enter" },
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
					border = "rounded",
					winblend = 10,
				},
				documentation = {
					window = {
						border = "single",
					},
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer" },

				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			signature = { enabled = true, window = { border = "single" } },
			snippets = { preset = "default" },
		},
		opts_extend = { "sources.default" },
	},
	"saghen/blink.compat", -- For compatibility with other plugins
}
