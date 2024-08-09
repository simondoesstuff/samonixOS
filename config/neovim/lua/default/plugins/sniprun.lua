return {
	"michaelb/sniprun",
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	config = function()
		require("sniprun").setup({
			-- selected_intepreters = { 'Python3_fifo' },
			repl_enable = { "Python3_original" },

			live_mode_toggle = 'enable',
		});


		vim.keymap.set("n", "<leader>s", "", { desc = "sniprun" });
		vim.keymap.set("n", "<leader>sr", ":SnipRun<CR>", { desc = "sniprun run" });
		vim.keymap.set("n", "<leader>sl", ":SnipLive<CR>", { desc = "sniprun live mode" });
		vim.keymap.set("v", "f", ":SnipRun<CR>", { desc = "sniprun visual" });
	end,
}
