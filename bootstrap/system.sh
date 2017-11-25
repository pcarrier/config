#!/usr/bin/env bash
sudo nixos-rebuild \
  -I nixos-config=/home/repos/config/system.nix \
  -I nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs \
  -I /nix/var/nix/profiles/per-user/root/channels \
  switch
