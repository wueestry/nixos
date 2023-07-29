{ pkgs, ... }:

{
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            fuzzel
            gcc
            light
            spotify
            neofetch
        ];
    };
}