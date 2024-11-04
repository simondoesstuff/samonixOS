{lib, ...}: {
  options.homeManagerIsolated = lib.mkEnableOption "is home manager without nixOS?" // {default = false;};

  imports = [
    # All dev essentials
    ./dev/default.nix

    # All system specific pkgs
    ./system/default.nix

    # Personal packages for random stuff
    ./personal/default.nix
  ];
}
