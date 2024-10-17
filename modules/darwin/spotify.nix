{pkgs, ...}: {
  home.packages = [
    pkgs.spotifyd
  ];

  programs.spotify-player = {
    enable = true;
    settings = {
      enable_notify = false;
      device = {
        volume = 100; # make initial volume 70 -> 100 so that laptop has full control
      };
    };
    keymaps = [
      {
        command = "None"; # Disable q for nvim toggleterm, so that we can leave terminal without closing player
        key_sequence = "q";
      }
    ];
  };

  home.shellAliases = {
    spt = "spotify_player";
  };
}
