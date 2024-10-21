{username, ...}: {
  home.username = username;

  #WARNING: Don't change this without reading docs
  home.stateVersion = "23.11";

  home.homeDirectory = "/home/${username}";

	# TODO: Why is this not adding hm to path?
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
}
