# General Home-manager configuration
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
      coreutils

      # Terminal
      gcc
      cmake
      python3
      btop # Resource Manager
      nodejs
      tldr # Helper
      gnumake

      # Video/Audio
      image-roll # Image Viewer
      mpv # Media Player
      pavucontrol # Audio Control

      # Apps
      brave # Browser
      librewolf # Browser
      nextcloud-client
      #vscode

      # File Management
      neofetch
      okular # PDF Viewer
      p7zip # Zip Encryption
      qt5ct
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unrar # Rar Files
      unzip # Zip Files
      zip # Zip
      fzf
      ranger
      xarchiver
      gittyup

      # General home-manager
      dunst # Notifications
      kitty # Terminal Emulator
      libnotify # Dependency for Dunst
      networkmanagerapplet
      rofi-power-menu # Power Menu
      rofi-wayland # Menu

      # Desktop
      #steam # Games

      # Laptop
      libreoffice # Office Tools
      thunderbird

      simple-scan
      appimage-run # Tool to run appimages
      lshw # Tool to get hardware info
      libsForQt5.qtstyleplugin-kvantum
    ]) ++ (with unstable; [ distrobox nwg-displays obsidian ]);

    pointerCursor =
      { # This will set cursor system-wide so applications can not choose their own
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
      userName = "Ryan Wüest";
      userEmail = "ryan.wueest@protonmail.com";
    };
  };

  gtk = { # Theming
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
    font = { name = "Roboto"; }; # Cursor is declared under home.pointerCursor
  };
  qt = {
    enable = true;
    style = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };
}
