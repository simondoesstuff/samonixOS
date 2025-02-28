{
  imports = [
    ./termshell.nix
    ./direnv.nix
    ./git.nix

    ./nvim.nix
    # ./nixvim

    # languages + langauge servers
    ./language/default.nix
  ];
}
