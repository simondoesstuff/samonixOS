{
  username,
  config,
  pkgs,
  lib,
  ...
}: let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in {
  home.username = username;
  home.stateVersion = "23.11"; # WARNING: read docs before updating

  home.homeDirectory =
    if isLinux
    then "/home/${username}"
    else if isDarwin
    then "/Users/${username}"
    else unsupported;

  home.shellAliases = {
    la = "ls -a";
    hm = "home-manager";
    # used like "nrswitch mason@xps"
    nr = "nixos-rebuild";
    nrswitch = "function switch_config { sudo nixos-rebuild switch --flake .#$1; }; switch_config";
  };

  home.packages = [pkgs.home-manager];
  programs.home-manager.enable = true; # Let home manager manage itself

  # Add nix only on home-manager isolated systems since nixos has it in default module
  nix = lib.mkIf config.homeManagerIsolated {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
