{ #INFO: This stores all the sourcing for external non-nix dotfiles
	xdg.configFile.nvim = {
		source = ../config/neovim;
		recursive = true;
	}; # Source neovim config

	xdg.configFile.wezterm = {
		source = ../config/wezterm;
		recursive = true;
	}; # Source wezterm config
}
