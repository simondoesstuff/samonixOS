{
  config,
  pkgs,
  lib,
  ...
}: let
  version = "1.5.1";
  glslanalyzer = pkgs.stdenv.mkDerivation {
    pname = "glslanalyzer";
    version = version;

    src = pkgs.fetchzip {
      url = "https://github.com/nolanderc/glsl_analyzer/releases/download/v${version}/aarch64-macos.zip";
      sha256 = "5mb8C83PrvmyJNK0jKBzIf4yt+t+o5sxezG67//Txsk=";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/* $out/bin
    '';
  };
in {
  config = lib.mkIf config.language.glsl.enable {
    home.packages = [glslanalyzer];
  };
}
