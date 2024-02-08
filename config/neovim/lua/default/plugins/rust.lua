return {
	'mrcjkb/rustaceanvim',
	version = '^4', -- Recommended
	ft = { 'rust' },
	config = function()
		vim.g.rustaceanvim = {
			-- Plugin configuration
			tools = {
			},
			-- LSP configuration
			server = {
				on_attach = function(client, bufnr)
					-- you can also put keymaps in here
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					['rust-analyzer'] = {
						files = {
							excludeDirs = {
								".direnv/*",
								".direnv",
								".git",
								"target",
							},
							watcherExclude = {
								".direnv/*",
								".direnv",
								".git",
								"target",
							}
						}
					},
				},
			},
			-- DAP configuration
			dap = {
			},
		}
	end
}
