{lib, ...}: {
  options.language =
    lib.genAttrs ["c" "rust" "python" "glsl" "web"] (
      name: {enable = lib.mkEnableOption "enable ${name} modules" // {default = false;};}
    )
    // lib.genAttrs ["lua" "nix"] (
      name: {enable = lib.mkEnableOption "enable ${name} modules" // {default = true;};}
    );

  imports = [
    ./rust.nix
    ./python.nix
    ./glsl.nix
    ./lua.nix
    ./nix.nix
    ./web.nix
  ];
}
