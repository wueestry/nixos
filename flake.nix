# flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   └─ ./nix
#       └─ default.nix
#

{
  description = "My Personal NixOS Configuration";

  inputs = # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url =
        "github:nixos/nixpkgs/nixos-23.05"; # Default Stable Nix Packages
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = { # User Package Management
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      #hyprland = {                                                          # Official Hyprland flake
      #    url = "github:vaxerski/Hyprland";                                   # Add "hyprland.nixosModules.default" to the host modules
      #    inputs.nixpkgs.follows = "nixpkgs";
      #};

      plasma-manager = { # KDE Plasma user settings
        url =
          "github:pjones/plasma-manager"; # Add "inputs.plasma-manager.homeManagerModules.plasma-manager" to the home-manager.users.${user}.imports
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager
    , plasma-manager, ...
    }: # Function that tells my flake which to use and what do what to do with the dependencies.
    let # Variables that can be used in the config files.
      user = "ryan";
      location = "$HOME/.setup";
      # Use above variables in ...
    in {
      nixosConfigurations = ( # NixOS configurations
        import ./hosts { # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager user location
            plasma-manager; # Also inherit home-manager so it does not need to be defined here.
        });

      homeConfigurations = ( # Non-NixOS configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        });
    };
}
