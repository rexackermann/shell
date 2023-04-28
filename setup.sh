#!/bin/bash

cd ~/

mv ~/.oh-my-zsh ~/.oh-my-zsh.$(date +%s)

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash  # installs oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/RexAckermann/shell.git
cd ~/shell
mv ~/.zshrc ~/.zshrc.$(date +%s) ; ln -s ~/shell/.zshrc ~/.zshrc
mv ~/.p10k.zsh ~/.p10k.zsh.$(date +%s) ; ln -s ~/shell/.p10k.zsh ~/.p10k.zsh

echo -e "Do you want to get the history and private ? y/n "
read -s -n 1 confirmation

if [[ $confirmation == "y" ]] ; then
     echo -e "On it !"
     export GNUPGHOME=$(pwd)/.gnupg
     gpg -d .zsh_history.gpg >> ~/.zsh_history
     gpg -d .zshrc_private.gpg >> ~/.zshrc_private
else
     exit
fi
