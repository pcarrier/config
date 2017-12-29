self: super:
{
  baze         = super.callPackage ./baze { };
  clipshot     = super.callPackage ./clipshot { };
  displays     = super.callPackage ./displays { };
  minijail     = super.callPackage ./minijail { };
  monorepoenv  = super.callPackage ./monorepoenv { };
  mpv          = super.mpv.override { vapoursynthSupport = true; };
  mtr          = super.mtr.override { withGtk = true; };
  pcarrier.env = super.callPackage ./pcarrier/env { };
  pragmatapro  = super.callPackage ./pragmatapro { };
  sonos        = super.callPackage ./sonos { };
  sublime3     = super.sublime3.override { gksuSupport = true; };
  tflfonts     = super.callPackage ./tflfonts { };
}
