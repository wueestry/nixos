#
# KDE Plasma 5 configuration
#

{ config, lib, pkgs, ... }:

{
    services = {
        xserver = {
            desktopManager.plasma5 = {
                enable = true;                            # Desktop Manager
            };
        };
    };

    environment = {
        plasma5.excludePackages = with pkgs.libsForQt5; [
            elisa
            khelpcenter
            konsole
            oxygen
        ];
        systemPackages = with pkgs.libsForQt5; [                 # Packages installed
            bismuth
            kwallet
            packagekit-qt
            qtstyleplugin-kvantum
        ];

    };
    security.pam.services.gdm.enableKwallet = true;

}