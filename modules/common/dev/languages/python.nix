{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.language.python.enable {
    home.packages = with pkgs; [
      uv
      # (python3.withPackages (
      #   ps: with ps; [
      #     black # formatter
      #     isort # import sorter
      #     matplotlib
      #     numpy
      #     bandit
      #   ]
      # ))
    ];

    # programs.poetry = {
    #   enable = true;
    # };
  };
}
