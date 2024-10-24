# This config is just a general darwin config
{
  config,
  pkgs,
  lib,
  ...
}: {
  options.lolcat.enable = lib.mkEnableOption "enable lolcat" // {default = false;};

  imports =
    [
      #INFO: Darwin exclusive configs
      ./entertainment.nix
      ./packages.nix
      ./zsh.nix
      ./spotify.nix
    ]
    ++ [
      #INFO: Specified shared configs
      ../common/default.nix # In this case, take everything from shared
    ];

  config = {
    home.packages = lib.mkIf config.lolcat.enable [
      pkgs.lolcat
    ];
  };
}
