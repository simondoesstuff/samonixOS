{ pkgs, ... }:

{
  home.packages = [
    pkgs.spotifyd
	];

	programs.spotify-player = {
		enable = true;
		settings = {
			enable_notify = false;
		};
		keymaps = [
			{
				command = "None"; # Disable q for toggleterm, so that we can leave terminal without closing player
				key_sequence = "q";
			}
		];
	};

	home.shellAliases = {
		spt = "spotify_player";
	};
}
