{
  imports = [
    ./wezterm.nix
    ./direnv.nix
    ./shell.nix
    ./nvim.nix
    ./git.nix

    # languages + langauge servers
    ./language/default.nix
  ];
}
