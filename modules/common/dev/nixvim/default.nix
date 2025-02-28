{...}: {
  programs.nixvim = {
    enable = true;
  };

  imports = [
    ./plugins/general.nix
    ./plugins/alpha.nix
  ];
}
