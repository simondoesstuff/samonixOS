{ pkgs,... }:

{
	home.packages = with pkgs; (
		# General packages
		[
			fira-code-nerdfont # decent nerd font
			neovim # text editor
			neofetch # Show os info and such
			# docker
		]
	);

	xdg.configFile.nvim = {
		source = ../config/neovim;
		recursive = true;
	}; # Source neovim config
}
