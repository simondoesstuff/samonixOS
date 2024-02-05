{ pkgs, ... }:
{
	home.packages = with pkgs; [
		# darwin.libiconv # Required for rust toolchain? Won't compile C nix library without
		ollama
	];
}

