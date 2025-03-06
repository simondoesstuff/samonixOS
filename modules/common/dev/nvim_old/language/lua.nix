{pkgs, ...}: {
  home.packages = with pkgs; [
    lua-language-server # lua language server
    stylua # formatter
  ];
}
