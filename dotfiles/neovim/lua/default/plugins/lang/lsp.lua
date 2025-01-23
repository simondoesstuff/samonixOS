-- Controls the language servers for environments, and assists completion (cmp)
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "folke/neoconf.nvim", "folke/neodev.nvim", "aznhe21/actions-preview.nvim", 'saghen/blink.cmp' },
		opts = {
			servers = {
				-- Config
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								library = {
									"/Users/mason/dev/computercraft/ccls/library" -- Computercraft lib
								}
							}
						}
					}
				},
				nixd = {},
				nil_ls = {},
				-- Webdev
				tailwindcss = {},
				svelte = {},
				ts_ls = {},
				html = {},
				cssls = {},
				jsonls = {},
				-- Graphics
				glsl_analyzer = {
					filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp", "fsh", "vsh" },
					on_attach = function(client, _)
						client.cancel_request = function(_, _) end -- do nothing avoiding error message
					end
				},
				-- Other
				pylsp = {},
				dartls = {},
				clangd = {},
				sourcekit = {},
				--WARNING: rust_analyzer = {} --> unnecessary, configured in rustaceanvim below
			}
		},
		config = function(_, opts)
			local lspconfig = require('lspconfig')
			for server, config in pairs(opts.servers) do
				config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = false,
				severity_sort = true,
				update_in_insert = false,
			})

			-- vim.o.updatetime = 250
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.supports_method("textDocument/completion") then
						vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
					end
					if client.supports_method("textDocument/definition") then
						vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
					end
					--INFO: LSP keybinds defined here
					vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "see declaration" })
					vim.keymap.set("n", "<leader>lK", vim.lsp.buf.hover, { buffer = bufnr, desc = "hover action" })
					vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = bufnr, desc = "see definition" })
					vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = bufnr, desc = "see implementation" })
					vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "type definition" })
					vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = bufnr, desc = "rename symbol" })
					vim.keymap.set("n", "<leader>la", require("actions-preview").code_actions,
						{ buffer = bufnr, desc = "code action menu" })

					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = bufnr, desc = "references" })
					vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end,
						{ buffer = bufnr, desc = "diagnostics float" })
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "hover action" })
				end,
			})
		end,
	},
	{
		"aznhe21/actions-preview.nvim", -- Preview menu for code actions
		opts = {
			telescope = require("telescope.themes").get_dropdown {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				winblend = 10,
				layout_config = {
					-- anchor = "CENTER",  -- vertically and horizontally
					width = 0.8,
					height = 0.9,
					prompt_position = "top",
					preview_cutoff = 25,
					preview_height = function(_, _, max_lines)
						return max_lines - 25
					end,
				},
			},
		},
	},
	{
		"j-hui/fidget.nvim", -- Fidget spinner showing lsp processes
		tag = "legacy",    -- To avoid breaking changes
		config = function()
			require("fidget").setup({})
		end,
	},
	{
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
					on_attach = function(_, _) -- client, bufnr args
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
					autoload_configurations = true
				},
			}
		end
	}
}
