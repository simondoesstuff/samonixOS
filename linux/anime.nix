{ pkgs, ... }:

#INFO: Version 4.0.1 of Anime4k
let 
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
# Note, to use with IINA must edit settings to point to mpv configuration
	# home.file.".config/mpv" = {
	# 	source = fetchFromGitHub {
	# 		owner = "Tama47";
	# 		repo = "Anime4K";
	# 		rev = "v4.0.1";
	# 		sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
	# 	};
	# 	recursive = true;
	# };

	home.packages = with pkgs; [
		# LOBSTER
		mpv # Video player for cli
		vlc # Videoplater 2??
		fzf # Fuzzy finder for jerry
		rofi-wayland # Externalgui
		socat # Vid positions
		ueberzugpp # images in terminal
		gnupatch
		jerry
	];
}

