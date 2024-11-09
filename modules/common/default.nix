{lib, ...}: {
  imports = [
    # All dev essentials
    ./dev/default.nix

    # All system specific pkgs
    ./system/default.nix

    # Personal packages for random stuff
    ./personal/default.nix
  ];
}
