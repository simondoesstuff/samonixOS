{
  pkgs-unstable,
  config,
  pkgs,
  root,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Source neovim/wezterm custom (non-nix) config
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink (root + "/dotfiles/neovim");
    recursive = true;
  };

  home.packages = [
    pkgs-unstable.neovim # Cracked text editor
    pkgs.ripgrep # Fast grep
    pkgs.fd # Advanced find
    pkgs.tree-sitter # Syntax highlighting
  ];

  # file system used in neovim
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  # TODO: This config is better but isolated to home-manager 24.11, switch when macos swift build bug is fixed
  # programs.yazi = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   plugins = {
  #     starship = pkgs.fetchFromGitHub {
  #       owner = "Rolv-Apneseth";
  #       repo = "starship.yazi";
  #       rev = "20d5a4d4544124bade559b31d51ad41561dad92b";
  #       sha256 = "sha256-0nritWu53CJAuqQxx6uOXMg4WiHTVm/i78nNRgGrlgg=";
  #     };
  #   };
  #   initLua = ''
  #     require("starship"):setup()
  #   '';
  # };
}
