{ pkgs,... }:
{
	nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord
	nixpkgs.config.permittedInsecurePackages = [
		"electron-25.9.0" # Required for obsidian
	];

	home.packages = with pkgs; (
		# General packages for system-wide use
		[
			fira-code-nerdfont # decent nerd font
			neofetch # Show os info and such

			# Used in neovim telescope, as well as just generally useful
			ripgrep # Fast grep
			fd # Advanced find
		]

		# Personal systen packages 
		++ [
			obsidian # MD note taker editor
			git-lfs # Large file storage for git, used in obsidian notes
			discord # Voicechat and social app
		]
	);
}
