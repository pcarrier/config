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
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    extraModprobeConfig = ''
      options snd_hda_intel power_save=1
    '';
    zfs.enableUnstable = true;
  };
  environment.systemPackages = with pkgs; [
    coreutils
    kernelPackages.perf
    powertop
  ];
  hardware = {
    bluetooth.enable = true;
    bumblebee.enable = true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    opengl.driSupport = true;
    pulseaudio.enable = true;
    u2f.enable = true;
  };
  fileSystems = {
    "/boot" = { device = "/dev/disk/by-uuid/AECD-170A"; fsType = "vfat"; };
    "/" = { device = "dell/root/default"; fsType = "zfs"; };
    "/var/lib/docker/zfs" = { device = "dell/root/docker"; fsType = "zfs"; };
    "/home" = { device = "dell/data/home"; fsType = "zfs"; };
    "/repos" = { device = "dell/data/repos"; fsType = "zfs"; };
    "/tmp" = { device = "tmpfs" ; fsType = "tmpfs"; };
    "/var/tmp" = { device = "tmpfs" ; fsType = "tmpfs"; };
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
    extraHosts = "127.0.0.1 pcarrier-dell";
    hostId = "310491f9";
    hostName = "pcarrier-dell";
    networkmanager.enable = true;
  };
  i18n = {
    consoleFont = "ter-v32n";
    consoleKeyMap = "us";
    consolePackages = [ pkgs.terminus_font ];
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
      "nixos-config=/repos/config/system.nix"
      "nixpkgs=/repos/nixpkgs"
    ];
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./pkgs) ];
  };
  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
  };
  programs = {
    mosh.enable = true; # for UDP firewall
    mtr.enable = true; # SUID
    ssh = {
      startAgent = true;
      extraConfig =
      ''
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
      authorizedKeysFiles = [ ".ssh/authorized_keys" ];
      enable = true;
      passwordAuthentication = false;
    };
    redshift = {
      enable = true;
      # Toronto
      latitude = "43.6532";
      longitude = "-79.3832";
    };
    udev.extraRules =
    ''
      SUBSYSTEM=="net", ATTR{address}=="44:1c:a8:e4:09:af", NAME="wl0"

      ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}="min_power"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
    '';
    xserver = {
      displayManager.sddm.enable = true;
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
