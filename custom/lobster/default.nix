{ coreutils,
  curl,
  fetchFromGitHub,
  ffmpeg,
  fzf,
  gnugrep,
  gnupatch,
  gnused,
  html-xml-utils,
  lib,
  makeWrapper,
  mpv,
  openssl,
  stdenv,
  testers,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lobster";
  version = "e513c273560b380a868244869efc82eb985a7530";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "lobster";
    rev = "${finalAttrs.version}";
    hash = "sha256-6iMMX+aXnBa5kHBVvu4G1WPtba/R7R9aXAOzUlh/8ZQ=";
  };

  patches = [
    ./fix_macos.patch
  ];

  nativeBuildInputs = [
    coreutils # wc
    curl
    ffmpeg
    fzf
    gnugrep
    gnupatch
    gnused
    html-xml-utils
    makeWrapper
    mpv
    openssl
  ];

  installPhase = ''
      mkdir -p $out/bin
      cp lobster.sh $out/bin/lobster
      wrapProgram $out/bin/lobster \
        --prefix PATH : ${lib.makeBinPath [
          coreutils
          curl
          ffmpeg
          fzf
          gnugrep
          gnupatch
          gnused
          html-xml-utils
          mpv
          openssl
        ]}
    '';

  passthru.tests.version = testers.testVersion {
    package = finalAttrs.finalPackage;
  };

  meta = with lib; {
    description = "CLI to watch Movies/TV Shows from the terminal";
    homepage = "https://github.com/justchokingaround/lobster";
    license = licenses.gpl3;
    maintainers = with maintainers; [ benediktbroich ];
    platforms = platforms.unix;
  };
})
