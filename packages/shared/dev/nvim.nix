{
  pkgs,
  root,
  ...
}: {
  programs.neovim.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.nvim = {
    source = root + /config/neovim;
    recursive = true;
  };

  home.packages = with pkgs; [
    ripgrep # Fast grep
    fd # Advanced find
  ];
}
