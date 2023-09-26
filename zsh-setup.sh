#!/usr/bin/env bash

# Manual setup for zsh plugins via oh-my-zsh required to work correctly in distrobox
# When using Fedora make zsh default by using `sudo lchsh $USER` and then `/bin/zsh`

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Change theme to powerlevel10k/powerlevel10k"
echo "Add following elements to plugins 'zsh-autosuggestions zsh-syntax-highlighting'"
