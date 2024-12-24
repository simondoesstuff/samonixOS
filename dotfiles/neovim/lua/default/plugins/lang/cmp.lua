-- Includes plugins related to autocomplete, including LLM, snippets, etc
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
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = 'super-tab' },

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

			completion = {
				keyword = { range = 'full' },
				ghost_text = { enabled = true },
			},
		},
		opts_extend = { "sources.default" }
	},
	{
		"github/copilot.vim",
	},
}
-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
-- 	config = function()
-- 		local status_ok, cmp = pcall(require, "cmp")
-- 		if not status_ok then
-- 			print("Status of the plugin nvim-cmp is not good.")
-- 			return
-- 		end
--
-- 		cmp.setup({
-- 			snippet = {
-- 				-- REQUIRED - you must specify a snippet engine
-- 				expand = function(args)
-- 					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
-- 				end,
-- 			},
-- 			window = {
-- 				-- completion = cmp.config.window.bordered(),
-- 				-- documentation = cmp.config.window.bordered(),
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 				["<C-e>"] = cmp.mapping.abort(),
-- 				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" }, -- For luasnip users.
-- 			}, {
-- 				{ name = "buffer" },
-- 			}),
-- 		})
-- 	end,
-- }
-- return {
-- 	{
-- 		"L3MON4D3/LuaSnip",
-- 		dependencies = { "rafamadriz/friendly-snippets" },
-- 		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
-- 		build = "make install_jsregexp",
-- 		config = function()
-- 			require("luasnip.loaders.from_vscode").lazy_load()
-- 		end
-- 	},
-- }
