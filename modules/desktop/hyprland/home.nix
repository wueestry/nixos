{ config, lib, pkgs, ... }:
let
  display_switcher = pkgs.writeShellScriptBin "display_switcher" ''
    #!/bin/sh

    if [[ $(hyprctl monitors) == *"eDP-1"* ]]; then
      hyprctl keyword monitor "eDP-1, disable"
    else
      hyprctl keyword monitor "eDP-1, prefered, auto, auto"
    fi
  '';
in {
  imports = [ ../../programs/rofi ];

  home.packages = with pkgs; [
    blueman
    display_switcher
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

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    extraConfig = import ./config.nix;
    #waybar = {
    #  enable = true;
    #  package = pkgs.waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  });
    #};
  };

  # nixpkgs.overlays = [    # Waybar with experimental features
  #     (final: prev: {
  #         waybar = hyprland.packages.${system}.waybar-hyprland;
  #     })
  # ];
  home.sessionVariables = {
    # XDG Specifications
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # QT Variables
    DISABLE_QT5_COMPAT = "0";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_STYLE_OVERRIDE = "kvantum";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Toolkit Backend Variables
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };
  systemd.user.services.swaybg = let
    wallpaper = builtins.fetchurl rec {
      name = "wallpaper-${sha256}.png";
      url =
        "https://github.com/Gingeh/wallpapers/blob/2530dba028589bda0ef6743d7960bd8a5b016679/landscapes/yosemite.png?raw=true";
      sha256 = "0m2bi55mlrgg55flmvg5db93cqnz2b25zgbd5b70ymvh35439q14";
    };
  in {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill --image ${wallpaper}";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
