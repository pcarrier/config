#!/usr/bin/env bash
sudo nixos-rebuild \
  -I nixos-config=/repos/config/dell.nix \
  -I nixpkgs=/repos/nixpkgs \
  switch
