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
      spotify
      tesseract4
      xorg.xhost
      zoom-us
    ]) ++ (with unstable; [ logseq ]);
  };
}
