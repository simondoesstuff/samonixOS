local function map(m, k, v, d)
	d = d or "" -- description, optional parameter
	vim.keymap.set(m, k, v, { silent = true, desc = d ~= "" and d or nil })
end

local leader = nixCats("binds.leader")
map("", leader, "<Nop>")
vim.g.mapleader = leader
vim.g.maplocalleader = leader

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-----------------
-- Normal mode --
-----------------
map("n", "j", "gj") -- Move through visual lines instead of logical lines
map("n", "k", "gk")
map("n", "gj", "j") -- Map inverse
map("n", "gk", "k")



-- clear highlights
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr><esc>", {
	silent = true,
	noremap = true,
	nowait = true,
	desc = "Clear search highlight",
})

map("n", nixCats("binds.new_file"), "<cmd>new<cr>", "New file") -- Make new file
map("n", nixCats("binds.change_dir"), "<cmd>cd %:h<cr>", "Change to file directory") -- Change directory
map("n", nixCats("binds.close_window"), "<cmd>close<cr>", "close window")

-- System interaction keymaps
map("n", nixCats("binds.system.reveal_file"), function()
	local file = vim.fn.expand("%:p")
	if vim.fn.filereadable(file) ~= 1 then
		vim.notify("No file to reveal", vim.log.levels.WARN)
		return
	end

	local sysname = vim.loop.os_uname().sysname
	local cmd
	if sysname == "Darwin" then
		cmd = 'open -R "' .. file .. '"'
	elseif sysname == "Windows_NT" then
		-- On Windows, we need to escape backslashes for the shell
		local escaped_file = file:gsub("\\", "\\\\")
		cmd = 'explorer /select,"' .. escaped_file .. '"'
	else -- Linux
		local dir = vim.fn.fnamemodify(file, ":h")
		cmd = 'xdg-open "' .. dir .. '"'
	end
	os.execute(cmd)
end, "Reveal in system explorer")

map("n", nixCats("binds.system.copy_file_path"), function()
	local file = vim.fn.expand("%:p")
	if file == "" or vim.fn.filereadable(file) ~= 1 then
		vim.notify("No file path to copy", vim.log.levels.WARN)
		return
	end

	local sysname = vim.loop.os_uname().sysname
	local copy_cmd

	if sysname == "Darwin" then
		copy_cmd = 'echo "' .. file .. '" | pbcopy'
	elseif sysname == "Windows_NT" then
		copy_cmd = "echo " .. file .. " | clip"
	else -- Linux
		if vim.fn.executable("wl-copy") == 1 then
			copy_cmd = 'echo "' .. file .. '" | wl-copy'
		elseif vim.fn.executable("xclip") == 1 then
			copy_cmd = 'echo "' .. file .. '" | xclip -selection clipboard'
		else
			vim.notify("No clipboard utility (wl-copy or xclip) found", vim.log.levels.ERROR)
			return
		end
	end

	os.execute(copy_cmd)
	vim.notify("Copied: " .. file)
end, "Copy system file path")

map("n", nixCats("binds.system.open_file"), function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file to open", vim.log.levels.WARN)
		return
	end

	-- Convert file path to URL (file:// protocol) and encode spaces
	local url = "file://" .. file:gsub(" ", "%%20")
	local sysname = vim.loop.os_uname().sysname
	local open_cmd

	if sysname == "Darwin" then
		open_cmd = 'open "' .. url .. '"'
	elseif sysname == "Windows_NT" then
		open_cmd = 'start "" "' .. url .. '"'
	else -- Linux
		if vim.fn.executable("xdg-open") == 1 then
			open_cmd = 'xdg-open "' .. url .. '"'
		else
			vim.notify("No browser opener (xdg-open) found", vim.log.levels.ERROR)
			return
		end
	end

	local ok, _, code = vim.fn.system(open_cmd)
	if ok == 0 then
		vim.notify("Opened: " .. file)
	else
		vim.notify("Failed to open (exit code: " .. code .. ")", vim.log.levels.ERROR)
	end
end, "Open with system")

map("n", nixCats("binds.system.copy_file"), function()
	local file = vim.fn.expand("%:p")
	if file == "" or vim.fn.filereadable(file) ~= 1 then
		vim.notify("No valid file to copy", vim.log.levels.WARN)
		return
	end

	local sysname = vim.loop.os_uname().sysname
	local cmd

	if sysname == "Darwin" then
		cmd = "osascript -e 'set the clipboard to (POSIX file \"" .. file .. "\")'"
	elseif sysname == "Windows_NT" then
		cmd = "powershell.exe -Command \"Set-Clipboard -Path '" .. file .. "'\""
	else -- Linux
		if vim.fn.executable("wl-copy") == 1 then
			cmd = "printf 'file://" .. file .. "' | wl-copy --type text/uri-list"
		elseif vim.fn.executable("xclip") == 1 then
			cmd = "printf 'file://" .. file .. "' | xclip -selection clipboard -t text/uri-list"
		else
			vim.notify("Clipboard file copy unsupported on this platform", vim.log.levels.ERROR)
			return
		end
	end

	os.execute(cmd)
	vim.notify("Copied file reference to clipboard")
end, "Copy file to clipboard")

-----------------
-- Visual mode --
-----------------
map("v", "p", '"_dP') -- When pasting over a selection, don't copy the selected text
map("v", "<", "<gv") -- Indent selection and stay in visual mode
map("v", ">", ">gv") -- Dedent selection and stay in visual mode

-----------------
-- Insert mode --
-----------------
-- Add mappings for insert mode here if needed

-------------------
-- Terminal mode --
-------------------
map("t", "<esc>", [[<C-\><C-n>]]) -- Exit terminal mode
map("t", "<C-w>", [[<C-\><C-n><C-w>]], "terminal window command")
map("t", nixCats("binds.close_window"), "<cmd>close<cr>", "close window")
