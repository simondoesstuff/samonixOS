{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.fira-code # decent nerd font
    neofetch # Show os info and such
  ];
}
