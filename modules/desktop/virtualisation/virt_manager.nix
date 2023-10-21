# Virt-Manager
#

{ config, pkgs, user, ... }:

{
  virtualisation = { libvirtd.enable = true; };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ virt-manager ];
}
