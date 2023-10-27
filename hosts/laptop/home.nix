{ pkgs, unstable, ... }:

{
  #imports = [(import ../../modules/desktop/gnome/home.nix)];
  home = { # Specific packages for laptop
    packages = (with pkgs; [
      # Applications
      blender
      brightnessctl
      freetube
      gimp
      slack
      spotify
      xorg.xhost
      zoom-us
    ]) ++ (with unstable; [ logseq ]);
  };
}
