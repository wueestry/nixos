# Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./bspwm
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ docker.nix
#       └─ ./hardware
#           └─ default.nix
#

{ config, pkgs, unstable, user, ... }:

{
  imports = # For now, if applying to other system, swap files
    [ (import ./hardware-configuration.nix) ]
    ++ # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [ (import ../../modules/desktop/hyprland) ] ++ # Window Manager
    [ (import ../../modules/desktop/gnome/gnome-polkit.nix) ] ++
    #[(import ../../modules/desktop/gnome)] ++
    (import ../../modules/desktop/virtualisation); # Docker

  boot = { # Boot options
    loader = { # For legacy boot:
      systemd-boot = {
        enable = true;
        configurationLimit = 3; # Limit the amount of configurations
      };
      efi = { canTouchEfiVariables = true; };
      timeout = 5; # Grub auto select time
    };
    # initrd.kernelModules = [ "nvidia" ];
    # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  sound.enable = true;

  hardware = {
    # pulseaudio.enable = false;
    sane = { # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;

      # powerManagement.enable = true;
      # powerManagement.finegrained = true;

      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      open = true;

      # Enable the nvidia settings menu
      nvidiaSettings = true;

      prime = {
        sync.enable = true;

        amdgpuBusId = "PCI:1:0:0";
        nvidiaBusId = "PCI:4:0:0";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      cudaPackages.cudatoolkit
      libsForQt5.dolphin
      libsForQt5.dolphin-plugins
      libsForQt5.ark
    ];
  };

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart =
      "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  programs = { # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;

    #thunar = {
    #  enable = true;
    #  plugins = with pkgs.xfce; [
    #    thunar-archive-plugin
    #    thunar-volman
    #    thunar-media-tags-plugin
    #  ];
    #};
  };

  services = {
    avahi = { # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = { # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    blueman.enable = true;
    printing = { # Printing and drivers for TS5300
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    system76-scheduler.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVENOR_ON_AC = "performance";
        CPU_SCALING_GOVENOR_ON_BAT = "powersafe";
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    flatpak.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      # add hyprland to display manager sessions

      # Enable NVIDIA driver
      #videoDrivers = [ "modesetting" ];
      videoDrivers = [ "nvidia" ];

      # Keyboard layout
      layout = "ch";
      xkbVariant = "";
    };
  };

  powerManagement.powertop.enable = true;
}
