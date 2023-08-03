{ pkgs, ... }:

{
    home = {                                # Specific packages for laptop
        packages = with pkgs; [
            # Applications
            light
            spotify
        ];
    };
}