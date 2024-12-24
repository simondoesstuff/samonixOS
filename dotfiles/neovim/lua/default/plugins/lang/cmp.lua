-- INFO: Includes plugins related to autocomplete, including LLM, snippets, etc
-- TODO: Make cmp menu more integrated with copilot, currently they overlap in strange ways
return {
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = 'rafamadriz/friendly-snippets',
		event = { "BufReadPre", "BufNewFile" },
		version = '*', -- release tag to download pre-built binaries

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			keymap = {
				preset = 'super-tab',
				['<C-space>'] = {}, -- disable so C-space is used for copilot
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono' -- mono vs normal
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			completion = {
				keyword = { range = 'full' },
				ghost_text = { enabled = true },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				auto_trigger = true,
				hide_during_completion = false,
				keymap = {
					accept = "<C-Space>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		},
	},
}
