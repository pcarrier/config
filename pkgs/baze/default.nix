{ stdenv, fetchgit, ruby }:
stdenv.mkDerivation rec {
  name = "baze-${version}";
  version = "1.0";
  buildInputs = [ ruby ];

  src = fetchgit {
    url = "https://github.com/pcarrier/baze";
    rev = "32255c802a70f706c84a2b419e5589433de15afc";
    sha256 = "0frbxwk34v0w9vfbkyl3x722ydqqjf721qqjcadwlfhlvfkg8jp7";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp bin/* $out/bin/
    patchShebangs $out/bin/*
  '';
}
