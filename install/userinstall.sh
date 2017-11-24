#!/usr/bin/env bash
exec nix-env -f '<nixpkgs>' -riA pcarrier.env
