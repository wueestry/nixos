#
# Gnome Home-Manager Configuration
#
# Dconf settings can be found by running "$ dconf watch /"
#

{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs.gnomeExtensions; [
        blur-my-shell
        just-perfection
        caffeine
        dotspaces
        bluetooth-quick-connect
        gsconnect                         # kdeconnect enabled in default.nix
        pop-shell
        appindicator
        alphabetical-app-grid
    ];
}