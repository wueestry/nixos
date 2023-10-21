{ pkgs, ... }:

{
  home = { # Specific packages for laptop
    packages = with pkgs;
      [
        # Applications
        gparted
        spotify
      ] ++ (with pkgs.xfce; [ thunar thunar-archive-plugin thunar-volman ]);
  };
}
