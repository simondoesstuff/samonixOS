{
  config,
  pkgs,
  lib,
  ...
}: let
  version = "1.4.4";
  glslanalyzer = pkgs.stdenv.mkDerivation {
    pname = "glslanalyzer";
    version = version;

    src = pkgs.fetchzip {
      url = "https://github.com/nolanderc/glsl_analyzer/releases/download/v${version}/aarch64-macos.zip";
      sha256 = "1p1crnfbfa9jl96p8m44mpa7fw2n0bdabp67vhmy74a3j26dnl3f";
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
