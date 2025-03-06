{
  imports = [
    ./termshell.nix
    ./direnv.nix
    ./git.nix

    ./languages
    ./nixvim
    # ./nvim_old
  ];

  # programs.nixvim = {
  #   enable = true;
  #   plugins.blink-cmp.enable = true;
  #   plugins.lsp.enable = true;
  # };
}
