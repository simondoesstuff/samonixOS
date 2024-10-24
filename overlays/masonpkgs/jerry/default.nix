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
  chafa,
  lib,
  makeWrapper,
  mpv,
  openssl,
  stdenvNoCC,
  testers,
  rofi,
  iina,
  jq,
  withRofi ? false,
  withIINA ? false,
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

  # INFO: to create this patch file, run a git diff after editing source code manually
  patches = [
    ./fix_macos.patch
  ];

  nativeBuildInputs = [makeWrapper];
  runtimeInputs =
    [
      coreutils
      curl
      ffmpeg
      fzf
      gnugrep
      gnupatch
      gnused
      html-xml-utils
      openssl
    ]
    ++ lib.optional withRofi rofi
    ++ lib.optional imagePreviewSupport chafa
    ++ lib.optional infoSupport jq
    ++ (
      if withIINA
      then [iina]
      else [mpv]
    );

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
