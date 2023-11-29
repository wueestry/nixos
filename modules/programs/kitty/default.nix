{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS NF";
      package = pkgs.meslo-lgs-nf;
    };
    theme = "Catppuccin-Mocha";
    shellIntegration = {
      mode = "enabled";
      enableZshIntegration = true;
    };
  };
}

