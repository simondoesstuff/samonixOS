{ pkgs, ... }:

{
	nix = { # Configure the Nix package manager itself
		package = pkgs.nix;
		settings.experimental-features = [ "nix-command" ];
	};
}
