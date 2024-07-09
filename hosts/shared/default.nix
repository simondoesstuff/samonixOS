{ pkgs, username, ... }:
let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
	unsupported = builtins.abort "Unsupported platform";
in
{
	# The user account and path that Home Manager will manage
	home.username = "mason";
	home.homeDirectory = 
		if isLinux then "/home/mason" else
		if isDarwin then "/Users/mason" else unsupported;

	#INFO: Import all configs and packages from external files
	imports = [
		./git.nix
		./nvim.nix
		./wezterm.nix
		./packages.nix
		./starship.nix
		./direnv.nix
		./zoxide.nix
		./eza.nix
		./language/default.nix
  ];
}
