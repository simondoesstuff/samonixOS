return {
	"kawre/leetcode.nvim",
	cmd = "Leet", -- Lazy load on leet command
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "python3",
	},
	config = function()
		local leetcode = require("leetcode");
		leetcode.setup({
			lang = "python3",
		})

		vim.cmd("Copilot disable")

		vim.keymap.set("n", "<leader>L", " ", { desc = "Leet" })
		vim.keymap.set("n", "<leader>Ll", "<cmd>Leet lang<cr>", { desc = "Leet lang" })
		vim.keymap.set("n", "<leader>Lc", "<cmd>Leet console<cr>", { desc = "Leet console" })
		vim.keymap.set("n", "<leader>Lt", "<cmd>Leet test<cr>", { desc = "Leet test" })
		vim.keymap.set("n", "<leader>Ls", "<cmd>Leet submit<cr>", { desc = "Leet submit" })
		vim.keymap.set("n", "<leader>Lr", "<cmd>Leet run<cr>", { desc = "Leet run" })
		vim.keymap.set("n", "<leader>Li", "<cmd>Leet info<cr>", { desc = "Leet info" })
		vim.keymap.set("n", "<leader>Ld", "<cmd>Leet desc<cr>", { desc = "Leet desc" })
		vim.keymap.set("n", "<leader>Lp", "<cmd>Leet list<cr>", { desc = "Leet problem list" })
	end
}
