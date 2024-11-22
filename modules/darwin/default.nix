# This config is just a general darwin config
{...}: {
  imports =
    [
      #INFO: Darwin exclusive configs
      ./packages.nix
      ./spotify.nix
    ]
    ++ [
      #INFO: Specified shared configs
      ../common/default.nix # In this case, take everything from shared
    ];
}
