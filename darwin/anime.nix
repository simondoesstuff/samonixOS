{ pkgs, ... }:

#INFO: Version 4.0.1 of Anime4k
let 
	fetchFromGitHub = pkgs.fetchFromGitHub;
	# jerry = pkgs.fetchFromGitHub {
	# 	owner = "justchokingaround";
	# 	repo = "jerry";
	# 	rev = "a5e3bdae8ec49fa3fb0aa71f8f71cc0695612518"; # commit, for the hash
	# 	hash=
	# };
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
		# jerry
		ani-cli # anime CLI
		iina # Video player for MAC
		mpv # Video player for cli
		aria2 # Download manager for cli
		yt-dlp # m3u8 downloader
		fzf # Fuzzy finder for jerry
		ueberzugpp # images in terminal
		# (pkgs.writeShellScriptBin "gsed" "${pkgs.gnused}/bin/sed $@") Instaled throguh brew :(
	];
}
