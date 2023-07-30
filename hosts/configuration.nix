# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user, inputs, ... }:

{
    users.users.${user} = {                             # System User
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "kvm" "libvirtd" ];
        shell = pkgs.zsh;                               # Default shell
    };

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Zurich";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "de_CH.UTF-8";
		LC_IDENTIFICATION = "de_CH.UTF-8";
		LC_MEASUREMENT = "de_CH.UTF-8";
		LC_MONETARY = "de_CH.UTF-8";
		LC_NAME = "de_CH.UTF-8";
		LC_NUMERIC = "de_CH.UTF-8";
		LC_PAPER = "de_CH.UTF-8";
		LC_TELEPHONE = "de_CH.UTF-8";
		LC_TIME = "de_CH.UTF-8";
	};

    security.rtkit.enable = true;
    security.polkit.enable = true;

    boot.supportedFilesystems = [ "ntfs" ];

    programs.zsh.enable = true;
    programs.seahorse.enable = true;

    fonts.packages = with pkgs; [
		jetbrains-mono
		meslo-lgs-nf
		noto-fonts
		roboto
	];

    environment = {
        variables = {
            TERMINAL = "kitty";
            EDITOR = "nvim";
            VISUAL = "nvim";
        };
        sessionVariables.NIXOS_OZONE_WL = "1";
        systemPackages = with pkgs; [               # Default packages installed system-wide
            git
            gvfs
            killall
            lsb-release
            neovim
            pciutils
            polkit_gnome
            usbutils
            wget
        ];
    };

    services = {
        xserver.displayManager.gdm = {
            enable = true;
            wayland = true;
        };
        printing = {                                # Printing and drivers for TS5300
            enable = true;
            #drivers = [ pkgs.cnijfilter2 ];        # There is the possibility cups will complain about missing cmdtocanonij3. I guess this is just an error that can be ignored for now. Also no longer need required since server uses ipp to share printer over network.
        };
        avahi = {                                   # Needed to find wireless printer
            enable = true;
            nssmdns = true;
            publish = {                             # Needed for detecting the scanner
                enable = true;
                addresses = true;
                userServices = true;
            };
        };
        pipewire = {                                # Sound
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
            jack.enable = true;
        };
        tailscale.enable = true;
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
    };

    security.pam.services.gdm.enableGnomeKeyring = true;

    systemd = { # Starting polkit at login
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };

    nix = {                                         # Nix Package Manager settings
        settings ={
            auto-optimise-store = true;             # Optimise syslinks
        };
        gc = {                                      # Automatic garbage collection
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        registry.nixpkgs.flake = inputs.nixpkgs;
        extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs          = true
        keep-derivations      = true
        '';
    };

    nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
