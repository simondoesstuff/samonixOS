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
  version = "942ad9f466a1056fe48961826c1ff34da4beb976";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "lobster";
    rev = "${finalAttrs.version}";
		hash = "sha256-ch91LYKs6MswTC08Xi8VcIxooWvDprGuIn0B2Yo3ufo=";
  };

	# info: to create this patch file, run a git diff after editing source code manually 
  patches = [
    ./fix_macos2.patch
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
