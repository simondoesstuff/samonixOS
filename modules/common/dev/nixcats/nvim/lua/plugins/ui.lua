return {
	{
		"sschleemilch/slimline.nvim",
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
		"levouh/tint.nvim",
		opts = {
			tint = -10,
			saturation = 0.5,
			tint_background_colors = true, -- Tint background portions of highlight groups
			-- highlight_ignore_patterns = { "WinSeparator" }, -- Highlight group patterns to ignore, see `string.find`
			window_ignore_function = function(winid)
				local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ""

				-- Next, get the buffer name associated with the window
				local bufid = vim.api.nvim_win_get_buf(winid)
				local bufname = vim.api.nvim_buf_get_name(bufid)

				-- Check if the buffer name contains "FloatermSidebar"
				local is_floaterm_sidebar = string.find(bufname, "FloatermSidebar", 1, true)

				return is_floating or is_floaterm_sidebar
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
