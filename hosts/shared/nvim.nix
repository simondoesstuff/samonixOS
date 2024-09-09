{
  programs.neovim.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.nvim = {
    source = ../../config/neovim;
    recursive = true;
  };
}
