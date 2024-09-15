{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./glsl.nix
    ./lua.nix
    ./nix.nix
    ./web.nix
  ];

  home.packages = [
    pkgs.tree-sitter
  ];
}
