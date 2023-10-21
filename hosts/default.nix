# These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       ├─ home.nix
#       └─ ./desktop OR ./laptop
#            ├─ ./default.nix
#            └─ ./home.nix 
#

{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user, location
, plasma-manager, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  desktop = lib.nixosSystem { # Desktop profile
    inherit system;
    specialArgs = {
      inherit inputs unstable system user location;
      host = { hostName = "ryan-desktop"; };
    }; # Pass flake variable
    modules = [ # Modules that are used.
      # hyprland.nixosModules.default
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager
      { # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user unstable;
          host = { hostName = "ryan-desktop"; };
        }; # Pass flake variable
        home-manager.users.${user} = {
          imports = [ ./home.nix ./desktop/home.nix ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem { # Laptop profile
    inherit system;
    specialArgs = {
      inherit inputs unstable user location;
      host = {
        hostName = "ryan-yoga";
        mainMonitor = "eDP-1";
      };
    };
    modules = [
      # hyprland.nixosModules.default
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user unstable;
          host = {
            hostName = "ryan-yoga";
            mainMonitor = "eDP-1";
          };
        };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ] ++ [ (import ./laptop/home.nix) ];
        };
      }
    ];
  };
}
