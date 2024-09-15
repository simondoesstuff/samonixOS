-- Amplifies the git integration of edits and additions
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		-- animation = true,
		-- insert_at_start = true,
		-- …etc.
	},
}
