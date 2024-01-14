# Contains all terminal and shell related configuarion
{
	programs.wezterm = { # The terminal emulator
		enable = true;
	};

	xdg.configFile.wezterm = {
		source = ../config/wezterm;
		recursive = true;
	}; # Source wezterm config as a dotfile

	programs.zsh = { # To set zsh as default shell must be set by system
		enable = true;
		syntaxHighlighting.enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
	};

	programs.starship = { # The nice looking shell prompt
		enable = true;
	};
}
