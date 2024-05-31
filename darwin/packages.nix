# { pkgs, custompkgs, ... }:
{ pkgs, lobster, ... }:
{
	home.packages = with pkgs; [
		ollama
		lobster.packages.aarch64-darwin.lobster # flake doesn't specify ${system} as an arg? not necessary for jerry
		# jdk17
	];
}

