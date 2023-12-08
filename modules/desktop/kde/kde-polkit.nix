{ config, lib, pkgs, ... }:

{
  security.pam.services.gdm.enableKwallet = true;

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  environment = {
    systemPackages = with pkgs;
      [ # Packages installed
        libsForQt5.polkit-kde-agent
      ];
  };
}
