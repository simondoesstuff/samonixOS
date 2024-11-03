{
  pkgs,
  username,
  ...
}: {
  home.username = username;

  #WARNING: Don't change this without reading docs
  home.stateVersion = "23.11";
  programs.home-manager.enable = true; # Let home manager manage itself

  home.homeDirectory = "/Users/${username}";

  fonts.fontconfig.enable = true; # Enable fonts

  nix = {
    # Configure the Nix package manager itself
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
