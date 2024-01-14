{ pkgs,... }:

{
	home.packages = with pkgs; (
		# General packages
		[
			fira-code-nerdfont # decent nerd font
			lazygit # TUI git client
			neovim # text editor
			neofetch # Show os info and such
		]

	);
}
