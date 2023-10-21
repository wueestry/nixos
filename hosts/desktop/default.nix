# Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktop
#           ├─ ./hyprland
#           │   └─ default.nix
#           └─ ./virtualisation
#               └─ default.nix
#
#
#

{ pkgs, unstable, lib, user, ... }:

{
  imports = [ (import ./hardware-configuration.nix) ]
    ++ # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [ (import ../../modules/desktop/hyprland) ] ++ # Window Manager
    [ (import ../../modules/desktop/gnome) ]
    ++ (import ../../modules/desktop/virtualisation); # Virtual Machines & VNC

  boot.loader = { # Boot options
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
  };

  programs.seahorse.enable = true;

  hardware = {
    pulseaudio.enable = false;
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

      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      open = true;

      # Enable the nvidia settings menu
      nvidiaSettings = true;
    };

  };

  environment = { # Packages installed system wide
    systemPackages = with pkgs;
      [ # This is because some options need to be configured.
        polkit_gnome
      ];
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    blueman.enable = true; # Bluetooth

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      displayManager.gdm = { enable = true; };

      # Enable NVIDIA driver
      videoDrivers = [ "nvidia" ];

      # Keyboard layout
      layout = "us";
      xkbVariant = "altgr-intl";
    };

    pipewire = { # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
