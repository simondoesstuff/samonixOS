return {
	{
		"catppuccin/nvim",
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme catppuccin]])
			vim.cmd("highlight WinSeparator guifg=#EDC4E5 guibg=#171720")

			require("catppuccin").setup({
				integrations = {
					cmp = true,
					gitsigns = true,
					neotree = true,
					notify = true,
					treesitter = true,
					barbar = true,
					ufo = true,
					which_key = true,
					leap = true,
				},
			})
		end,
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
