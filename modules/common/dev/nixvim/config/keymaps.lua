local function map(m, k, v, d)
	d = d or "" -- description, optional parameter
	vim.keymap.set(m, k, v, { silent = true, desc = d ~= "" and d or nil })
end

local unmap = vim.keymap.del

--  INFO: Leader ""
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  INFO: Normal "n"
map("n", "j", "gj")                                          -- Move through visual lines instead of logical lines
map("n", "k", "gk")
map("n", "<leader>fn", "<cmd>enew<cr>", "New file")          -- Make new file
map("n", "<leader>cd", "<cmd>cd %:h<cr>", "change file dir") -- Format mapping

--  INFO: Insert "i"

-- map("i", "jk", "<esc>") -- Map jk to escape

-- map("n", "<C-,>", "<cmd>bprevious<cr>", "Navigate back") -- Navigate back buffer like in obsidian

--  INFO: Visual "v"

-- map("v", "
-- map("v", "<A-j>", ":m .+1<CR>==")
map("v", "p", '"_dP') -- When pasting, don't cut text pasted over

--  INFO: Terminal "t"
map('t', '<esc>', [[<C-\><C-n>]]) -- Exit terminal mode into normal
-- -- Having this keybind makes normal j navigationi n terminal slow
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
map('t', '<C-w>', [[<C-\><C-n><C-w>]])


--  INFO: Visual block "x"

--  INFO: Command "c"
