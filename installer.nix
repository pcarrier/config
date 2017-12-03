{ config, lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_4_14;
    supportedFilesystems = [ "zfs" ];
    zfs.enableUnstable = true;
  };
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
  };
  programs.mosh.enable = true;
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZ73DWvqvQNUr14LO6ha6hLKacwXOfkAgA0G8+dC/48"
  ];
}
