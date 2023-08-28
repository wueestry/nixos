{ pkgs, ... }:

{
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            gparted
            spotify
        ]++ (with pkgs.xfce; [
            thunar
            thunar-volman
            thunar-archive-plugin
        ]);
    };
}