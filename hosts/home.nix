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
            ranger            # File Manager
            tldr              # Helper

            # Video/Audio
            feh               # Image Viewer
            mpv               # Media Player
            pavucontrol       # Audio Control

            # Apps
            firefox          # Browser
            brave              # Browser
            nextcloud-client
            obsidian
            vscode

            # File Management
            okular            # PDF Viewer
            p7zip             # Zip Encryption
            rsync             # Syncer - $ rsync -r dir1/ dir2/
            unzip             # Zip Files
            unrar             # Rar Files
            zip               # Zip
            qt5ct

            # General home-manager
            kitty        # Terminal Emulator
            dunst            # Notifications
            libnotify        # Dependency for Dunst
            rofi-wayland             # Menu
            rofi-power-menu  # Power Menu

            # Desktop
            steam            # Games
            
            # Laptop
            libreoffice      # Office Tools
        ]) ++ (with pkgs.xfce; [
            thunar
            thunar-volman
            thunar-archive-plugin
        ]);


        pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
            gtk.enable = true;
            name = "Numix-Cursor";
            package = pkgs.numix-cursor-theme;
            size = 16;
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
        theme = {
            name = "Nordic";
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
        style = {
            name = "Nordic";
            package = pkgs.nordic;
        };
    };
}