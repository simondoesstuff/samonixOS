# This file stores all the sourcing of all non-nix configuration files

{
	xdg.configFile.nvim = {
		source = ../config/neovim;
		recursive = true;
	};

	xdg.configFile.wezterm = {
		source = ../config/wezterm;
		recursive = true;
	};
}
