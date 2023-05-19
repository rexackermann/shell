#!/bin/env bash

init() {
     # Regular Colors=
     
     
     
      FG_R_Black="\e[0;30m"
      FG_R_Red="\e[0;31m"
      FG_R_Green="\e[0;32m"
      FG_R_Yellow="\e[0;33m"
      FG_R_Blue="\e[0;34m"
      FG_R_Purple="\e[0;35m"
      FG_R_Cyan="\e[0;36m"
      FG_R_White="\e[0;37m"
     
     # Bold=
     
     
      FG_B_Black="\e[1;30m"
      FG_B_Red="\e[1;31m"
      FG_B_Green="\e[1;32m"
      FG_B_Yellow="\e[1;33m"
      FG_B_Blue="\e[1;34m"
      FG_B_Purple="\e[1;35m"
      FG_B_Cyan="\e[1;36m"
      FG_B_White="\e[1;37m"
     
     # Underline=
     
     
      FG_U_Black="\e[4;30m"
      FG_U_Red="\e[4;31m"
      FG_U_Green="\e[4;32m"
      FG_U_Yellow="\e[4;33m"
      FG_U_Blue="\e[4;34m"
      FG_U_Purple="\e[4;35m"
      FG_U_Cyan="\e[4;36m"
      FG_U_White="\e[4;37m"
     
     # Background=
     
     
     
      BG_R_Black="\e[40m"
      BG_R_Red="\e[41m"
      BG_R_Green="\e[42m"
      BG_R_Yellow="\e[43m"
      BG_R_Blue="\e[44m"
      BG_R_Purple="\e[45m"
      BG_R_Cyan="\e[46m"
      BG_R_White="\e[47m"
     
     # High Intensty=
     
     
      FG_HI_Black="\e[0;90m"
      FG_HI_Red="\e[0;91m"
      FG_HI_Green="\e[0;92m"
      FG_HI_Yellow="\e[0;93m"
      FG_HI_Blue="\e[0;94m"
      FG_HI_Purple="\e[0;95m"
      FG_HI_Cyan="\e[0;96m"
      FG_HI_White="\e[0;97m"
     
     # Bold High Intensty=
     
     
      FG_BHI_Black="\e[1;90m"
      FG_BHI_Red="\e[1;91m"
      FG_BHI_Green="\e[1;92m"
      FG_BHI_Yellow="\e[1;93m"
      FG_BHI_Blue="\e[1;94m"
      FG_BHI_Purple="\e[1;95m"
      FG_BHI_Cyan="\e[1;96m"
      FG_BHI_White="\e[1;97m"
     
     # High Intensty backgrounds=
     
     
     
      BG_HI_Black="\e[0;100m"
      BG_HI_Red="\e[0;101m"
      BG_HI_Green="\e[0;102m"
      BG_HI_Yellow="\e[0;103m"
      BG_HI_Blue="\e[0;104m"
      BG_HI_Purple="\e[0;105m"
      BG_HI_Cyan="\e[0;106m"
      BG_HI_White="\e[0;107m"
     
     # Reset=
     
     
     
      ClearColor="\e[0m"
     
     
     while getopts hie:l:s:f: option; do
          case $option in
               h)   
                    echo -e ""
                    echo -e "${FG_R_White}${BG_R_Black}This is${ClearColor} ${FG_B_Black}${BG_R_Red}Command${BG_R_Green}Scrach${BG_R_White}Pad${ClearColor} ${FG_B_White}${BG_R_Black}or${ClearColor} ${FG_B_Black}${BG_R_Red}c${BG_R_Green}s${BG_R_White}p${ClearColor}\n"
                    echo -e "${FG_B_Cyan}${BG_R_Black}This script lets you create a script and execute it on the fly.\n"
                    echo -e "${FG_R_Green}-f${ClearColor}  ${FG_R_White}file/script/path${ClearColor}"
                    echo -e "${FG_R_Green}-s${ClearColor}  ${FG_R_White}script_in_your_path${ClearColor}"
                    echo -e "${FG_R_Green}-i${ClearColor}  ${FG_R_White}edit dirrectly \(use with -f or -s\)"
                    # get from history
                    # echo $OPTARG
                    # history=$(sk ~/.zsh_history)
                    # echo $history >> c$t.c.sh ;;
                    echo -e ""
                    ;;
               s)
                    loc=$OPTARG
                    s=true               
                    ;;
               f)
                    loc=$OPTARG
                    f=true
                    ;;
               i)
                    i=true
                    ;;
               e)
                    lvim $(which $OPTARG | head -n 1)
                    exit
                    ;;
               l)
                    hisline=$OPTARG
                    # tail -n ${hisline:-10} ~/.zsh_history
                    ;;
     
          #  n) # Enter a name
          #     Name=$OPTARG;;
          # \?) # Invalid option
          #     echo "Error: Invalid option"
          #     exit;;
          esac
     done
     
     parsed_options=$(
       getopt -n "$0" -o hislRef -- "$@"
     ) || exit
     eval "set -- $parsed_options"
     while [ "$#" -gt 0 ]; do
       case $1 in
         (-[Rsielf]) shift;;
         (-t) shift 2;;
         (--) shift; break;;
         (*) exit 1 # should never be reached.
       esac
     done
     # echo "Now, the arguments are $*"
}

addESC() { sed 's/[][ \~`!@#$%^&*()=+{}|;:'"'"'",<>/?-]/\\&/g'; }

getnamedir () {
     if [[ getnamedirpass == true ]] ; then
          echo working
          echo ""
     else
          t=$(date +%s)
          cdr=$(pwd)
          # pipe=$(cat -)
     fi
}

inject () {
     echo "#!/bin/env bash" > c$t.c.sh &&
     echo $pipe >> c$t.c.sh &&
     echo '' >> c$t.c.sh &&
     tail -n ${hisline:-10} ~/.zsh_history | sed 's/:.*;/# /' >> c$t.c.sh &&
     echo '' >> c$t.c.sh &&
     echo '# Tip: To get a increamental sequence in numbers select with Ctrl-v and g-v-g and then Ctrl-a' >> c$t.c.sh &&
     echo '' >> c$t.c.sh &&
     echo "$comm" >> c$t.c.sh
}

makekscript () {
     ${EDITOR:-vi} +\$ c$t.c.sh &&
     # cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$" &> /dev/null && echo "Nothing to Execute" || rm $cdr/c$t.c.sh && exit
     scripttxt=$(cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$")
     if [[ $scripttxt == "" ]] ; then
          echo "Nothing to Execute" && rm $cdr/c$t.c.sh && exit
     fi
     echo Executuing: &&
     tput setaf 198
     command -v bat >/dev/null && bat -P c$t.c.sh || cat .c.sh &&
     tput setaf 7
     # cat c$t.c.sh | zsh
     chmod +x c$t.c.sh
     mkdir -p ~/c
}

ifpiped () {
     echo "Data was piped to this script!"
     # echo -e "\e[0mIf you are sure Press \e[30m\e[42mEnter\e[0m otherwise Press \e[30m\e[41mCtrl-c\e[0m\"
     echo -e "# Warning : Piping is being used.Therefore, script will execute on save and exit.If you do not want it executing do not save just quit." >> c$t.c.sh &&
     # echo -e "read" >> c$t.c.sh 
     echo -e "" >> c$t.c.sh
     # If we want to read the input line by line
     while IFS= read pipe; do
          echo "${pipe}" >> c$t.c.sh
     done
     # Or if we want to simply grab all the data, we can simply use cat instead
     # cat
}

ask () {
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Green}Execute${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Green}y${ClearColor}"
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Red}Discard${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Red}n${ClearColor} or ${FG_B_Black}${BG_R_Red}d${ClearColor}"
     echo -e "${ClearColor}Or perhaps you want to save the script with a     ${FG_B_Black}${BG_R_Purple}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Purple}r${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to save the script without a    ${FG_B_Black}${BG_R_Yellow}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Yellow}c${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to rework the script, I mean    ${FG_B_Black}${BG_R_Cyan}rework${ClearColor}     ?  Press ${FG_B_Black}${BG_R_Cyan}e${ClearColor}"
     echo -e "${ClearColor}Oh ,and if you end up pressing enter or anything else except Ctrl-c ,it will count like c\n"
     # echo $(echo $(echo $(read) >> /dev/null) >> /dev/null) >> /dev/null 
     read -s -n1 confirmation
     if [[ $confirmation == "y" ]] ; then
          run=true
     elif [[ $confirmation == "n" || $confirmation == "d" ]] ; then
          rm $cdr/c$t.c.sh && echo removed
          exit
     elif [[ $confirmation == "r" ]] ; then
          echo -e "What\'s the new name ? It will be saved in ~/c btw !\n"
          read -r newname
          mv $cdr/c$t.c.sh ~/c/$(echo $newname | addESC) && echo "saved ~/c/$newname"
          exit
     elif [[ $confirmation == "c" ]] ; then
          mv $cdr/c$t.c.sh ~/c && echo "saved ~/c/c$t.c.sh"
          exit
     elif [[ $confirmation == "e" ]] ; then
          getnamedirpass=true
          mainscript $cdr/c$t.c.sh
          exit
     else
          mv $cdr/c$t.c.sh ~/c && echo "saved ~/c/c$t.c.sh"
          exit
     fi
}

executeandsave () {
     ./c$t.c.sh && echo -e "\n\e[30m\e[42mExecuted\e[0m\n"
     scripttxt=$(cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$")
     # echo $scripttxt
     if [[ $scripttxt == "" ]] ; then
          rm $cdr/c$t.c.sh
     else
          echo -e ""
          echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Green}save${ClearColor} it           ?       Press ${FG_B_Black}${BG_R_Green}y${ClearColor}"
          echo -e "${ClearColor}Or perhaps you want to                            ${FG_R_Black}${BG_R_Red}delete${ClearColor} the script ?       Press ${FG_R_Black}${BG_R_Red}d${ClearColor} or ${FG_R_Black}${BG_R_Red}n${ClearColor}"
          echo -e "${ClearColor}Do you want to save it with a                     ${FG_R_Black}${BG_R_Purple}custom name${ClearColor}       ?       Press ${FG_R_Black}${BG_R_Purple}r${ClearColor}"
          echo -e "${ClearColor}Or maybe you want to rework the script, I mean    ${FG_B_Black}${BG_R_Cyan}rework${ClearColor}            ?       Press ${FG_B_Black}${BG_R_Cyan}e${ClearColor}"
          echo -e "${ClearColor}Oh ,and if you end up pressing enter or anything else ,it will count like y"
          read -s -n1 confirmation
          echo -e ""
          if [[ $confirmation == "y" ]] ; then
               mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh"
          elif [[ $confirmation == "n" || $confirmation == "d" ]] ; then
               rm $cdr/c$t.c.sh && echo removed
          elif [[ $confirmation == "r" ]] ; then
               echo -e "What\'s the new name ? It will be saved in ~/c btw !\n"
               read -r newname
               mv $cdr/c$t.c.sh ~/c/$(echo $newname | addESC) && echo "saved ~/c/$newname"
          elif [[ $confirmation == "e" ]] ; then
               getnamedirpass=true
               mainscript $cdr/c$t.c.sh
               exit
          else
               mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh"
          fi

     fi
}

s () {
     if [[ $s == "true" ]] ; then
          if [[ $i == "true" ]] ; then
               cat $(which $loc | head -n 1) >> $cdr/c$t.c.sh
          else
               cp $(which $loc) $cdr/c$t.c.sh
          fi
     fi
}

f () {
     if [[ $f == "true" ]] ; then
          if [[ $i == "true" ]] ; then
               cat $(realpath $loc) >> $cdr/c$t.c.sh
          else
               cp $(realpath $loc) $cdr/c$t.c.sh
          fi
     fi
}

comm=$@

mainscript () {
     init $comm
     getnamedir
     inject
     if [ -p /dev/stdin ]; then
          ifpiped
          makekscript
          executeandsave
     else
          s
          f
          makekscript
          ask
          executeandsave
     fi
}

mainscript

# t=$(date +%s)
# cdr=$(pwd)
# # pipe=$(cat -)

# while getopts ":h:" option; do
#      case $option in
#           h)   # get from history
#                echo hi
#                history=$(sk ~/.zsh_history)
#                echo $history >> c$t.c.sh ;;

#      #  n) # Enter a name
#      #     Name=$OPTARG;;
#      # \?) # Invalid option
#      #     echo "Error: Invalid option"
#      #     exit;;
#      esac
# done

# echo "#!/bin/env bash" > c$t.c.sh &&
# echo $pipe >> c$t.c.sh &&
# echo '' >> c$t.c.sh &&
# tail ~/.zsh_history | sed 's/:.*;/# /' >> c$t.c.sh &&
# echo '' >> c$t.c.sh &&
# echo '# Tip: To get a increamental sequence in numbers select with Ctrl-v and g-v-g and then Ctrl-a' >> c$t.c.sh &&
# echo '' >> c$t.c.sh &&
# echo "$@" >> c$t.c.sh &&

# if [ -p /dev/stdin ]; then
#           echo "Data was piped to this script!"
#           # echo -e "\e[0mIf you are sure Press \e[30m\e[42mEnter\e[0m otherwise Press \e[30m\e[41mCtrl-c\e[0m\"
#           echo -e "# Warning : Piping is being used.Therefore, script will execute on save and exit.If you do not want it executing do not save just quit." >> c$t.c.sh &&
#           # echo -e "read" >> c$t.c.sh 
#           echo -e "" >> c$t.c.sh
#           # If we want to read the input line by line
#           while IFS= read pipe; do
#                echo "${pipe}" >> c$t.c.sh
#           done
#           # Or if we want to simply grab all the data, we can simply use cat instead
#           # cat
#           
#           ${EDITOR:-vi} +\$ c$t.c.sh &&
#           echo Executuing: &&
#           tput setaf 198
#           command -v bat >/dev/null && bat -P c$t.c.sh || cat .c.sh &&
#           tput setaf 7
#           # echo -e "\e[0mIf you are sure Press \e[30m\e[42mEnter\e[0m otherwise Press \e[30m\e[41mCtrl-c\e[0m" &&
#           # echo $(echo $(echo $(read) >> /dev/null) >> /dev/null) >> /dev/null 
#           # cat c$t.c.sh | zsh
#           chmod +x c$t.c.sh
#           ./c$t.c.sh && echo -e "\e[30m\e[42mExecuted\e[0m"
#           mkdir -p ~/c
#           # cat $cdr/c$t.c.sh | grep -v "#\!/bin/env bash" | grep -v "\# Warning \: Piping is being used.Therefore, script will execute on save and exit.If you do not want it executing do not save just quit." | grep -v "^$" &> /dev/null && mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh" || rm $cdr/c$t.c.sh
#           cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$" &> /dev/null && mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh" || rm $cdr/c$t.c.sh

# else
#           # echo "No input was found on stdin, skipping!"
#           # # Checking to ensure a filename was specified and that it exists
#           # if [ -f "$1" ]; then
#           #         echo "Filename specified: ${1}"
#           #         echo "Doing things now.."
#           # else
#           #         echo "No input given!"
#           # fi
#           # echo "hello" >> /dev/null
#           
#           ${EDITOR:-vi} +\$ c$t.c.sh &&
#           echo Executuing: &&
#           tput setaf 198
#           command -v bat >/dev/null && bat -P c$t.c.sh || cat .c.sh &&
#           tput setaf 7
#           # cat c$t.c.sh | zsh
#           chmod +x c$t.c.sh
#           ./c$t.c.sh && echo -e "\e[30m\e[42mExecuted\e[0m"
#           mkdir -p ~/c
#           echo -e "\e[0mIf you are sure Press \e[30m\e[42mEnter\e[0m otherwise Press \e[30m\e[41mCtrl-c\e[0m" &&
#           echo $(echo $(echo $(read) >> /dev/null) >> /dev/null) >> /dev/null 
#           # cat $cdr/c$t.c.sh | grep -v "#\!/bin/env bash" | grep -v "^$" &> /dev/null && mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh" || rm $cdr/c$t.c.sh
#           cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$" &> /dev/null && mv $cdr/c$t.c.sh ~/c && echo "saved ~c/c$t.c.sh" || rm $cdr/c$t.c.sh
# fi


# #comannd
