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
  version = "f997596fc14fed328968f3ab27c777d001830efd";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "jerry";
    rev = "${finalAttrs.version}";
    sha256 = "IZ1+P7RrTO3NgKxZx62Cbjm7z/AWfz3MghnleHw98/4=";
  };

  # INFO: to create this patch file, run a git diff after editing source code manually
  patches = [
    ./fix_macos.patch
  ];

  nativeBuildInputs = [ makeWrapper ];
  runtimeInputs = [
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
  ++ (if withIINA then [ iina ] else [ mpv ]);

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
    maintainers = with maintainers; [
      justchokingaround
      diniamo
    ];
    platforms = platforms.unix;
    mainProgram = "jerry";
  };
})
