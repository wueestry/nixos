#
# KDE Plasma 5 configuration
#

{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      displayManager = {
        sddm.enable = true;          # Display Manager
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5 = {
        enable = true;                            # Desktop Manager
        excludePackages = with pkgs.libsForQt5; [
          elisa
          khelpcenter
          konsole
          oxygen
        ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs.libsForQt5; [                 # Packages installed
      packagekit-qt
      bismuth
    ];

  };
}