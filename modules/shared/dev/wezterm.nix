{root, ...}: {
  programs.wezterm.enable = true;

  # Source wezterm dotfile directly
  xdg.configFile.wezterm = {
    source = root + /config/wezterm;
    recursive = true;
  };
}
