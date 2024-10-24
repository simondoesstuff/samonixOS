{pkgs, ...}: {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Required for obsidian
  ];
  home.packages = with pkgs; [
    obsidian
  ];
}
