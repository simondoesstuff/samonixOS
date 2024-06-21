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
  version = "989ec646f514387265a1f19550d24914ba67fcdf";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "jerry";
    rev = "${finalAttrs.version}";
    sha256 = "pjS2b2P15z9LqwoHqG02vtX/mVeKM4t5dmn5URiszeI=";
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
