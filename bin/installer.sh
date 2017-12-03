#!/usr/bin/env bash
exec nix-build '<nixpkgs/nixos>' \
  -A config.system.build.isoImage \
  -I nixos-config=/repos/config/installer.nix
