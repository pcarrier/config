{ pkgs, buildEnv, ... }:

buildEnv {
  name = "pcarrier-env";
  paths = with pkgs; [
    acpi
    alacritty
    aria2
    baze
    breeze-gtk breeze-qt5 breeze-icons
    dash
    calligra
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
    # gnome3.adwaita-icon-theme
    google-chrome
    haskellPackages.greenclip
    htop
    idea.idea-ultimate
    iftop
    iotop
    jq
    krita
    lastpass-cli
    ldns
    libarchive
    ltrace
    manpages
    minijail
    mosh
    most
    mpv
    ncdu
    nix-prefetch-scripts
    nix-repl
    nsjail
    nzbget
    okular
    oraclejdk8
    oxygen-icons5
    paprefs
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
    virtmanager
    wget
    xclip
    xlibs.xkill
    xorg.xev
    xorg.xrandr
    zip
    direnv gcc python # because monorepo
  ];
}
