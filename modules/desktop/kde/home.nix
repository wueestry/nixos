#
# KDE Home-Manager Configuration
#
# Get the plasma configs in a file with $ nix run github:pjones/plasma-manager > <file>
#

{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.plasma = {
    enable = true;
  };
}