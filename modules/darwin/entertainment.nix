{
  lib,
  pkgs,
  root,
  config,
  ...
}: {
  options.entertainment.enable = lib.mkEnableOption "enable entertainment modules" // {default = true;};

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
      (pkgs.jerry {
        withIINA = true;
        imagePreviewSupport = true;
      })
      (pkgs.lobster {
        withIINA = true;
      })
    ];

    home.shellAliases = {
      jerry = "command jerry --dub";
      jerrysub = "command jerry";
    };
  };
}
