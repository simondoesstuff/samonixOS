-- INFO: Includes plugins related to autocomplete, including LLM, snippets, etc
-- TODO: Make cmp menu more integrated with copilot, currently they overlap in strange ways
return {
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets', 'giuxtaposition/blink-cmp-copilot', 'zbirenbaum/copilot.lua' },
		event = { "BufReadPre", "BufNewFile" },
		version = '*', -- release tag to download pre-built binaries
		opts = {
			keymap = {
				preset = 'super-tab', -- tab to accept
				['<C-h>'] = { function(cmp) cmp.hide() end },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono', -- mono vs normal
				kind_icons = {
					Copilot = "",
					Text = '󰉿',
					Method = '󰊕',
					Function = '󰊕',
					Constructor = '󰒓',

					Field = '󰜢',
					Variable = '󰆦',
					Property = '󰖷',

					Class = '󱡠',
					Interface = '󱡠',
					Struct = '󱡠',
					Module = '󰅩',

					Unit = '󰪚',
					Value = '󰦨',
					Enum = '󰦨',
					EnumMember = '󰦨',

					Keyword = '󰻾',
					Constant = '󰏿',

					Snippet = '󱄽',
					Color = '󰏘',
					File = '󰈔',
					Reference = '󰬲',
					Folder = '󰉋',
					Event = '󱐋',
					Operator = '󰪚',
					TypeParameter = '󰬛',
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
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
				},
			},

			completion = {
				keyword = { range = 'prefix' }, -- full looks ahead for fuzzy matching
				ghost_text = { enabled = true },
				menu = {
					border = 'single',
					draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } } }
				},
			},
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			require('blink.cmp').setup(opts)
			-- Hide copilot suggestions when the completion menu is opened
			vim.api.nvim_create_autocmd('User', {
				pattern = 'BlinkCmpCompletionMenuOpen',
				callback = function()
					require("copilot.suggestion").dismiss()
				end,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			-- INFO: Use ctrl + space to access cmp menu and select copilot ghost text
			suggestion = { enabled = false, auto_trigger = true, },
			panel = { enabled = false },
		},
	},
}
