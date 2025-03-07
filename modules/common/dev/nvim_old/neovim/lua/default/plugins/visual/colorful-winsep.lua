return {
	"nvim-zh/colorful-winsep.nvim",
	config = function()
		require("colorful-winsep").setup({
			-- Winsep color
			highlight = {
				bg = "#171720",
				fg = "#EDC4E5",
			},
			no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
			-- Symbols: hor, vert, top left, top right, bot left, bot right.
			symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
		})
	end,
	event = { "WinNew" },
	init = function()
		vim.cmd("highlight WinSeparator guifg=#EDC4E5")
	end,
}
