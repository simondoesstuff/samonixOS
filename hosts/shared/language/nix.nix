{ pkgs, ... }:

{
	home.packages = with pkgs; [
			nixd # nix language server but better
	];
}
