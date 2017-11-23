#!/usr/bin/env bash
exec nix-env -f /home/repos/config/user.nix -ri shell-env
