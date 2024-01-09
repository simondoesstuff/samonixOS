{ pkgs,... }:

let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
	nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord
	nixpkgs.config.permittedInsecurePackages = [
		"electron-25.9.0" # Required for obsidian for some reason
	];

	home.packages = with pkgs; ([
		obsidian # MD note taker editor
		discord # Voicechat and social app
		neofetch # Show os info and such
	]);
}
