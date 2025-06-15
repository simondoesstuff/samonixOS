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

  # Note for IINA: must import the input.conf as
  # keybindings manually. Found in dotfiles directory
  anime4k-files = pkgs.fetchzip {
    url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_Low-end.zip";
    sha256 = "1v4cxx6lay3vzwm5d9ns8k3crg4zd9p9kylpzbi789pymqkaz1ng";
    stripRoot = false;
  };

  # anime4k-highend = pkgs.fetchzip {
  #   url = "https://github.com/Tama47/Anime4K/releases/download/v4.0.1/GLSL_Mac_Linux_High-end.zip";
  #   sha256 = "1d50zzqwyh264rbqj3dr9hdylcjs4xbji95hrna5icl3a2fmy7q2"; # nix-preferch-url --unpack hash
  #   stripRoot = false; # Assume multiple files, which requires --unpack hash
  # };
in
{
  options.entertainment.enable = lib.mkEnableOption "enable entertainment modules" // {
    default = false;
  };

  config = lib.mkIf config.entertainment.enable {
    xdg.configFile.jerry = {
      source = root + /dotfiles/jerry;
      recursive = true;
    };

    xdg.configFile.lobster = {
      source = root + /dotfiles/lobster;
      recursive = true;
    };

    home.packages = [
      # video players and other
      pkgs.ffmpeg-full # just useful for a lot of things
      # pkgs.yt-dlp # yt downloading util
      # pkgs.jellyfin-mpv-shim

      (pkgs.jerry {
        imagePreviewSupport = true;
      })
      (pkgs.lobster { })

      # music
      pkgs.spotifyd
      (lib.mkIf (!enableSpice) pkgs.spotify)

      # games
      pkgs.prismlauncher
    ];

    # INFO: MPV stuff
    xdg.configFile = {
      "mpv/mpv.conf".source = root + /dotfiles/mpv/mpv.conf;
      "mpv/input.conf".source = root + /dotfiles/mpv/input.conf;
      # Only take the /shaders folder because I don't want the shaders
      # to be activated by default which happens if we use their mpv.conf
      "mpv/shaders" = {
        source = "${anime4k-files}/shaders";
      };
      # necessary font for the modernz script's ui
      "mpv/fonts" = {
        source = "${pkgs.mpvScripts.modernz}/share/fonts";
        recursive = true;
      };
    };

    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        modernz # epic ui
        smartskip # skip openings of shows
        mpvacious
        autoload # auto load playlist entries for sequential files
        sponsorblock
        eisa01.smart-copy-paste-2
      ];

      scriptOpts = {
        modernz = {
          seekbarfg_color = "#FF0032";
          seekbarbg_color = "#555A61";
          hover_effect_color = "#FF0032";
          keeponpause = false; # hide controls when paused on a timer
          window_top_bar = false;
          jump_buttons = false; # dont show "jump 10 seconds" buttons
          nibbles_style = "single-bar";
        };
        SmartSkip = {
          silence_skip_to_end = "pause"; # pause if silent skip reaches the end
          skip = "opening;ending"; # only skip opening/ending (other options: preview, prologue)
        };
        subs2srs = {
          use_ffmpeg = true;
          audio_format = "mp3"; # opus is default
          audio_bitrate = "96k"; # raised from 24k because mp3
          opus_container = "m4a";
          audio_field = "SentenceAudio";
          image_field = "Picture";
          deck_name = "daily decks::mining";
          model_name = "Lapis";
          snapshot_quality = 100;
          snapshot_height = 480;
          animated_snapshot_enabled = true;
          animated_snapshot_quality = 100;
          animated_snapshot_height = 480;
        };
      };
    };

    programs.spotify-player = {
      enable = true;
      package = pkgs.spotify-player;
      settings = {
        enable_notify = false;
        enable_media_control = true; # physical keyboard media buttons
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
