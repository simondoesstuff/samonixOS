{
  imports = [
    ./termshell.nix
    ./direnv.nix
    ./git.nix

    # ./nixvim

    # languages + langauge servers
    ./nvim_old
  ];

  # programs.nixvim = {
  #   enable = true;
  #   plugins.blink-cmp.enable = true;
  #   plugins.lsp.enable = true;
  # };
}
