return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = { "lua", "c", "cpp", "rust", "python", "bash", "json", "yaml", "toml", "html", "css", "javascript", "typescript", "tsx", "regex", "comment" },

				ignore_install = { "zig" }, -- was erroring 9/14/2024 (mason)

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				highlight = { enable = true },

				-- Automatically install missing parsers when entering buffer
				auto_install = true,


			})

			-- enable glsl syntax highlighting on .vsh and .fsh files
			vim.treesitter.language.register("glsl", { "vsh", "fsh" })

			-- Make it so vsh is detected as vsh and not .conf for whatever reason
			vim.api.nvim_create_autocmd({ 'BufRead', "BufNewFile" }, {
				pattern = '*.vsh',
				command = 'set filetype=vsh',
				group = vim.api.nvim_create_augroup('vsh_filetype', { clear = true })
			})
		end,
	},
}
-- {
-- 	-- "nvim-treesitter/playground", -- Note, only works on nightly nvim
-- },
