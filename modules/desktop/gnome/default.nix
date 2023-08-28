#
# Gnome configuration
#

{ config, lib, pkgs, ... }:

{
    programs = {
        kdeconnect = {
            enable = true;
            package = pkgs.gnomeExtensions.gsconnect;
        };
    };

    services = {
        xserver.desktopManager.gnome.enable = true;
        udev.packages = with pkgs; [
            gnome.gnome-settings-daemon
        ];
    };

    environment = {
        systemPackages = with pkgs; [                 # Packages installed
            gnome.dconf-editor
            gnome.gnome-tweaks
            gnome.adwaita-icon-theme
        ];
        gnome.excludePackages = (with pkgs; [         # Gnome ignored packages
            gnome-tour
            gnome-photos
            gnome-text-editor
        ]) ++ (with pkgs.gnome; [
            cheese
            gnome-music
            gnome-terminal
            gedit
            epiphany
            geary
            evince
            totem
            gnome-system-monitor
            gnome-calendar
        ]);
    };
}