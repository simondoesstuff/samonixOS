{pkgs, ...}: let
  # TODO: also some cool menus and stuff in this repo
  # use more than just theme
  rofithemes = pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "f3835e7f728bf6d94fb3c2c683c6754e6ccd202e"; # nov 1 2024
    sha256 = "sha256-xlcI9K6cXJetaphkMW5mVWDshqcXeTtxAAwtOK5fF6s=";
  };
in {
  # Note: rofi broken on wayland maybe look for alternatives
  programs.rofi = {
    enable = true;
    # package = pkgs.rofi-wayland;
    theme = "${rofithemes}/files/colors/catppuccin.rasi";
  };
}
