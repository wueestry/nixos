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
        gnomeExtensions.just-perfection
        gnomeExtensions.caffeine
        gnomeExtensions.dotspaces
        gnomeExtensions.bluetooth-quick-connect
        gnomeExtensions.gsconnect                         # kdeconnect enabled in default.nix
        gnomeExtensions.pop-shell
    ];
}