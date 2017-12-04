#!/usr/bin/env sh
sudo nixos-rebuild \
  -I nixos-config=/repos/config/workstation.nix \
  -I nixpkgs=/repos/nixpkgs \
  switch "$@"
