{ pkgs, custompkgs, ... }:

let 
  # lobster = pkgs.callPackage ../../custom/lobster/default.nix { };
	# mycustompackages = import ../../custompkgs { inherit pkgs; };
in
{
  home.packages = [
    pkgs.ollama
		custompkgs.lobster
	];
}
