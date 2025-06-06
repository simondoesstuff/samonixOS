# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{ pkgs, ... }:
let
  hostname = "dclass";
in
{
  # WARNING: Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  users.users.simon = {
    ignoreShellProgramCheck = true; # shell is defined via home-manager
    shell = pkgs.zsh;
  };

  # INFO: WSL STUFF
  wsl.enable = true;
  wsl.defaultUser = "simon";

  wsl.wslConf = {
    # not supported in wsl.conf, only the global .wslconfig which nix cannot provide 6/6/2025
    # wsl2 = {
    #   networkingMode = "mirrored";
    # };

    network = {
      hostname = hostname;
      generateResolvConf = false;
    };
  };

  # open up remote desktop to connect from windows
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  # INFO: Networking stuff
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  services.openssh = {
    enable = true;
    ports = [ 22565 ];
    settings = {
      PasswordAuthentication = false;
    };
  };

  users.users.simon.openssh.authorizedKeys.keys = [
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZblT7Q/WxYTQnb3WL9lJMclp1DeQeYzdBKOBPAX0bD" # mbp14 (mason)
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqYhMkfTYA7biVs4xp0OxhcV0Zk4yxvMTLn7u6S0PWc" # windows 3080pc (mason)
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSzAG3Xgy9Sf0Ype3TolDXEtaBCtiUMyexxT1p67WbPOxR1/4qj4d3HgNezm+9Q+SSI4oYUofU552zdp5kUBdi19A3B5NWNEBmka/AGPEBer9UmbghgdtjzB+Fiqq6iBJAO4jnfaW29M7tlMMX6BgQHjgn5F3qblY4QKYD+d2e2LIJcbvTTIf91bFNhF4UUzfOMcXVIEmvrMhOB5ytKakoMrhFzFPPtQC7/R6fKd+Ua5yth9swp8Yp4OPbYXhm9mEhBtHyePUZQBvo7eq5if7VurCJ945PInnEgdR87YNpN6SvXLmSxmFtwABrCARzp0rYSmd71SX1PXHBvGdKp7y8pfsSv349j7+/n+qzF6dEPn7V0tvZa91+HHxxNukmhGS3UhPPX+481BvHi4HqjEA0Aj492gr/AfUIfcYkUkuztTvzbIumtOeTzkahT/sVSBVjTDpkkp4eP8ziKJjybO1yVeL+HnxF4Vr+4BOUnOecaJ52zeSOhG8MApFllnJGD9U= simon@EuclidMac.local" # euclidmac
  ];

  # INFO: Other
  # TODO: Failed to build after 25.05 migration, fix?
  # services.openvscode-server = {
  #   enable = true;
  #   user = "mason";
  # };
}
