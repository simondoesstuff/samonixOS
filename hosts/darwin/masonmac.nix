# Host for macbook pro 14inch m1pro chip
{pkgs, ...}: {
  imports = [
    ../../packages/darwin/default.nix
  ];

  home.packages = [
    pkgs.kitty
  ];

  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.kitty = {
    source = ../../config/kitty;
    recursive = true;
  };
}
