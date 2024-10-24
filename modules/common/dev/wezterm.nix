{root, ...}: {
  programs.wezterm.enable = true;

  # Source wezterm dotfile directly
  xdg.configFile.wezterm = {
    source = root + /dotfiles/wezterm;
    recursive = true;
  };
}
