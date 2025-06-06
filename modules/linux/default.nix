{ lib, config, ... }:
{
  options.test.enable = lib.mkEnableOption "enable test hello module" // {
    default = false;
  };

  imports =
    [
      ./packages.nix
      ./rofi.nix
      ./test.nix
    ]
    ++ [
      #INFO: Specified shared configs
      ../common/default.nix # In this case, take everything from shared
    ];

  config = {
    # will automatically merge this with the list from python.nix.
    ldLibraryPathParts = [ "/usr/lib/wsl/lib" ];

    # Assemble the final environment variable from all collected parts.
    # This definition will be the single source of truth for the variable.
    home.sessionVariables.LD_LIBRARY_PATH =
      # Only set the variable if one or more modules contributed a path.
      lib.mkIf (config.ldLibraryPathParts != [ ]) (lib.concatStringsSep ":" config.ldLibraryPathParts);
  };
}
