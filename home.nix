{ config, pkgs, lib, ... }:
let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
	unsupported = builtins.abort "Unsupported platform";
in
{
	imports = [ # Modularize home.nix by importing statements from other files
		./extra/git.nix 
		./extra/shell.nix 
		./extra/config.nix 
		./packages/dev.nix
		./packages/personal.nix
	];

	# linux.enable = true;
	# darwin.enable = true;

	#INFO: The user account and path that Home Manager will manage
	home.username = "mason";
	home.homeDirectory = 
		if isLinux then "/home/mason" else
		if isDarwin then "/Users/mason" else unsupported;

	#WARNING: Don't change this without reading docs
	home.stateVersion = "23.11";
	programs.home-manager.enable = true; # Let home manager manage itself

	home.packages = with pkgs; ([
	] ++ lib.optionals isLinux [
		(writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Linux!"'')
	] ++ lib.optionals isDarwin [
  	(writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Darwin!"'')
	]);

	# Manage environment (shell) variables
	home.sessionVariables = {
		EDITOR = "neovim";
	};

	fonts.fontconfig.enable = true; # Enable fonts
	nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord

	nix = { # Configure the Nix package manager itself
		package = pkgs.nix;
		settings.experimental-features = [ "nix-command" ];
	};
}
