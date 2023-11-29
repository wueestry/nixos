{ pkgs, unstable, ... }:

{
  #imports = [(import ../../modules/desktop/gnome/home.nix)];
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
    ]) ++ (with unstable; [ logseq ]);
  };
}
