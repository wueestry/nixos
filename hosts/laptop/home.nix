{ pkgs, ... }:

{
    imports = [(import ../../modules/desktop/gnome/home.nix)];
    home = {                       # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            slack
            spotify
            blender
            gimp
            logseq
	        freetube
        ];
    };
}
