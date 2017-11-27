#!/usr/bin/env bash
sudo nixos-rebuild \
  -I nixos-config=/repos/config/system.nix \
  -I nixpkgs=/repos/nixpkgs \
  switch
