{ pkgs, ... }:

{
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            gcc
            gparted
            spotify
            neofetch
        ];
    };
}