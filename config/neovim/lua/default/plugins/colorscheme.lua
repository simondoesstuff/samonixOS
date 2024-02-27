return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,  -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.cmd([[colorscheme catppuccin]])
	-- 		vim.cmd("highlight WinSeparator guifg=#EDC4E5 guibg=#171720")
	--
	-- 		require("catppuccin").setup({
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				neotree = true,
	-- 				notify = true,
	-- 				treesitter = true,
	-- 				barbar = true,
	-- 				ufo = true,
	-- 				which_key = true,
	-- 				leap = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{
		"catppuccin/nvim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
			vim.cmd("highlight WinSeparator guifg=#EDC4E5 guibg=#171720")
		end,
		opts = {
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
	},

	{
		"folke/tokyonight.nvim",
		lazy = true, -- Load 2nd scheme, so it can be selected
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- Load 2nd scheme, so it can be selected
	},
}
