{pkgs, ...}: {
  home.packages = with pkgs; [
    clangd
  ];
}
