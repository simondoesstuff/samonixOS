{lib, ...}: {
  options.language =
    lib.genAttrs ["c" "python" "glsl" "web"] (
      name: {enable = lib.mkEnableOption "enable ${name} modules" // {default = false;};}
    )
    // lib.genAttrs ["lua" "nix" "rust"] (
      name: {enable = lib.mkEnableOption "enable ${name} modules" // {default = true;};}
    ); # nix/lua are default for obvious reasons. Rust is default because it is dep for some neovim packages

  imports = [
    ./rust.nix
    ./python.nix
    ./glsl.nix
    ./lua.nix
    ./nix.nix
    ./web.nix
  ];
}
