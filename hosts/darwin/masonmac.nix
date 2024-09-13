# Host for macbook pro 14inch m1pro chip
{
  pkgs,
  root,
  ...
}: {
  imports = [
    (root + /packages/darwin/default.nix)
  ];

  home.packages = [
    pkgs.kitty
  ];

  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.kitty = {
    source = root + /config/kitty;
    recursive = true;
  };
}
