{ stdenv, coreutils, xclip }:
stdenv.mkDerivation rec {
  name = "clipshot";
  buildInputs = [ coreutils xclip ];

  src = ./clipshot;

  phases = [ "installPhase" ];

  installPhase = ''
    install -Dm755 ${src} $out/bin/clipshot
    patchShebangs $out/bin/clipshot
  '';
}
