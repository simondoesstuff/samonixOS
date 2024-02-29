# { pkgs, custompkgs, ... }:
{ pkgs, lobster, ... }:
{
	home.packages = with pkgs; [
		# darwin.libiconv # Required for rust toolchain? Won't compile C nix library without
		ollama
		lobster.packages.aarch64-darwin.lobster
	];

	imports = [
		# inputs.lobster.nixosModules.lobster # add this line
	];
}

