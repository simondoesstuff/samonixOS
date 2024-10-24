{root, ...}: {
  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.rofi = {
    source = root + /dotfiles/rofi;
    recursive = true;
  };
}
