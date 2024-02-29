# This file derpicated wit the new flake config setup

{ pkgs, ... }:
let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
	unsupported = builtins.abort "Unsupported platform";
in
{
	home.username = "mason";

	home.homeDirectory = 
		if isLinux then "/home/mason" else
		if isDarwin then "/Users/mason" else unsupported;

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	fonts.fontconfig.enable = true; # Enable fonts
}
