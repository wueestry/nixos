{ pkgs, ... }:

{
    imports = [(import ../../modules/desktop/gnome/home.nix)];
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            light
            spotify
	    zoom-us
        ];
    };
}
