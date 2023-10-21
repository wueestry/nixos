# Gnome Home-Manager Configuration
#
# Dconf settings can be found by running "$ dconf watch /"
#

{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    bluetooth-quick-connect
    blur-my-shell
    caffeine
    dotspaces
    gsconnect # kdeconnect enabled in default.nix
    just-perfection
    pop-shell
  ];
}
