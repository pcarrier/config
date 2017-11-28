{ buildEnv, pkgs, nsjail, runCommand, stdenv, ... } :

let monorepoEnv = buildEnv {
  name = "monorepo-env";
  paths = with pkgs; [
    bashInteractive
    bzip2
    coreutils
    curl
    diffutils
    direnv
    docker
    findutils
    gawk
    gcc
    gcc.cc.lib
    gitAndTools.gitFull
    gitAndTools.hub
    glibc
    glibcLocales
    gnugrep
    gnused
    gnutar
    gnutar
    gzip
    idea.idea-ultimate
    less
    openssh
    python
    shadow
    su
    unzip
    which
    xz
  ];
};
in runCommand "monorepo" {
  env = runCommand "monorepo-env" {
    shellHook = ''
      echo HOOK
      exec ${nsjail}/bin/nsjail \
      --chroot / \
      --keep_env \
      -R / ${pkgs.bash}/bin/bash
    '';
    } "echo YAY";
} ""