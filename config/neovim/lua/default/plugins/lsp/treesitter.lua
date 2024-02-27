-- return {}
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = "all",
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				highlight = { enable = true },

				-- Automatically install missing parsers when entering buffer
				auto_install = true,
			})
		end,
	},
}
-- 	{
-- 		-- "nvim-treesitter/playground", -- Note, only works on nightly nvim
-- 	},
-- }
