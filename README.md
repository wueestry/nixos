# nixos
This is my current nixos configuration using flakes

## Installation
1. Clone repo `git clone git@github.com:wueestry/nixos.git`. Enter into repo by running `cd nixos`
2. Copy own hardware file into repo `sudo cp /etc/nixos/hardware-configuration.nix ~/nixos/hosts/{desired config}/hardware-configuration.nix`
3. Enable flakes in nixos. By adding the following lines to `/etc/nixos/config.nix`.
```
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
   ```
  Rebuild nixos by running `sudo nixos-rebuild switch`

4. Build flakes by running `sudo nixos-rebuild boot --flake .#{desired config}`
5. Optional: Update nixpkgs by running `nix flake update` and then rebuild system as described in (4.)
