{
  username,
  config,
  pkgs,
  lib,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  home.username = username;
  home.stateVersion = "23.11"; # WARNING: read docs before updating
  news.display = "silent";

  home.homeDirectory =
    if isLinux then
      "/home/${username}"
    else if isDarwin then
      "/Users/${username}"
    else
      unsupported;

  home.shellAliases = {
    hm = "home-manager";
    hmswitch = "home-manager switch --flake ${config.flakePath}";
    nrswitch = "sudo nixos-rebuild switch --flake ${config.flakePath}";
  };

  programs.home-manager.enable = true; # Let home manager manage itself

  # INFO: ssh
  services.ssh-agent.enable = !isDarwin;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "lakehouse" = {
        hostname = "71.237.31.35";
        user = "simon";
        port = 22565;
      };
      "fijicluster" = {
        hostname = "fiji.colorado.edu";
        user = "siwa3657";
      };
      "github.com" = {
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
      "dclass" = {
        hostname = "192.168.68.63";
        port = 22565;
      };
      "worldgov" = {
        # WARN: disabled netcat match because failed connections cause stall and it
        # checks every time you ssh to anything
        # match = "exec \"nc -z -w 1 192.168.68.69 22\"";
        hostname = "192.168.68.69";
        user = "simon";
        # INFO: world gov mac address:   a0:36:9f:ae:c4:cb
      };
      # worldgov: FALLBACK, remote connection
      "worldgov2" = {
        hostname = "bop.tplinkdns.com";
        port = 23;
        user = "simon";
      };
      # "Anton's" A5000s workstation
      "layerlab" = {
        # INFO: mac addresses
        #   enp209s0  a8:a1:59:ef:5e:8e
        #   enp210s0  a8:a1:59:ef:5e:8c
        hostname = "172.21.21.122";
        user = "simon";
      };
    };
  };
  # INFO: If home-manager is not isolated then home-manager is not in the path,
  # we need to add home-manager to the path by installing the package
  home.packages = [
    (lib.mkIf (!config.homeManagerIsolated) pkgs.home-manager)
  ];

  # Add nix only on home-manager isolated systems since nixos has it in default module
  nix = lib.mkIf config.homeManagerIsolated {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = false; # will cause errors on mac sadly
    };
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
