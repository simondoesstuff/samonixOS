{ pkgs, ... }:

#INFO: Version 4.0.1 of Anime4k
let 
	fetchFromGitHub = pkgs.fetchFromGitHub;
	jerry = pkgs.stdenv.mkDerivation {
		name = "jerry 1.9.9";
		src = pkgs.fetchurl {
			url = "https://github.com/justchokingaround/jerry/raw/main/jerry.sh";
			sha256 = "1jcc0cakrdxarqps6r2v03xvdqd3hmj63qw0fbzzgda0ydinappq";
		};
		dontUnpack = true;
		installPhase = "install -D $src $out/bin/jerry";
	};
in 
{
# Source low end shaders 
	home.file.".config/mpv" = {
		source = pkgs.fetchzip {
			url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_Low-end.zip";
			sha256 = "1v4cxx6lay3vzwm5d9ns8k3crg4zd9p9kylpzbi789pymqkaz1ng"; # nix-preferch-url --unpack hash
			stripRoot=false; # Assume multiple files, which requires --unpack hash
		};
		recursive = true;
	};

# Source high end shaders
	# home.file.".config/mpv" = {
	# 	source = pkgs.fetchzip {
	# 		url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_High-end.zip";
	# 		sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
	# 		stripRoot=false; # Assume multiple files, which requires --unpack hash
	# 	};
	# 	recursive = true;
	# };
	home.packages = with pkgs; [
		# LOBSTER
		mpv # Video player for cli
		# vlc # Videoplater 2??
		fzf # Fuzzy finder for jerry
		rofi-wayland # Externalgui
		socat # Vid positions
		ueberzugpp # images in terminal
		gnupatch
		jerry

		# Directly from repo
		coreutils
		curl
		ffmpeg
		# fzf
		gnugrep
		# gnupatch
		gnused
		html-xml-utils
		makeWrapper
		# mpv
		openssl
		# testers
		# ueberzugpp
		# rofi
		jq
	];
}

