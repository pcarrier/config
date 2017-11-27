{ pkgs ? import <nixpkgs> { } } :

let tools = with pkgs; [
  bash
  curl
  direnv
  docker
  gcc
  gitAndTools.gitFull
  gitAndTools.hub
  openssh
  python
  gnutar
  unzip
  which
];
envScripts = builtins.filterSource
  (path: type: pkgs.lib.hasSuffix ".sh" path)
  ./tools/env;
mkEnvPackage = name:
  let
    scriptPath = ./tools/env + "/${name}";
  in
  pkgs.stdenv.mkDerivation {
    name = "monorepo-env-${name}";
    buildInputs = tools;
    buildCommand = ''
      MONOREPO_INSTALL_DIR=$out ${pkgs.bash}/bin/bash ${scriptPath}
    '';
  };
envPkgs = map mkEnvPackage
              (builtins.attrNames (builtins.readDir envScripts));
in
pkgs.buildEnv {
  name = "monorepo-env";
  paths = envPkgs ++ tools;
}
