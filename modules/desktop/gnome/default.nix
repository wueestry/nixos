#
# Gnome configuration
#

{ config, lib, pkgs, ... }:

{
    programs = {
        dconf.enable = true;
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
        ]) ++ (with pkgs.gnome; [
            
        ]);
    };
}