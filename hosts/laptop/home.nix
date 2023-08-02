{ pkgs, ... }:

{
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            gcc
            light
            spotify
            neofetch
        ];
    };
}