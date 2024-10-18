{username, ...}: {
  home.username = username;

  #WARNING: Don't change this without reading docs
  home.stateVersion = "23.11";

  home.homeDirectory = "/home/${username}";

  fonts.fontconfig.enable = true;
}
