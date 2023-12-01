{ pkgs, unstable, ... }:

{
  imports = [ (import ../../modules/desktop/hyprland/home.nix) ];
  home = { # Specific packages for laptop
    packages = (with pkgs; [
      # Applications
      blender
      brightnessctl
      gimp
      slack
      xorg.xhost
      zoom-us
      kooha
      ncspot
      wdisplays
      todo
      octaveFull
      steam
    ]); # ++ (with unstable; [ logseq ]);
  };
}
