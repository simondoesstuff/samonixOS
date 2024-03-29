{ pkgs, jerry, ... }:

#INFO: Version 4.0.1 of Anime4k
let 
	fetchFromGitHub = pkgs.fetchFromGitHub;
in 
{
# Note, to use with IINA must edit settings to point to mpv configuration
	home.file.".config/mpv" = {
		source = fetchFromGitHub {
			owner = "Tama47";
			repo = "Anime4K";
			rev = "v4.0.1";
			sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
		};
		recursive = true;
	};

	home.packages = with pkgs; [
		jerry.packages.aarch64-darwin.jerry
		ani-cli # anime CLI
		iina # Video player for MAC
		mpv
		fzf
	];
}
