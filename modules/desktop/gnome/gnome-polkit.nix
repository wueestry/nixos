{ config, lib, pkgs, ... }:

{
  programs = { seahorse.enable = true; };

  security.pam.services.gdm.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;

  environment = {
    systemPackages = with pkgs;
      [ # Packages installed
        polkit_gnome
      ];
  };
}
