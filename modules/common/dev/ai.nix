{ pkgs-unstable, pkgs, ... }:
{
  home.packages = [
    pkgs-unstable.gemini-cli
    pkgs-unstable.antigravity-cli
    pkgs-unstable.claude-code
    pkgs-unstable.codex
    # pkgs.entire-masonpkgs
  ];
}
