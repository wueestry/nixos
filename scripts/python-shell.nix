{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.ipython
    python3Packages.mypy
    python3Packages.black
    python3Packages.isort
    python3Packages.flake8
  ]);
  runScript = "bash";
}).env