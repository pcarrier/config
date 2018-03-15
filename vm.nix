{config, lib, pkgs, ...}:
{
  boot = {
    initrd.availableKernelModules = [ "nvme" "mptspi" "vmw_balloon" "vmwgfx" "vmw_vmci" "vmw_vsock_vmci_transport" "vmxnet3" "vsock" ];
    loader.systemd-boot.enable = true;
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 1048576;
      "fs.inotify.max_user_instances" = 1024;
      "fs.inotify.max_queued_events" = 32768;
      "vm.dirty_writeback_centisecs" = 6000;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      coreutils
      linuxPackages.perf
      powertop
    ];
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
  hardware = {
    opengl.driSupport = true;
    pulseaudio.enable = true;
    u2f.enable = true;
  };
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    supportedLocales = [
      "en_CA.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  networking = {
    connman.enable = true;
    enableIPv6 = false;
    extraHosts = "127.0.0.1 pcarrier-vm";
    firewall.allowedTCPPorts = [ 80 443 32400 32469 ];
    hostName = "pcarrier-vm";
  };
  nix = {
    gc.automatic = false;
    package = pkgs.nixUnstable;
    readOnlyStore = true;
    useSandbox = true;
    maxJobs = lib.mkDefault 4;
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
  security.sudo.wheelNeedsPassword = false;
  services = {
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
    resolved.enable = true;
    timesyncd.enable = false;
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.lightdm = {
        enable = true;
        greeter.enable = false;
        autoLogin = {
          enable = true;
          user = "pcarrier";
        };
      };
      dpi = 96;
      layout = "us";
      # xkbOptions = "ctrl:nocaps";
      windowManager.i3.enable = true;
    };
    vmwareGuest.enable = true;
  };
  system.stateVersion = "17.09";
  systemd.sockets."systemd-rfkill".enable = false;
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
