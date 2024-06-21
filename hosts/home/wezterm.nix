{
	programs.wezterm.enable = true;

	# Source wezterm dotfile directly 
	xdg.configFile.wezterm = {
		source = ../../config/wezterm;
		recursive = true;
	}; 
}
