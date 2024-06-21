{
  coreutils,
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
	iina,
  openssl,
  stdenvNoCC,
  testers,
  rofi,
  ueberzugpp,
  jq,
  withRofi ? false,
  imagePreviewSupport ? false,
  infoSupport ? false,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "jerry";
  version = "b786ab0edfcadc4ac00c626617793d46a2a25215";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "jerry";
    rev = "${finalAttrs.version}";
    sha256 = "jZAM4gX6mHo1hF1NRoTLWYnkSObdUNMMdJlI9JSxZ4A=";
  };

  patches = [
    ./fix_macos.patch
  ];

  nativeBuildInputs = [makeWrapper];
  runtimeInputs =
    [
      coreutils # wc
      curl
      ffmpeg
      fzf
      gnugrep
      gnupatch
      gnused
      html-xml-utils
      mpv
			iina
      openssl
    ]
    ++ lib.optional withRofi rofi
    ++ lib.optional imagePreviewSupport ueberzugpp
    ++ lib.optional infoSupport jq;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -Dm 755 jerry.sh $out/bin/jerry
    wrapProgram $out/bin/jerry --prefix PATH : ${lib.makeBinPath finalAttrs.runtimeInputs}

    runHook postInstall
  '';

  passthru.tests.version = testers.testVersion {
    package = finalAttrs.finalPackage;
  };

  meta = with lib; {
    description = "Watch anime with automatic anilist syncing and other cool stuff";
    homepage = "https://github.com/justchokingaround/jerry";
    license = licenses.gpl3;
    maintainers = with maintainers; [justchokingaround diniamo];
    platforms = platforms.unix;
    mainProgram = "jerry";
  };
})
