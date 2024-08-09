-- Controls the language servers for environments, and assists completion (cmp)

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "folke/neoconf.nvim", "folke/neodev.nvim", "hrsh7th/cmp-nvim-lsp" },
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
			lspconfig.glsl_analyzer.setup {
				filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp", "fsh", "vsh" },
			}

			-- Web langauge servers
			lspconfig.tailwindcss.setup {}
			lspconfig.svelte.setup {}
			lspconfig.tsserver.setup {}
			-- lspconfig.pyright.setup {} -- Python type checking and LS
			lspconfig.pylsp.setup {}
			lspconfig.dartls.setup {}


			--INFO: JSON/HTML/CSS (vscode-language-servers-extracted)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.html.setup { capabilities = capabilities }
			lspconfig.cssls.setup { capabilities = capabilities }
			lspconfig.jsonls.setup { capabilities = capabilities }

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				severity_sort = true,
				update_in_insert = false,
			})

			-- Following lines are from : https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
			-- You will likely want to reduce updatetime which affects CursorHold
			-- note: this setting is global and should be set only once
			-- Hover
			-- vim.o.updatetime = 250
			-- vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])

			-- LSP keybinds
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set(
						"n",
						"<leader>lD",
						vim.lsp.buf.declaration,
						{ buffer = ev.buf, desc = "see declaration" }
					)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover action" })
					vim.keymap.set("n", "<leader>lK", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover action" })
					vim.keymap.set(
						"n",
						"<leader>ld",
						vim.lsp.buf.definition,
						{ buffer = ev.buf, desc = "see definition" }
					)
					vim.keymap.set(
						"n",
						"<leader>li",
						vim.lsp.buf.implementation,
						{ buffer = ev.buf, desc = "see implementation" }
					)

					vim.keymap.set(
						"n",
						"<leader>lt",
						vim.lsp.buf.type_definition,
						{ buffer = ev.buf, desc = "type definition" }
					)
					vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename symbol" })
					vim.keymap.set(
						"n",
						"<leader>la",
						vim.lsp.buf.code_action,
						{ buffer = ev.buf, desc = "code action" }
					)
					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf, desc = "references" })
					vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float(), { buffer = ev.buf, desc = "diagnostics float" })
				end,
			})

			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end,
	},
	{
		"j-hui/fidget.nvim", -- Fidget spinner showing lsp processes
		tag = "legacy",    -- To avoid breaking changes
		config = function()
			require("fidget").setup({})
		end,
	},
}
