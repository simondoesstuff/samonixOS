{ pkgs, ... }:

{
  lobster = pkgs.callPackage ./lobster/default.nix { };
	jerry = pkgs.callPackage ./jerry/default.nix { imagePreviewSupport = true; withIINA = true;};
}
