return {
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"tsx",
			"jsx",
			"xml",
		},
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
			-- basic WESL support until tooling (wgsl analyzer) is more advanced.
			vim.treesitter.language.register("wgsl", "wesl")
			vim.filetype.add({
				extension = {
					wesl = "wesl",
				},
			})
		end,
	},
}
