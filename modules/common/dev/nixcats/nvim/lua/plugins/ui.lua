return {
	{
		"sschleemilch/slimline.nvim",
		name = "slimline-nvim", -- required for nixcats to recognize
		init = function()
			vim.cmd("highlight Slimline guifg=#101012 guibg=#101012")
		end,
		opts = {},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			presets = {
				command_palette = true,
				inc_rename = true,
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"levouh/tint.nvim",
		opts = {
			tint = -15, -- Darken colors, use a positive value to brighten
			saturation = 0.1, -- Saturation to preserve
			transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
			tint_background_colors = true, -- Tint background portions of highlight groups
			-- highlight_ignore_patterns = { "WinSeparator" }, -- Highlight group patterns to ignore, see `string.find`
			window_ignore_function = function(winid)
				local bufid = vim.api.nvim_win_get_buf(winid)
				local buftype = vim.bo[bufid].buftype
				local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

				-- Do not tint floating windows, tint everything else
				return buftype == floating
			end,
		},
		init = function()
			-- Fixes issues where closing a toggleterm like lazygit
			-- results in every viewed buffer being tinted
			vim.api.nvim_create_autocmd("TermClose", {
				desc = "Untint terminal window on close",
				callback = function()
					vim.defer_fn(function()
						require("tint").untint(vim.api.nvim_get_current_win())
					end, 10)
				end,
			})
		end,
	},
}
