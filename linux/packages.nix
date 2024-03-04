# { pkgs, custompkgs, ... }:
{ pkgs, lobster, ... }:
{
	home.packages = with pkgs; [
		# darwin.libiconv # Required for rust toolchain? Won't compile C nix library without
		# ollama
		lobster.packages.x86_64-linux.lobster
		wl-clipboard # Clipboard manager
	];
}

