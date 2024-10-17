# { pkgs, custompkgs, ... }:
{
  pkgs,
  lobster,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    clang
  ];
}
