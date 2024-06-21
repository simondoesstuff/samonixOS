{ pkgs, custompkgs, ... }:

{
  home.packages = [
    pkgs.ollama
		custompkgs.lobster
	];
}
