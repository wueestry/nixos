# Gnome configuration
#

{ config, lib, pkgs, ... }:

{
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
    seahorse.enable = true;
  };

  services = {
    xserver.desktopManager.gnome.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;

  environment = {
    systemPackages = with pkgs; [ # Packages installed
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnome.adwaita-icon-theme
      polkit_gnome
    ];
    gnome.excludePackages = (with pkgs; [ # Gnome ignored packages
      gnome-tour
      gnome-photos
      gnome-text-editor
    ]) ++ (with pkgs.gnome; [
      cheese
      gnome-music
      gnome-terminal
      gnome-maps
      gnome-contacts
      gedit
      epiphany
      geary
      evince
      eog
      totem
      gnome-system-monitor
      gnome-calendar
      yelp
    ]);
  };
}
