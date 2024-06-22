{ pkgs, custompkgs, ... }:

{
	#INFO: source low end shaders
	xdg.configFile.mpv = {
		source = pkgs.fetchzip {
			url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_Low-end.zip";
			sha256 = "1v4cxx6lay3vzwm5d9ns8k3crg4zd9p9kylpzbi789pymqkaz1ng"; # nix-preferch-url --unpack hash
	# HIGH END ALTERNATIVE
	# 	url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_High-end.zip";
	# 	sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
			stripRoot=false; # Assume multiple files, which requires --unpack hash
		};
		recursive = true;
	};


	xdg.configFile.jerry = {
		source = ../../config/jerry;
		recursive = true;
	};

	home.packages = [
		custompkgs.jerry
	];
}
