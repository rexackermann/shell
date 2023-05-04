#!/bin/bash

custom_home_dir () {
     homedir=${homedir:-rexshell}
     
     # mkdir ${curdir}/$homedir && echo -e "created ${curdir}/$homedir"
     # echo ${curdir}/$homedir
     
     git clone https://github.com/RexAckermann/shell.git

     mv shell ${curdir}/$homedir
     cd ${curdir}/$homedir

     export HOME=$(pwd)

     curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash  # installs oh-my-zsh
     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
     git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
     git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

     echo -e "Do you want to get the history and private ? y/n "
     read -s -n 1 confirmation
     
     if [[ $confirmation == "y" ]] ; then
          echo -e "On it !"
          export GNUPGHOME=$(pwd)/.gnupg
          # mv ~/.zsh_history ~/.zsh_history.$(date +%s)
          gpg -d .zsh_history.gpg >> $HOME/.zsh_history
          # mv ~/.zshrc_private ~/.zshrc_private.$(date +%s)
          gpg -d .zshrc_private.gpg >> $HOME/.zshrc_private
     else
          exit
     fi
     zsh
}

user_home_dir () {
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
          mv ~/.zsh_history ~/.zsh_history.$(date +%s)
          gpg -d .zsh_history.gpg >> ~/.zsh_history
          mv ~/.zshrc_private ~/.zshrc_private.$(date +%s)
          gpg -d .zshrc_private.gpg >> ~/.zshrc_private
     else
          exit
     fi
}

termuxexec() {
     if [[ uname -a | awk '{print $14}' ]]; then
          echo "/data/data/com.termux/files/usr/bin/sshdhd -p 43434" >> ~/.zshrc
     fi
}

user_home_dir
termuxexec



# curdir=$(pwd)

# echo -e "Press y to create a custom temporary home dirrectory called rexshell here and rice that."
# echo -e "Press n to use custom name"
# echo -e "Press o to use your home dirrectory. Warning: It will move your configs to name.unixtime format"

# read -s -n 1 permission

# if [[ $permission == o ]] ; then
#      echo -e "using user home dirrectory"
#      echo -e "Are you sure ? y/n"
#      read -s -n 1 response
#      if [[ $response == y ]] ; then
#           echo "Going Through"
#      else
#           echo -e "Cancelled"
#           exit
#      fi
#      user_home_dir
# elif [[ $permission == n ]] ; then
#      echo -e "enter new name of the dirrectory"
#      echo -e "Enter Custom Home Dir name"
#      read homedir
#      custom_home_dir
# elif [[ $permission == y ]] ; then
#      echo -e "Using name rexshell for custom homedir"
#      custom_home_dir
# fi

