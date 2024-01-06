
{ config, pkgs, ... }:

# Contains all shell related configuarion

{
	programs.starship = {
		enable = true;
	};

	programs.zsh = { # To set zsh as default shell must be set by system
		enable = true;
	};
}
