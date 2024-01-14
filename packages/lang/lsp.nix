#INFO: This file is exlusively for language servers that don't have their own custom config file

{ pkgs, ... }:
{
	home.packages = with pkgs; [
			lua-language-server # lua language serv
			nil # nix language serv
	];
}
