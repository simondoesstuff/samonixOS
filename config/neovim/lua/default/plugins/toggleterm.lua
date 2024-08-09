return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local Terminal    = require('toggleterm.terminal').Terminal

		--INFO: Terminals
		local togglefloat = Terminal:new({
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
			end,
		})

		local lazygit     = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				-- Add q for quitting, and double escape to go back to normal mode if I ever need that for some reason
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc><esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

				-- Allow ctrl+c and esc to work as expected in lazygit
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-c>", "<esc>", { noremap = true, silent = true })
			end,
			on_close = function()
				vim.cmd("startinsert!")
			end,
		})

		local ollama      = Terminal:new({
			cmd = "ollama serve",
			dir = "git_dir",
			direction = "float",
			start_in_insert = false,
			close_on_exit = false,
			on_create = function()
				vim.cmd("stopinsert")
			end,
			on_open = function(term)
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
			end,
			on_exit = function(term, code)
				if code == 0 then
					vim.cmd("q!") -- Close the terminal if it exits successfully
				else
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>q!<CR>", { noremap = true, silent = true })
				end
			end,
		})

		local hm_switch   = Terminal:new({
			cmd = "home-manager switch",
			dir = "git_dir",
			direction = "float",
			start_in_insert = false,
			close_on_exit = false, -- Keep term open in case of error
			on_create = function()
				vim.cmd("stopinsert")
			end,
			on_open = function(term)
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				-- Kill the terminal with Q
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
			end,
			on_exit = function(term, code)
				if vim.api.nvim_get_current_buf() ~= term.bufnr then -- If buffer is not being displayed
					vim.notify("Home Manager switch complete with exit code: " .. code)
					pcall(vim.api.nvim_buf_delete, term.bufnr, { force = true })
				else
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>q!<CR>", { noremap = true, silent = true })
				end
			end,
		})

		local spotify     = Terminal:new({
			cmd = "spotify_player",
			dir = "git_dir",
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-d>", "<C-c>", { silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { noremap = true, silent = true })
			end,
		})

		local flutter_run = Terminal:new({
			cmd = "flutter run",
			dir = "git_dir",
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "Q", "<cmd>q!<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-d>", "<C-c>", { silent = true })
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { noremap = true, silent = true })
			end,
		})

		--  INFO: Global functions
		function _ToggleTerm()
			togglefloat:toggle()
		end

		function _Lazygit_Toggle()
			lazygit:toggle()
		end

		function _Ollama_Toggle()
			ollama:toggle()
		end

		function _HomeManagerSwitch()
			hm_switch:toggle()
		end

		function _Spotify_Toggle()
			spotify:toggle()
		end

		function _FlutterRun()
			flutter_run:toggle()
		end

		--  INFO: Toggle keymaps
		vim.api.nvim_set_keymap("n", "<leader>t", "<leader>t",
			{ noremap = true, silent = true, desc = "toggle terms" })

		vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _ToggleTerm()<CR>",
			{ noremap = true, silent = true, desc = "floating term" })

		vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>lua _Lazygit_Toggle()<CR>",
			{ noremap = true, silent = true, desc = "lazygit term" })

		vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>lua _Ollama_Toggle()<CR>",
			{ noremap = true, silent = true, desc = "ollama serve term" })

		vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _HomeManagerSwitch()<CR>",
			{ noremap = true, silent = true, desc = "hm switch term" })

		vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _Spotify_Toggle()<CR>",
			{ noremap = true, silent = true, desc = "spotify term" })

		vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _FlutterRun()<CR>",
			{ noremap = true, silent = true, desc = "flutter run term" })
	end
}
