{ pkgs, buildEnv, ... }:

buildEnv {
  name = "pcarrier-env";
  paths = with pkgs; [
    acpi
    alacritty
    aria2
    baze
    dash
    clipshot
    coreutils
    ctags
    dfc
    direnv
    dolphin
    ffmpeg
    file
    fzf
    gitAndTools.gitFull
    gitAndTools.hub
    glxinfo
    gnome3.adwaita-icon-theme
    google-chrome
    htop
    idea.idea-ultimate
    iotop
    jq
    lastpass-cli
    libarchive
    ltrace
    manpages
    minijail
    mosh
    most
    mpv
    nix-prefetch-scripts
    nix-repl
    nsjail
    nzbget
    oraclejdk8
    oxygen-icons5
    pavucontrol
    posix_man_pages
    powertop
    rclone
    rofi
    rsync
    rtorrent
    scrot
    slack
    spotify
    sshfs-fuse
    strace
    sublime3
    tig
    tmux
    tree
    unrar
    unzip
    visualvm
    vim
    wget
    xorg.xev
    zip
    # because monorepo
    python gcc
  ];
}
