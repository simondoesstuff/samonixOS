return {
	'mfussenegger/nvim-dap',
	config = function()
		-- Rust setup
		-- local dap = require('dap')
		-- dap.adapters.lldb = {
		-- 	type = 'executable',
		-- 	command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
		-- 	name = 'lldb'
		-- }
		-- -- Rust config
		-- dap.configurations.rust = {
		-- 	{
		-- 		name = 'Launch',
		-- 		type = 'lldb',
		-- 		request = 'launch',
		-- 		program = function()
		-- 			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		-- 		end,
		-- 		cwd = '${workspaceFolder}',
		-- 		stopOnEntry = false,
		-- 		args = {},
		--
		-- 		-- 💀
		-- 		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		-- 		--
		-- 		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		-- 		--
		-- 		-- Otherwise you might get the following error:
		-- 		--
		-- 		--    Error on launch: Failed to attach to the target process
		-- 		--
		-- 		-- But you should be aware of the implications:
		-- 		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- 		-- runInTerminal = false,
		-- 		-- ... the previous config goes here ...,
		-- 		initCommands = function()
		-- 			-- Find out where to look for the pretty printer Python module
		-- 			local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
		--
		-- 			local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
		-- 			local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
		--
		-- 			local commands = {}
		-- 			local file = io.open(commands_file, 'r')
		-- 			if file then
		-- 				for line in file:lines() do
		-- 					table.insert(commands, line)
		-- 				end
		-- 				file:close()
		-- 			end
		-- 			table.insert(commands, 1, script_import)
		--
		-- 			return commands
		-- 		end,
		-- 	},
		-- }

		vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>",
			{ silent = true, desc = "debug breakpoint" })
		vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>",
			{ silent = true, desc = "debug continue" })
		vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_over()<CR>",
			{ silent = true, desc = "debug step over" })
		vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>",
			{ silent = true, desc = "debug step into" })
		vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>",
			{ silent = true, desc = "debug open repl" })
	end
}
