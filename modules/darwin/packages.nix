{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ollama # run local ml models
    iina # sleek video player (MPV replacement)
  ];
}
