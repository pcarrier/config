{ pkgs, buildEnv, ... }:

buildEnv {
  name = "pcarrier-env";
  paths = with pkgs; [
    # calligra krita okular plex
    # slack skype signal-desktop spotify steam
    # virtmanager zoom-us
    acpi
    alacritty
    alsaUtils
    aria2
    audacity
    baze
    bc
    binutils
    clipshot
    coreutils
    cpufrequtils
    ctags
    dfc
    direnv
    displays
    dolphin
    ethtool
    ffmpeg
    file
    filelight
    firefox
    fzf
    gitAndTools.gitFull
    gitAndTools.grv
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
    ldns
    libarchive
    lm_sensors
    ltrace
    lxqt.pavucontrol-qt
    lzip
    manpages
    maven
    mosh
    most
    mpv
    ncdu
    nix-prefetch-scripts
    nix-repl
    nodejs
    nzbget
    oxygen-icons5
    paprefs
    patchelf
    pciutils
    poppler_utils
    posix_man_pages
    powertop
    pstree
    qjackctl
    rclone
    rofi
    rsync
    rtorrent
    ruby
    scrot
    socat
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
    usbutils
    visualvm
    vim
    wget
    wireshark-qt
    xclip
    xlibs.xkill
    xorg.xev
    xorg.xrandr
    xsettingsd
    whois
    yarn
    zip
    zulu8 # oraclejdk8 zulu9
    direnv gcc python # because monorepo
  ];
}
