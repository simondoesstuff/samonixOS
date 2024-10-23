{pkgs, ...}: {
  home.packages = with pkgs; [
    ollama

    # TODO: Migrate these to nix
    # raycast
    # arc
		wireshark
  ];
}
