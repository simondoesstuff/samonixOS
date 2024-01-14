# Contains all terminal and shell related configuarion
{
	programs.wezterm = { # The terminal emulator
		enable = true;
	};

	programs.zsh = { # To set zsh as default shell must be set by system
		enable = true;
		syntaxHighlighting.enable = true;
	};

	programs.starship = { # The nice looking shell prompt
		enable = true;
	};
}
