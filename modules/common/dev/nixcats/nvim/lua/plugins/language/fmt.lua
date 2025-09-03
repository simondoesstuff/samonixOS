return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			bash = { "shfmt", "shellcheck", stop_after_first = true },
			css = { "prettierd" },
			hbs = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			lua = { "stylua" },
			nix = { "nixfmt" },
			python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			svelte = { "prettierd" }, -- set up https://github.com/sveltejs/prettier-plugin-svelte for formatting to work
			markdown = { "prettierd" },
			yaml = { "prettierd" },
			sh = { "shfmt", "shellcheck", stop_after_first = true },
			rust = { "rustfmt" },
			toml = { "taplo" },
			java = { "google-java-format" },
			zig = { "zigfmt" },

			["*"] = { "codespell" }, -- Applies to all files
			["_"] = {
				"trim_whitespace", -- Applies to files with no preset formatter
			},
		},
	},
}
