# Host for macbook pro 14inch m1pro chip
{root, ...}: {
  imports = [
    (root + /modules/darwin/default.nix)
  ];
}
