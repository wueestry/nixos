#
#  Hyprland configuration
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

{ config, lib, pkgs, host, system, ... }:
let
    # exec = with host; if hostName == "work" then "exec nvidia-offload Hyprland" else "exec Hyprland"; # Starting Hyprland with nvidia (bit laggy so disabling)
    # exec = "exec dbus-launch Hyprland";
in
{
    environment.systemPackages = with pkgs; [
        blueman
        grim
        pamixer
        slurp
        swappy
        swaybg
        swayidle
        swaylock
        wl-clipboard
        wlogout
        wlr-randr
    ];

    security.pam.services.swaylock = {
        text = ''
        auth include login
        '';
    };

    programs = {
        hyprland = {
            enable = true;
            nvidiaPatches = true;
        };
        waybar = {
            enable = true;
            package = pkgs.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        };
    };

    xdg.portal = {                                  # Required for flatpak with window managers and for file browsing
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # nixpkgs.overlays = [    # Waybar with experimental features
    #     (final: prev: {
    #         waybar = hyprland.packages.${system}.waybar-hyprland;
    #     })
    # ];

    systemd.sleep.extraConfig = ''
        AllowSuspend=yes
        AllowHibernation=no
        AllowSuspendThenHibernate=no
        AllowHybridSleep=yes
    '';                                             # Required for clamshell mode (see script bindl lid switch and script in home.nix)
}
