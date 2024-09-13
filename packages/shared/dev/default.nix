{
  imports = [
    ./starship.nix
    ./wezterm.nix
    ./direnv.nix
    ./zoxide.nix
    ./glfw.nix
    ./nvim.nix
    ./git.nix
    ./eza.nix

    # languages + langauge servers
    ./language/default.nix
  ];
}
