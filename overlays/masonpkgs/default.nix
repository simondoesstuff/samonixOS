# Overlay used to "inject" custom packages into nixpkgs
self: super: {
  lobster = args: super.callPackage ./lobster/default.nix args;
  jerry = args: super.callPackage ./jerry/default.nix args;
}
