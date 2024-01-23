{ pkgs,... }:
{
	nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord
	nixpkgs.config.permittedInsecurePackages = [
		"electron-25.9.0" # Required for obsidian for some reason
	];

	home.packages = with pkgs; (
		# General packages
		[
			fira-code-nerdfont # decent nerd font
			neofetch # Show os info and such
			# docker
		]

		# Personal stuff
		++ [
			obsidian # MD note taker editor
			discord # Voicechat and social app
		]
	);
}
