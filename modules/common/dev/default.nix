{
  imports = [
    ./termshell.nix
    ./direnv.nix
    ./nvim.nix
    ./git.nix

    # languages + langauge servers
    ./language/default.nix
  ];
}
