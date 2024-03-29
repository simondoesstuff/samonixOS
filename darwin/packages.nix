# { pkgs, custompkgs, ... }:
{ pkgs, lobster, ... }:
{
	home.packages = with pkgs; [
		ollama
		lobster.packages.aarch64-darwin.lobster
	];
}

