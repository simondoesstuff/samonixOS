{ pkgs, ... }:

let 
  lobster = pkgs.callPackage ../../custom/lobster/default.nix { };
in
{
  home.packages = [
    pkgs.ollama
		lobster
	];
}
