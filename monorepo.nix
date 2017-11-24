{ pkgs } :
let env = pkgs.buildFHSUserEnv {
  name = "monorepo";
  targetPkgs = pkgs: with pkgs; [
    bash
    curl
    direnv
    docker
    gcc
    gitAndTools.gitFull
    gitAndTools.hub
    libstdcxx5
    openssh
    python
    gnutar
    unzip
    which
    zsh
  ];
  runScript = "zsh";
}; in env.env
