#
#  Specific system configuration settings for desktop
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
    imports =                                               # For now, if applying to other system, swap files
        [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
        [(import ../../modules/desktop/hyprland)] ++ # Window Manager
        [(import ../../modules/desktop/gnome)] ++
        (import ../../modules/desktop/virtualisation);  # Docker

    boot = {                                  # Boot options
        loader = {                                  # For legacy boot:
            systemd-boot = {
                enable = true;
                configurationLimit = 3;                 # Limit the amount of configurations
            };
            efi = {
                canTouchEfiVariables = true;
            };
            timeout = 5;                              # Grub auto select time
        };
        # initrd.kernelModules = [ "nvidia" ];
        # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    };

    sound.enable = true;


    hardware = {
        pulseaudio.enable = false;
        sane = {                         # Used for scanning with Xsane
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

            powerManagement.enable = true;

            # Use the open source version of the kernel module
            # Only available on driver 515.43.04+
            open = false;

            # Enable the nvidia settings menu
            nvidiaSettings = true;

            prime = {
                sync.enable = true;

                amdgpuBusId = "PCI:1:0:0";
                nvidiaBusId = "PCI:4:0:0";
            };
        };
    };

    # environment = {
    #     systemPackages = with pkgs; [
    #     ];
    # };

    programs = {                              # No xbacklight, this is the alterantive
        dconf.enable = true;
        light.enable = true;
    };


    services = {
        blueman.enable = true;
        avahi = {                               # Needed to find wireless printer
            enable = true;
            nssmdns = true;
            publish = {                           # Needed for detecting the scanner
                enable = true;
                addresses = true;
                userServices = true;
            };
        };
        printing = {                            # Printing and drivers for TS5300
            enable = true;
            drivers = [ pkgs.cnijfilter2 ];
        };
        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
            jack.enable = true;
        };
        xserver = {
            # Enable the X11 windowing system.
            enable = true;
            displayManager.gdm = {
                enable = true;
                wayland  = true;
            };

            # Enable NVIDIA driver
            videoDrivers = [ "modesetting" ];

            # Keyboard layout
            layout = "ch";
		    xkbVariant = "";
	    };
    };
}
