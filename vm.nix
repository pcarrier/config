{config, lib, pkgs, ...}:
{
  boot = {
    initrd.availableKernelModules = [ "mptspi" "vmw_balloon" "vmwgfx" "vmw_vmci" "vmw_vsock_vmci_transport" "vmxnet3" "vsock" ];
    loader.systemd-boot.enable = true;
    kernelParams = [ "nomodeset" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 1048576;
      "fs.inotify.max_user_instances" = 1024;
      "fs.inotify.max_queued_events" = 32768;
      "vm.dirty_writeback_centisecs" = 6000;
    };
  };
  environment.systemPackages = with pkgs; [
    breeze-gtk
    breeze-qt5
    breeze-icons
    gnome3.adwaita-icon-theme
    hicolor_icon_theme
    coreutils
    powertop
  ];
  hardware = {
    opengl.driSupport = true;
    pulseaudio.enable = true;
    u2f.enable = true;
  };
  fileSystems = {
    "/" = { device = "/dev/disk/by-label/root"; fsType = "ext4"; };
    "/boot" = { device = "/dev/disk/by-label/BOOT"; fsType = "vfat"; };
  };
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      emojione
      font-droid
      pragmatapro
      tflfonts
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
    ];
    fontconfig = {
      antialias = true;
      enable = true;
    };
  };
  i18n = {
    consoleFont = "ter-u12n";
    consoleKeyMap = "us";
    consolePackages = [ pkgs.terminus_font ];
    defaultLocale = "en_CA.UTF-8";
    supportedLocales = [
      "en_CA.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  networking = {
    enableIPv6 = false;
    extraHosts = "127.0.0.1 pcarrier-vm";
    firewall.allowedTCPPorts = [ 80 443 32400 32469 ];
    hostName = "pcarrier-vm";
    #useNetworkd = true;
  };
  nix = {
    gc.automatic = false;
    package = pkgs.nixUnstable;
    readOnlyStore = true;
    useSandbox = true;
    maxJobs = lib.mkDefault 8;
    nixPath = [
      "nixos-config=/repos/config/vm.nix"
      "nixpkgs=/repos/nixpkgs"
    ];
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
    overlays = [ (import ./pkgs) ];
  };
  programs = {
    mosh.enable = true; # for UDP firewall
    mtr.enable = true; # SUID
    qt5ct.enable = true;
    ssh = {
      startAgent = true;
      extraConfig = ''
        StrictHostKeyChecking=no
      '';
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      promptInit = "";
      syntaxHighlighting.enable = true;
    };
  };
  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"   ; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio" ; type = "-"   ; value = "99"       ; }
      { domain = "@audio"; item = "nofile" ; type = "soft"; value = "99999"    ; }
      { domain = "@audio"; item = "nofile" ; type = "hard"; value = "99999"    ; }
    ];
    sudo.wheelNeedsPassword = false;
  };
  services = {
    locate.enable = true;
    resolved.enable = true;
    openssh = {
      enable = true;
      passwordAuthentication = false;
      startWhenNeeded = true;
    };
    xserver = {
      enable = true;
      dpi = 96;
      displayManager.lightdm = {
        enable = true;
        greeter.enable = false;
        autoLogin = {
          enable = true;
          user = "pcarrier";
        };
      };
      layout = "us";
      # xkbOptions = "ctrl:nocaps";
      windowManager.i3.enable = true;
    };
    vmwareGuest.enable = true;
  };
  system.stateVersion = "17.09";
  time.timeZone = "America/Toronto";
  users = {
    extraUsers.pcarrier = {
      initialHashedPassword = "$6$T.YMRekPaHmm$KQfAVkgfFfeFU6Ervn19QH09FEWOhVrKi5GYH9yG6ZqaPxJEHHNthyHWrnA50rg9pmd2mlJXcPY5UqQ4/yKJo/";
      home = "/home";
      extraGroups = [
        "audio"
        "docker"
        "systemd-journal"
        "video"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZ73DWvqvQNUr14LO6ha6hLKacwXOfkAgA0G8+dC/48"
      ];
      group = "users";
      isNormalUser = true;
      uid = 1000;
      useDefaultShell = true;
    };
    defaultUserShell = "/run/current-system/sw/bin/zsh";
  };
  virtualisation.docker.enable = true;
}
