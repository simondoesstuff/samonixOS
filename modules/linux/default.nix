{
  imports =
    [
      ./packages.nix
      ./zsh.nix
      # ./rofi.nix
    ]
    ++ [
      #INFO: Specified shared configs
      ../common/default.nix # In this case, take everything from shared
    ];
}
