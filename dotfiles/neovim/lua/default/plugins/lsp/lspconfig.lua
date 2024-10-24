-- Controls the language servers for environments, and assists completion (cmp)

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "folke/neoconf.nvim", "folke/neodev.nvim", "hrsh7th/cmp-nvim-lsp", "aznhe21/actions-preview.nvim" },
		config = function()
			local lspconfig = require('lspconfig')


			lspconfig.lua_ls.setup {
				settings = {
					Lua = {
						workspace = {
							library = {
								-- Computer craft library
								"/Users/mason/dev/computercraft/ccls/library"
							}
						}
					}
				}
			}

			--WARNING: lspconfig.rust_analyzer.setup {} THIS IS CONFIGURED THROUGH rust.lua

			lspconfig.nixd.setup {}
			lspconfig.nil_ls.setup {}

			lspconfig.glsl_analyzer.setup {
				filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp", "fsh", "vsh" },
			}

			-- Web langauge servers
			lspconfig.tailwindcss.setup {}
			lspconfig.svelte.setup {}
			lspconfig.ts_ls.setup {}
			-- lspconfig.pyright.setup {} -- Python type checking and LS
			lspconfig.pylsp.setup {}
			lspconfig.dartls.setup {}

			lspconfig.clangd.setup {}


			--INFO: JSON/HTML/CSS (vscode-language-servers-extracted)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.html.setup { capabilities = capabilities }
			lspconfig.cssls.setup { capabilities = capabilities }
			lspconfig.jsonls.setup { capabilities = capabilities }

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
	}
}
