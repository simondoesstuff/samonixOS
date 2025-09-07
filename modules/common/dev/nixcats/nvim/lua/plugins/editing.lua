return {
	{
		"smjonas/inc-rename.nvim",
		dependencies = { "folke/snacks.nvim", "folke/noice.nvim" },
		opts = {},
		keys = {
			{
				nixCats('binds.editing.rename'),
				":IncRename ",
				desc = "inc rename [cword]",
			},
		},
	},
	{
		"romgrk/barbar.nvim", -- file "tabs"
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			auto_hide = 1, -- Hide if 1 or less tabs
			icons = {
				separator = { left = "┃", right = "" },
				separator_at_end = false,
				button = false,
			},
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout", text = "file tree" },
			},
		},
		keys = {
			{
				nixCats('binds.editing.buffer_close'),
				"<cmd>BufferClose!<cr>",
				desc = "close buffer",
			},
			{
				nixCats('binds.editing.buffer_previous'),
				"<cmd>BufferPrevious<cr>",
				mode = { "n", "t" },
				desc = "previous buffer",
			},
			{
				nixCats('binds.editing.buffer_next'),
				"<cmd>BufferNext<cr>",
				mode = { "n", "t" },
				desc = "next buffer",
			},
			{
				nixCats('binds.editing.buffer_move_next'),
				"<cmd>BufferMoveNext<cr>",
				mode = { "n", "t" },
				desc = "move buffer to next",
			},
			{
				nixCats('binds.editing.buffer_move_previous'),
				"<cmd>BufferMovePrevious<cr>",
				mode = { "n", "t" },
				desc = "move buffer to previous",
			},
		},
	},
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- WARNING: warning warnging WARNING
		-- FIX: fix fix fix fix fix  FIX
		-- TODO: do todo something   TODO
		-- HACK: hack something hack HACK
		-- INFO: SOME INFORMATION    INFO
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
