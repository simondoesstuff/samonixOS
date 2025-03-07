{lib, ...}:
{
  options.legacyNvim.enable = lib.mkEnableOption "enable old nvim" // {default = false;};

  imports = [
    ./termshell.nix
    ./direnv.nix
    ./git.nix

    ./languages
    ./nixvim
    ./nvim_old
  ];
}
