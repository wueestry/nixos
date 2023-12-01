{ pkgs, ... }:
let
  vscode-ros = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-ros";
    publisher = "ms-iot";
    version = "0.9.4";
    sha256 = "sha256-wQgJx5Ey93uvqZva18mqn2pEFjS6lXMjrjR8xSAMwN4=";
  };
  vscode-remote-containers = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "remote-containers";
    publisher = "ms-vscode-remote";
    version = "0.305.0";
    sha256 = "sha256-srSRD/wgDbQo9P1uJk8YtcXPZO62keG5kRnp1TmHqOc=";
  };
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        catppuccin.catppuccin-vsc
        matangover.mypy
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        vscode-icons-team.vscode-icons
        vscodevim.vim
      ] ++ [ vscode-ros vscode-remote-containers ];
    userSettings = {
      "vsicons.dontShowNewVersionMessage" = true;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "vscode-icons";
      "telemetry.telemetryLevel" = "off";
      "editor.fontFamily" = "'MesloLGS NF', 'monospace', monospace";
    };
  };
}
