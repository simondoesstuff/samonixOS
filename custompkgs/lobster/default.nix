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
	iina,
	withIINA ? false,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lobster";
  version = "cff0995afb09c4e98d8fc5ddf7599e1f4617504a";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "lobster";
    rev = "${finalAttrs.version}";
		hash = "sha256-8hODt9vSVNnK1UK8vh1GP6+H4h1g37h3xc9VTQQWXYw=";
  };

  patches = [
    ./fix_macos.patch
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

	runtimeInputs = [
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
	] ++ (if withIINA then [ iina ] else [ mpv ]);

  installPhase = ''
      mkdir -p $out/bin
      cp lobster.sh $out/bin/lobster
      wrapProgram $out/bin/lobster \
        --prefix PATH : ${lib.makeBinPath finalAttrs.runtimeInputs}
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
