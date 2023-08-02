{pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
            arcticicestudio.nord-visual-studio-code
            bbenoist.nix
            matangover.mypy
            ms-python.python
            ms-python.vscode-pylance
            ms-toolsai.jupyter
            ms-vscode.cmake-tools
            ms-vscode.cpptools
            vscode-icons-team.vscode-icons
            vscodevim.vim
        ];
        userSettings = {
            "vsicons.dontShowNewVersionMessage" = true;
            "workbench.colorTheme" = "Nord";
            "workbench.iconTheme" = "vscode-icons";
            "telemetry.telemetryLevel" = "off";
            "editor.fontFamily" = "'MesloLGS NF', 'monospace', monospace";
        };
    };
}