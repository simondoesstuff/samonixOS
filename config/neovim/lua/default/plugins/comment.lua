return {
	"NumToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local status_ok, comment = pcall(require, "Comment")
		if not status_ok then
			vim.notify("Comment failed to initialize.")
			return
		end

		comment.setup()
	end,
}
