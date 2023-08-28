#
#  General Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix *
#   └─ ./modules
#       ├─ ./programs
#       │   └─ default.nix
#       └─ ./services
#           └─ default.nix
#

{ config, lib, pkgs, unstable, user, ... }:

{
    imports = (import ../modules/programs);
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";

        packages = (with pkgs; [
            # Terminal
            htop              # Resource Manager
            tldr              # Helper
            gcc


            # Video/Audio
            feh               # Image Viewer
            mpv               # Media Player
            pavucontrol       # Audio Control

            # Apps
            firefox          # Browser
            librewolf              # Browser
            nextcloud-client
            obsidian
            #vscode

            # File Management
            okular            # PDF Viewer
            p7zip             # Zip Encryption
            rsync             # Syncer - $ rsync -r dir1/ dir2/
            unzip             # Zip Files
            unrar             # Rar Files
            zip               # Zip
            qt5ct
            neofetch

            # General home-manager
            kitty        # Terminal Emulator
            dunst            # Notifications
            libnotify        # Dependency for Dunst
            rofi-wayland             # Menu
            rofi-power-menu  # Power Menu
            networkmanagerapplet

            # Desktop
            steam            # Games
            
            # Laptop
            libreoffice      # Office Tools
        ]) ++ (with unstable; [
            distrobox
            thunderbird
            nwg-displays
        ]);


        pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
            gtk.enable = true;
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
        };
        stateVersion = "23.05";
    };

    programs = {
        home-manager.enable = true;
        git = {
            enable = true;
            userName  = "Ryan Wüest";
            userEmail = "ryan.wueest@protonmail.com";
	    };
    };

    gtk = {                                     # Theming
        enable = true;
        cursorTheme = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
        };
        theme = {
            name = "Nordic-darker";
            package = pkgs.nordic;
        };
        iconTheme = {
            name = "Numix-Circle";
            package = pkgs.numix-icon-theme-circle;
        };
        font = {
            name = "Roboto";
        };                                        # Cursor is declared under home.pointerCursor
    };
    qt = {
        enable = true;
        platformTheme = "gtk";
        style = {
            name = "Nordic";
            package = pkgs.nordic;
        };
    };
}