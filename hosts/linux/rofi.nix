{

	# Source neovim/wezterm custom (non-nix) config
	xdg.configFile.rofi = {
		source = ../config/rofi;
		recursive = true;
	};
}
