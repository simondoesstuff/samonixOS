{
  fetchurl,
  lib,
  stdenv,
  makeWrapper,
  nodejs,
}:

let
  version = "66.7.5";
  tarball = fetchurl {
    url = "https://registry.npmjs.org/@unocss/language-server/-/language-server-${version}.tgz";
    hash = "sha256-a5qXvYEBXKvcRWpFrXVMR7CLeBOGxjH488gaSEtJWlA=";
  };
in
stdenv.mkDerivation {
  pname = "unocss-language-server";
  inherit version;

  src = tarball;

  nativeBuildInputs = [ makeWrapper ];

  unpackPhase = ''
    tar -xzf $src
    sourceRoot=package
  '';

  installPhase = ''
    mkdir -p $out/lib/unocss-language-server $out/bin
    cp -r . $out/lib/unocss-language-server/

    makeWrapper ${nodejs}/bin/node $out/bin/unocss-language-server \
      --add-flags "$out/lib/unocss-language-server/bin/unocss-language-server.js"
  '';

  meta = {
    description = "UnoCSS Language Server";
    homepage = "https://unocss.dev";
    license = lib.licenses.mit;
    mainProgram = "unocss-language-server";
  };
}
