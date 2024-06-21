{ pkgs, ... }:

{
  lobster = pkgs.callPackage ./lobster/default.nix { };
}
