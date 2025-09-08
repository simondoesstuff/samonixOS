-- return {
-- 	"rmagatti/auto-session",
-- 	lazy = false,
--
-- 	---enables autocomplete for opts
-- 	---@module "auto-session"
-- 	---@type AutoSession.Config
-- 	opts = {
-- 		suppressed_dirs = { "~/", "~/Downloads", "/" },
-- 	},
-- }

-- return {
-- 	"folke/persistence.nvim",
-- 	event = "VimEnter", -- this will only start session saving when the the directory is opened
-- 	opts = {},
-- 	vim.api.nvim_create_autocmd("VimEnter", {
-- 		callback = function()
-- 			require("persistence").setup({})
-- 			require("persistence").load({ last = true })
-- 		end,
-- 	}),
-- }

-- Lu-- Lua
return {
	"folke/persistence.nvim",
	-- event = "BufReadPre",
	lazy = false,
	opts = {
		-- add any custom options here
	},
}
