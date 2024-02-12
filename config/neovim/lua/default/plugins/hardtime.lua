-- lazy.nvim
return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		-- disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
		-- Remove <Up> keys and append <Space> to the disabled_keys
		-- disabled_keys = {
		-- 	["<Up>"] = {},
		-- 	["<Space>"] = { "n", "x" },
		-- },
	}
}
