{config, lib, pkgs, ...}:
{
  boot = {
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 1048576;
      "fs.inotify.max_user_instances" = 1024;
      "fs.inotify.max_queued_events" = 32768;
      "vm.dirty_writeback_centisecs" = 6000;
    };
    kernelPackages = pkgs.linuxPackages_4_14;
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    extraModprobeConfig = ''
      options snd_hda_intel power_save=1
      options zfs.zfs_arc_max=8589934592;
    '';
    zfs.enableUnstable = true;
  };
  environment.systemPackages = with pkgs; [
    breeze-gtk breeze-qt5 breeze-icons gnome3.adwaita-icon-theme hicolor_icon_theme
    coreutils
    linuxPackages_4_14.perf
    mbuffer
    powertop
  ];
  hardware = {
    bluetooth.enable = true;
    bumblebee.enable = true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    opengl.driSupport = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull; # for Bluetooth
    };
    u2f.enable = true;
  };
  fileSystems = {
    "/" = { device = "tank/root"; fsType = "zfs"; };
    "/boot" = { device = "/dev/disk/by-label/EFI"; fsType = "vfat"; };
    "/downloads" = { device = "tank/downloads"; fsType = "zfs"; };
    "/home" = { device = "tank/home"; fsType = "zfs"; };
    "/repos" = { device = "tank/repos"; fsType = "zfs"; };
    "/var/lib/docker" = { device = "tank/docker"; fsType = "zfs"; };
    "/var/tmp" = { device = "tmpfs" ; fsType = "tmpfs"; };
    "/tmp" = { device = "tmpfs" ; fsType = "tmpfs"; };
  };
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      emojione
      font-droid
      pkgs.pragmatapro
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
    ];
    fontconfig = {
      antialias = true;
      # dpi = 200;
      enable = true;
    };
  };
  networking = {
    enableB43Firmware = true;
    enableIPv6 = false;
    extraHosts = "127.0.0.1 pcarrier-workstation";
    firewall.allowedTCPPorts = [ 32400 ];
    hostId = "310491f9";
    hostName = "pcarrier-workstation";
    networkmanager.enable = true;
  };
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
    supportedLocales = [
      "en_CA.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  nix = {
    gc.automatic = false;
    package = pkgs.nixUnstable;
    readOnlyStore = true;
    useSandbox = true;
    maxJobs = lib.mkDefault 8;
    nixPath = [
      "nixos-config=/repos/config/dell.nix"
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
  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
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
    sudo.wheelNeedsPassword = false;
  };
  services = {
    acpid.enable = true;
    avahi = {
      enable = true;
      ipv6 = false;
    };
    chrony = {
      enable = true;
      servers = [ "0.ca.pool.ntp.org" "1.ca.pool.ntp.org" "2.ca.pool.ntp.org" "3.ca.pool.ntp.org" ];
    };
    locate.enable = true;
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
        HandeSuspendKey=ignore
        HandleHibernateKey=ignore
      '';
    };
    nscd.enable = false;
    openssh = {
      enable = true;
      passwordAuthentication = false;
      startWhenNeeded = true;
    };
    plex.enable = true;
    redshift = {
      enable = true;
      # Toronto
      latitude = "43.6532";
      longitude = "-79.3832";
      temperature = {
        day = 5700;
        night = 3500;
      };
      brightness = {
        day = "1.0";
        night = "0.7";
      };
    };
    udev.extraRules = ''
      SUBSYSTEM=="net", ATTR{address}=="44:1c:a8:e4:09:af", NAME="wl0"
      SUBSYSTEM=="net", ATTR{address}=="00:50:b6:21:47:96", NAME="us0"
      SUBSYSTEM=="net", ATTR{address}=="2c:56:dc:48:1c:e9", NAME="ws0"

      ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}="min_power"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
    '';
    xserver = {
      displayManager.sddm = {
        enable = true;
        theme = "breeze";
      };
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        naturalScrolling = true;
      };
      xkbOptions = "ctrl:nocaps";
      windowManager.i3.enable = true;
    };
    znapzend = {
      autoCreation = true;
      enable = true;
      noDestroy = true;
    };
  };
  system.stateVersion = "17.09";
  time.timeZone = "America/Toronto";
  users = {
    extraUsers.pcarrier = {
      home = "/home";
      extraGroups = [
        "audio"
        "disk"
        "docker"
        "libvirtd"
        "networkmanager"
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
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
    };
    libvirtd.enable = true;
  };
}
