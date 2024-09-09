{pkgs, ...}: {
  lobster = pkgs.callPackage ./lobster/default.nix {withIINA = true;};
  jerry = pkgs.callPackage ./jerry/default.nix {
    imagePreviewSupport = true;
    withIINA = true;
  };
}
