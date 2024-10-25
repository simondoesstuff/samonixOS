# { pkgs, custompkgs, ... }:
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    clang
		firefox
  ];
}
