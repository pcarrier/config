self: super:
{
  baze = super.callPackage ./baze { };
  kernelPackages = super.linuxPackages_4_13;
  minijail = super.callPackage ./minijail { };
  monorepoenv = super.callPackage ./monorepoenv { };
  mpv = super.mpv.override { vapoursynthSupport = true; };
  mtr = super.mtr.override { withGtk = true; };
  clipshot = super.callPackage ./clipshot { };
  pragmatapro = super.callPackage ./pragmatapro { };
  sonos = super.callPackage ./sonos { };
  sublime3 = super.sublime3.override { gksuSupport = true; };
  pcarrier.env = super.callPackage ./pcarrier/env { };
}
