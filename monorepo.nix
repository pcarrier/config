{ pkgs ? import <nixpkgs> { } } :
(pkgs.fhsjail {
  name = "monorepo";
  profile = ''
    . /repos/monorepo/tools/env.sh
  '';
  includedPkgs = pkgs: with pkgs; [
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
    (toString gcc.cc.lib)
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
}).env
