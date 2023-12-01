# Hyprland configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ default.nix *
#

{ config, lib, pkgs, host, system, ... }: {
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  xdg.portal =
    { # Required for flatpak with window managers and for file browsing
      enable = true;
      #extraPortals = with pkgs; [
      #xdg-desktop-portal-gtk
      #xdg-desktop-portal-hyprland
      #];
      wlr.enable = true;
      configPackages =
        lib.optionals (!config.services.xserver.desktopManager.gnome.enable)
        [ pkgs.xdg-desktop-portal-gtk ];
    };

  programs.hyprland.enable = true;

  environment.variables = { NIXOS_OZONE_WL = "1"; };

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=yes
  ''; # Required for clamshell mode (see script bindl lid switch and script in home.nix)
}
