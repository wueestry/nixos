#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y
sudo apt install kitty-terminfo -y
sudo apt install git neovim -y

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

sudo apt install curl -y # if you haven't already installed curl


if [[ $1 == "noetic" ]]; then
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    sudo apt update

    sudo apt install ros-noetic-desktop-full -y
    sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential python3-catkin-tools -y

    sudo rosdep init
    rosdep update

elif [[ $1 == "humble" ]]; then
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

    sudo apt update

    sudo apt install ros-humble-desktop -y
    sudo apt install ros-dev-tools -y
elif [[ $1 == "zsh" ]]; then
    echo "Add the following lines to the .zshrc"
    echo '''
        distro=$(lsb_release -sc)
        if [[ $distro == "focal" ]]; then
            # ROS Noetic config
            source /opt/ros/noetic/setup.zsh
            source ~/catkin_ws/devel/setup.zsh
        elif [[ $distro == "jammy" ]]; then
            # ROS Humble config
            source /opt/ros/humble/setup.zsh
        fi
    '''



else
    echo "Select a correct version"

fi