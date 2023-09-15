#
# XFCE configuration
#

{ config, lib, pkgs, ... }:

{
    services.xserver.desktopManager.xfce.enable = true;
    environment.systemPackages = [
    	pkgs.xorg.xinit
	];
}
