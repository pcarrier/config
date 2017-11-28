{ stdenv, fetchFromGitHub, fetchNodeModules, electron, makeWrapper}:

stdenv.mkDerivation rec {
  shortname = "sonos";
  name = "${shortname}-${version}";
  version = "0.1.0";

  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner = "pascalopitz";
    repo = "unoffical-sonos-controller-for-linux";
    rev = "v${version}";
    sha256 = "1w7xjidz1l5yjmhlplfx7kphmnpvqm67w99hd2m7kdixwdxq0zqg";
  };

  nodeModules = fetchNodeModules {
    inherit src;
    sha256 = "hello";
  };

  configurePhase = ''
    ln -s ${nodeModules} node_modules
  '';

  # installPhase = ''
  #   makeWrapper ${electron}/bin/electron $out/bin/rambox \
  #     --add-flags "${rambox-bare} --without-update" \
  #     --prefix PATH : ${xdg_utils}/bin
  # '';
}
