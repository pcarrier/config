self: super:
{
  baze = super.callPackage ./baze { };
  kernelPackages = super.linuxPackages_4_13;
  minijail = super.callPackage ./minijail { };
  mpv = super.mpv.override { vapoursynthSupport = true; };
  clipshot = super.callPackage ./clipshot { };
  pragmatapro = super.callPackage ./pragmatapro { };
  sublime3 = super.sublime3.override { gksuSupport = true; };
  pcarrier.env = super.callPackage ./pcarrier/env { };
}
