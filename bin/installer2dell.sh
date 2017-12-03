#!/usr/bin/env bash

set -xeuo pipefail

nix-env -iAf '<nixpkgs>' cryptsetup
cryptsetup luksOpen /dev/nvme0n1p2 dell
zpool import tank
mount -t zfs tank/root /mnt/
mount -t zfs tank/repos /mnt/repos
mount -t zfs tank/home /mnt/home
mount /dev/disk/by-label/EFI /mnt/boot
mount -o bind {,/mnt}/dev
mount -o bind {,/mnt}/sys
mount -o bind {,/mnt}/proc
cp /etc/resolv.conf /mnt/etc/resolv.conf
chroot /mnt /nix/var/nix/profiles/system/activate 
chroot /mnt /repos/config/bin/dell.sh --option build-use-sandbox false switch
