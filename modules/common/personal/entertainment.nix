# packages and config for media and gaming
{
  pkgs-spice,
  config,
  root,
  pkgs,
  lib,
  ...
}:
{
  options.entertainment.enable = lib.mkEnableOption "enable entertainment modules" // {
    default = false;
  };

  config = lib.mkIf config.entertainment.enable {
    #INFO: Source 4k upscale shaders for anime.
    # Note for IINA: must import the input.conf as keybindings manually
    xdg.configFile.mpv = {
      source = pkgs.fetchzip {
        url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_Low-end.zip";
        sha256 = "1v4cxx6lay3vzwm5d9ns8k3crg4zd9p9kylpzbi789pymqkaz1ng"; # nix-preferch-url --unpack hash
        # HIGH END ALTERNATIVE
        # 	url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_High-end.zip";
        # 	sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
        stripRoot = false; # Assume multiple files, which requires --unpack hash
      };
      recursive = true;
    };

    # TODO: Fix jerry/lobster on linux. Not sure why not launching
    xdg.configFile.jerry = {
      source = root + /dotfiles/jerry;
      recursive = true;
    };

    xdg.configFile.lobster = {
      source = root + /dotfiles/lobster;
      recursive = true;
    };

    home.packages = [
      pkgs.ffmpeg # useful for stacher and other general things
      (pkgs.jerry {
        withIINA = if pkgs.stdenv.isDarwin then true else false;
        imagePreviewSupport = true;
      })
      (pkgs.lobster {
        withIINA = if pkgs.stdenv.isDarwin then true else false;
      })
      pkgs.spotify
      pkgs.spotifyd

      # games
      pkgs.prismlauncher
    ];

    programs.spotify-player = {
      enable = true;
      package = pkgs.spotify-player;
      settings = {
        enable_notify = false;
        enable_media_control = true; # only works on macos when focused, apparently
        device = {
          volume = 100;
        };
      };
      keymaps = [
        {
          command = "None"; # disable q so that we can leave neovim toggleterm without closing player
          key_sequence = "q";
        }
        {
          command = "FocusNextWindow";
          key_sequence = "C-l";
        }
        {
          command = "FocusPreviousWindow";
          key_sequence = "C-h";
        }
      ];
    };

    # TODO: Not sure if worth keeping tbh, don't use spotify app a ton anyway
    programs.spicetify = {
      enable = true;
      theme = pkgs-spice.themes.default;
      # theme = pkgs-spice.themes.catppuccin;
      # colorScheme = "mocha";
      enabledExtensions = with pkgs-spice.extensions; [
        shuffle # fischer-yates lets go (ballotery)
        hidePodcasts
        adblockify
      ];
      enabledCustomApps = with pkgs-spice.apps; [
        lyricsPlus
      ];
    };

    home.shellAliases = {
      jerry = "command jerry --dub";
      jerrysub = "command jerry";
      spt = "spotify_player";
    };
  };
}
