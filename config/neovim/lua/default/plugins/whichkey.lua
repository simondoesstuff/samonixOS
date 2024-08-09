return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		-- preset = "helix",
		win = {
			no_overlap = true,
			border = "single",
			padding = { 0, 2 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
			-- Additional vim.wo and vim.bo options
			bo = {},
			wo = {
				winblend = 33, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
		icons = { mappings = false }, -- no mapping icons
		spec = {
			{ "<leader>f",        group = "file" },
			{ "<leader><leader>", group = "swap windows" },
			{ "<leader>b",        group = "buffer" },
			{ "<leader>c",        group = "change" },
			{ "<leader>l",        group = "lsp" },
			{ "<leader>d",        group = "debug" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false }) -- buffer local
			end,
			desc = "which-key maps",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Add rust cargo when in rust
		vim.cmd("autocmd FileType rust lua WhichKeyRust()")
		function WhichKeyRust()
			wk.register({
				C = { name = "cargo" },
			}, { prefix = "<leader>" })
		end
	end,
}
