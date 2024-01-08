{ pkgs, ... }:

{ 
	home.packages = [
		pkgs.lua-language-server # implied
		pkgs.rust-analyzer
		pkgs.nil # Nix language server
	];
}
