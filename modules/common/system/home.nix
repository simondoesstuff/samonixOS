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
    # ssh-add -l to see loaded keys
    # enabling the ssh-agent informs some software of active keys
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Host lakehouse
        HostName 71.237.31.35
        User simon
        Port 22565

      Host fijicluster
        HostName fiji.colorado.edu
        User siwa3657

      Host github.com
        IdentityFile ~/.ssh/github
        IdentitiesOnly yes

      Host dclass
        HostName 192.168.68.63
        port 22565
    '';
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
      auto-optimise-store = true; # will cause errors on mac sadly
    };
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
