{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.language.python.enable {
    home.packages = with pkgs; [
      uv # package manager (pip, pipx, ..., replacement)
      (python3.withPackages (
        ps: with ps; [
          numpy # number shi
          matplotlib # graphs
        ]
      ))
    ];
  };
}
