import <nixpkgs> {
  config = {
    allowUnfree = true;
    packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {
      mpv = super.mpv.override {
        vapoursynthSupport = true;
      };
      shell-env = pkgs.buildEnv {
        name = "shell-env";
        paths = [
          acpi
          alacritty
          aria2
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
          linuxPackages.perf
          ltrace
          manpages
          mosh
          most
          mpv
          nix-repl
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
          zip
        ];
      };
    };
  };
}
