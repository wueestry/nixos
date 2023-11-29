{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';
    history = {
      path = "${config.xdg.dataHome}/.zsh/histfile";
      size = 10000;
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = ./p10k;
      }
    ];
    initExtra = ''
            alias pyvenv="nix-shell $HOME/.setup/scripts/python-shell.nix"
            alias code="code --disable-gpu"
            distro=$(lsb_release -sc)
            if [[ $distro == "focal" ]]; then
              # ROS Noetic config
              source /opt/ros/noetic/setup.zsh
              source ~/dev/catkin_ws/devel/setup.zsh
      	alias rviz="QT_QPA_PLATFORM=xcb rviz"
            elif [[ $distro == "jammy" ]]; then
              # ROS Humble config
              source /opt/ros/humble/setup.zsh
              source ~/dev/ros2_ws/install/setup.zsh
              alias rviz2="QT_QPA_PLATFORM=xcb rviz2"
            fi
    '';
  };
}
