{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra # formatter
    nixd # nix language server but better
    nil # 2nd language server, attach both
  ];
}
