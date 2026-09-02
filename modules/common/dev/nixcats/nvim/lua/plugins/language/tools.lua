-- Tools is for any language specific "tools" that don't get covered by the braod
-- language server, formatter, etc.
return {
	{
		"ajbucci/ipynb.nvim",
		ft = "ipynb",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	-- optimized rust experience (LSP, DAP, respect vscode conf analyzer options, etc)
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},
}
