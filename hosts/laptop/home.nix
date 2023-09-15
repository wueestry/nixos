{ pkgs, ... }:

{
    imports = [(import ../../modules/desktop/kde/home.nix)];
    home = {                       # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            appimage-run
            lshw
            slack
            spotify
        ];
    };
}
