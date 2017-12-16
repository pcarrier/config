{ pkgs, buildEnv, ... }:

buildEnv {
  name = "pcarrier-env";
  paths = with pkgs; [
    acpi
    alacritty
    #ardour
    aria2
    audacity
    baze
    bc
    dash
    calligra
    clipshot
    coreutils
    cpufrequtils
    ctags
    dfc
    direnv
    dmidecode
    dolphin
    ethtool
    ffmpeg
    file
    firefox
    fzf
    gitAndTools.gitFull
    gitAndTools.hub
    glxinfo
    google-chrome
    gradle
    haskellPackages.greenclip
    htop
    idea.idea-ultimate
    iftop
    iotop
    iperf
    jq
    krita
    lastpass-cli
    ldns
    libarchive
    lm_sensors
    ltrace
    lxqt.pavucontrol-qt
    manpages
    maven
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
    patchelf
    #pavucontrol
    plex
    posix_man_pages
    powertop
    qjackctl
    rclone
    rofi
    rsync
    rtorrent
    ruby
    scrot
    #skype
    slack
    socat
    spotify
    sshfs-fuse
    strace
    sublime3
    sysstat
    tig
    tmux
    tokei
    tree
    unrar
    unzip
    visualvm
    vim
    virtmanager
    wget
    wireshark-qt
    xclip
    xlibs.xkill
    xorg.xev
    xorg.xrandr
    xsettingsd
    whois
    wine
    zip
    direnv gcc python # because monorepo
  ];
}
