# packages and config for media and gaming
{
  pkgs-spice,
  config,
  root,
  pkgs,
  lib,
  ...
}:
let
  enableSpice = true; # toggle between spicetify and regular spotify desktop
in
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

    xdg.configFile.jerry = {
      source = root + /dotfiles/jerry;
      recursive = true;
    };

    xdg.configFile.lobster = {
      source = root + /dotfiles/lobster;
      recursive = true;
    };

    home.packages = [
      # video
      pkgs.ffmpeg # useful for stacher and other general things
      (pkgs.jerry {
        withIINA = if pkgs.stdenv.isDarwin then true else false;
        imagePreviewSupport = true;
      })
      (pkgs.lobster {
        withIINA = if pkgs.stdenv.isDarwin then true else false;
      })

      # music
      pkgs.spotifyd
      (lib.mkIf (!enableSpice) pkgs.spotify)

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

    # WARNING: On MacOS, spotify will ask you to "update" and it will remove all
    # the spicetify modifications if you say yes. Not sure if there is a good way
    # to stop the update request from appearing yet, haven't experimented much
    programs.spicetify = {
      enable = enableSpice;
      alwaysEnableDevTools = true; # doesn't work on mac I dont think
      theme =
        let
          baseTheme = pkgs-spice.themes.default;
        in
        baseTheme
        // {
          injectCss = true;
          # TODO: Sadly doesn't hide the OG lyric button i tried
          additionalCss = lib.strings.concatStrings [
            (baseTheme.additionalCss or "")
            ''
              /* Hide lyrics button */
              [data-testid="lyrics-button"] {
                display: none !important;
              }
            ''
          ];
        }; # theme = pkgs-spice.themes.catppuccin;
      # colorScheme = "mocha";
      enabledExtensions = with pkgs-spice.extensions; [
        # INFO: nice-to-haves
        shuffle # fischer-yates lets go (ballotery)
        adblockify
        beautifulLyrics # adds epic lyrics with cool fullscreen mode
        # INFO: stats
        skipStats # tracks ur skips for fun
        songStats # shows key and other which is fire
        # INFO: opinionated
        hidePodcasts # note you can also go to settings and toggle it back and forth

        # lowkey this fullscreen mode looks epic but it kinda overlaps with
        # simpleBeautiful lyrics fullscreen and it feels weird to have two
        # fullScreen
      ];
    };

    home.shellAliases = {
      jerry = "command jerry --dub";
      jerrysub = "command jerry";
      spt = "spotify_player";
    };
  };
}
