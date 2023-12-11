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
      # Terminal
      btop # Resource Manager
      tldr # Helper

      # Video/Audio
      mpv # Media Player
      pavucontrol # Audio Control

      # Apps
      brave # Browser
      librewolf # Browser
      nextcloud-client
      #vscode

      # File Management
      neofetch
      zip # Zip
      fzf
      ranger

      # General home-manager
      dunst # Notifications
      kitty # Terminal Emulator
      libnotify # Dependency for Dunst
      networkmanagerapplet
      rofi-wayland # Menu

      # Desktop
      steam
      kooha
      wdisplays
      slack
      gimp
      brightnessctl
      ncspot
      zoom-us

      # Laptop
      onlyoffice-bin # Office Tools
      thunderbird

      distrobox
      obsidian
      logseq
      xwaylandvideobridge

      libsForQt5.qtstyleplugin-kvantum

      # fonts
      jetbrains-mono
      meslo-lgs-nf
      noto-fonts
      roboto
      corefonts
    ]);

    pointerCursor =
      { # This will set cursor system-wide so applications can not choose their own
        gtk.enable = true;
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
    stateVersion = "23.05";
  };

  fonts.fontconfig.enable = true;

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
      name = "Catppuccin-Mocha-Compact-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = { name = "Roboto"; }; # Cursor is declared under home.pointerCursor
  };
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "Catppuccin-Mocha-Teal";
      package = pkgs.catppuccin-kvantum.override {
        accent = "Teal";
        variant = "Mocha";
      };
    };
  };
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Mocha-Teal
    '';

    "Kvantum/Catppuccin".source =
      "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal";
  };
}
