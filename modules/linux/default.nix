{lib, ...}: {
  options.test.enable = lib.mkEnableOption "enable test hello module" // {default = false;};

  imports =
    [
      ./packages.nix
      ./zsh.nix
      ./rofi.nix
    ]
    ++ [
      #INFO: Specified shared configs
      ../common/default.nix # In this case, take everything from shared
    ];
}
