#
# KDE Plasma 5 configuration
#

{ config, lib, pkgs, unstable, ... }:

{
    services = {
        xserver = {
            desktopManager.plasma5 = {
                enable = true;                            # Desktop Manager
            };
            displayManager.defaultSession = "plasmawayland";
            displayManager.sddm = {
                enable = true;
                enableHidpi = true;
                theme = "chili";
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
        ] ++ (with unstable; [
            sddm-chili-theme
        ]);

    };
    security.pam.services.sddm.enableKwallet = true;

}