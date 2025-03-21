{ lib, ... }:
{
  options.personal.enable = lib.mkEnableOption "enable personal modules" // {
    default = false;
  };

  imports = [
    ./social.nix
    ./productivity.nix
    ./entertainment.nix
  ];
}
