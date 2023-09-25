#
# XFCE configuration
#

{ config, lib, pkgs, ... }:

{
    programs = {
        seahorse.enable = true;
    };
    security.pam.services.gdm.enableGnomeKeyring = true;

    services.gnome.gnome-keyring.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
}
