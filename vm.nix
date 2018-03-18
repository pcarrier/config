{config, lib, pkgs, ...}:
{
  boot = {
    extraModulePackages = [ ];
    initrd.availableKernelModules = [ "nvme" "mptspi" "vmw_balloon" "vmwgfx" "vmw_vmci" "vmw_vsock_vmci_transport" "vmxnet3" "vsock" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 1048576;
      "fs.inotify.max_user_instances" = 1024;
      "fs.inotify.max_queued_events" = 32768;
      "vm.dirty_writeback_centisecs" = 6000;
    };
    kernelModules = [ "kvm-intel" ];
    loader.systemd-boot.enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      coreutils
      linuxPackages.perf
      powertop
    ];
  };
  fileSystems = {
    "/" = { device = "/dev/disk/by-label/slash"; fsType = "ext4"; };
    "/boot" = { device = "/dev/disk/by-label/EFI"; fsType = "vfat"; };
  };
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      dejavu_fonts
      font-droid
      pragmatapro
      tflfonts
      noto-fonts-emoji
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
    connman = {
      enable = true;
      enableVPN = false;
    };
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
    mosh.enable = true;
    mtr.enable = true;
    #qt5ct.enable = true;
    ssh = {
      startAgent = true;
      extraConfig = ''
        StrictHostKeyChecking=no
      '';
    };
    sway.enable = true;
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
      # displayManager.gdm.enable = true;
      displayManager.lightdm = {
        enable = true;
        # greeter.enable = false;
        # autoLogin = {
        #   enable = true;
        #   user = "pcarrier";
        # };
     };
      dpi = 96;
      layout = "us";
      xkbOptions = "lv3:ralt_switch"; # "ctrl:nocaps"
      windowManager.i3.enable = true;
    };
    vmwareGuest.enable = true;
  };
  system.stateVersion = "17.09";
  systemd.sockets."systemd-rfkill".enable = false;
  time.timeZone = "America/Toronto";
  users = {
    extraUsers.pcarrier = {
      home = "/home";
      extraGroups = [
        "audio"
        "docker"
        "systemd-journal"
        "sway"
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
