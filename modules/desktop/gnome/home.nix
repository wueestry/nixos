#
# Gnome Home-Manager Configuration
#
# Dconf settings can be found by running "$ dconf watch /"
#

{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
        gnomeExtensions.tray-icons-reloaded
        gnomeExtensions.blur-my-shell
        gnomeExtensions.battery-indicator-upower
        gnomeExtensions.just-perfection
        gnomeExtensions.caffeine
        gnomeExtensions.workspace-indicator-2
        gnomeExtensions.bluetooth-quick-connect
        gnomeExtensions.gsconnect                         # kdeconnect enabled in default.nix
        gnomeExtensions.pip-on-top
        gnomeExtensions.pop-shell
    ];
}