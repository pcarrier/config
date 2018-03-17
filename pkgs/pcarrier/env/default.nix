{ pkgs, buildEnv, ... }:

buildEnv {
  name = "pcarrier-env";
  paths = with pkgs; [
    # calligra clipshot krita okular paprefs plex
    # oxygen-icons5
    # haskellPackages.greenclip lxqt.pavucontrol-qt
    # slack skype signal-desktop spotify steam
    # virtmanager zoom-us
    acpi alacritty alsaUtils aria2 audacity
    baze bc binutils
    coreutils cpufrequtils ctags
    dfc direnv displays dolphin
    ethtool
    ffmpeg file filelight firefox fzf
    gitAndTools.gitFull gitAndTools.hub
    glxinfo goimports google-chrome gradle
    htop
    idea.idea-ultimate iftop iotop iperf
    jq
    ldns libarchive ltrace lzip
    manpages maven mosh most mpv
    ncdu
    nix-prefetch-scripts nix-repl nodejs nzbget
    patchelf pciutils poppler_utils posix_man_pages powertop pstree
    rclone rofi rsync rtorrent ruby
    socat sshfs-fuse strace sublime3 sysstat
    tig tmux tokei tree
    unrar unzip usbutils
    visualvm vim
    wget wireshark-qt
    xlibs.xkill xorg.xev xorg.xrandr xsettingsd
    whois
    yarn
    zip
    zulu8 # oraclejdk8 zulu9
    direnv gcc python # because monorepo
  ];
}
