# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.



# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux new -AD -t main -s main && tmux = "xterm-kitty"
# fi




if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zmodload zsh/zpty
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# POWERLEVEL9K_MODE="nerdfont-complete"

# POWERLEVEL9K_DISABLE_PROMPT=true
# POWERLEVEL9K_PROMT_ON_NEW_LINE=true
#OWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="> "
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" "

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_kali_icon dir vcs)

# POWERLEVEL9K_CUSTOM_FEDORA_ICON="echo "
# POWERLEVEL9K_CUSTOM_FEDORA_ICON_BACKGROUND=069
# POWERLEVEL9K_CUSTOM_FEDORA_ICON_FOREGROUND=015




source $HOME/.zshrc_private




# IBus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus






# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         zsh-autosuggestions
         zsh-syntax-highlighting
         z
         battery
         sudo
         npm
         web-search
         torrent
         #timer
         themes
         # thefuck
         taskwarrior
         systemd
         systemadmin
         )
         

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
load_colors() {
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
}
load_colors

align_center() {
    local terminal_width=$(tput cols)     # query the Terminfo database: number of columns
    local text="${1:?}"                   # text to center
    local glyph="${2:-=}"                 # glyph to compose the border
    local glyph2="${3:-=}"                 # glyph to compose the border
    local padding="${4:-2}"               # spacing around the text

    local text_width=${#text}             
    local glyph_width="${#glyph}"                 # glyph to compose the border
    local glyph2_width="${#glyph2}"                 # glyph to compose the border

    local border_width=$(( ((terminal_width - (padding * 2) - text_width) / 2) / $glyph_width ))

    local border=                         # shape of the border

    # create the border (left side or right side)
    for ((i=0; i<border_width; i++))
    do
        border+="${glyph}"
    done

    # a side of the border may be longer (e.g. the right border)
    if (( ( terminal_width - ( padding * 2 ) - text_width ) % 2 == 0 ))
    then
        # the left and right borders have the same width
        local left_border=$border
        local right_border=$left_border
    else
        # the right border has one more character than the left border
        # the text is aligned leftmost
        local left_border=$border
        local right_border="${border}${glyph}"
    fi

    # space between the text and borders
    local spacing=

    for ((i=0; i<$padding; i++))
    do
        spacing+=" "
    done


    # displays the text in the center of the screen, surrounded by borders.
    for i in {1..$(($terminal_width/$glyph2_width))}; do echo -n "$glyph2"; done
    for i in {1..$(($terminal_width%$glyph2_width))}; do echo -n "${glyph2:0:$(($terminal_width%$glyph2_width))}"; done
    printf "${left_border}${spacing}${text}${spacing}${right_border}"
    for i in {1..$(($terminal_width%$glyph_width))}; do echo -n "${glyph:0:$(($terminal_width%$glyph2_width))}"; done
    for i in {1..$(($terminal_width/$glyph2_width))}; do echo -n "$glyph2"; done
    for i in {1..$(($terminal_width%$glyph2_width))}; do echo -n "${glyph2:0:$(($terminal_width%$glyph2_width))}"; done
}

# center_text "Something I want to print" "~"
# center_text "Something I want to print" "=" 6))" "$padding"




# Example aliases
#alias walfix="dbus-send --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval "string:global.reexec_self()""
#alias minimize="$bash xdotool windowminimize $(xdotool getactivewindow)"
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias tvp="mplayer -vo fbdev2 -fs -zoom -xy"
# alias sndcpy="/home/rex/./sndcpy"
# alias ls="exa -a --icons || ls -a"
# alias l="exa -alihgSUFHum --icons || ls -alihgSUFHu --color"
# alias lst="exa --tree || ls --tree"
alias beelogger="sudo python /home/rex/BeeLogger/bee.py"
alias bh="sync && sudo sysctl -w vm.drop_caches=3 && sudo sysctl -w vm.drop_caches=2"
# alias ftp-start="sudo systemctl start vsftpd.service"
# alias ftp-stop="sudo systemctl stop vsftpd.service"
alias fullscreen="wmctrl -r ':ACTIVE:' -b add,fullscreen"
alias unfullscreen="wmctrl -r ':ACTIVE:' -b add,fullscreen"
alias sublime="/opt/sublime_text/sublime_text"
alias glances="glances -C $HOME/Documents/glances.conf"
alias vm.drop="sudo sysctl -w vm.drop_caches=3 && sudo sysctl -w vm.drop_caches=2 && sudo sysctl -w vm.drop_caches=1"
# alias srhs="cat /home/rex/.zsh_history | grep"
alias iris="xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -debug -- mpv -wid WID --loop --no-audio ~/Videos/video.mp4 /home/rex/Videos/iris.mp4 &; disown"
alias irisk="pkill -f "xwinwrap""
alias pk="pkill -9 -e"
# alias sshd="/etc/init.d/ssh start"
alias wallpaper="tiv /home/rex/.config/autowallp/wall-dark0 && tiv /home/rex/.config/autowallp/wall-dark1 && tiv /home/rex/.config/autowallp/wall-dark2 && tiv /home/rex/.config/autowallp/wall-dark3 && tiv /home/rex/.config/autowallp/wall-dark4"
# alias pyhttp="/home/rex/py_httpserver_Ult/local_server.py"
alias m="mpv --demuxer-max-bytes=50M"
alias define="sdcv"
alias fetch="cpufetch -Fs fancy -c intel && neofetch"
# alias amn="sshfs -o password_stdin u0_a310@192.168.2.$1:/storage/emulated/0 ~/AnDroid -p 43434 <<< "yusarintin""alias cleaner="sudo bleachbit"
alias magick="magick -limit memory 2GiB "
alias mvi='mpv --config-dir=$HOME/.config/mvi'
alias mpvu="mpv --ytdl-raw-options=geo-bypass-country=UK"
alias emacs="emacsclient -ca "emacs""
alias em="emacs"
alias pipupgrade="pip-review --local --auto"
# alias vi="lvim || nvim || vim || vi"
# alias vim="lvim || nvim || vim || vi"
alias tik="~/.local/kitty.app/bin/kitty +kitten icat"
alias icat="~/.local/kitty.app/bin/kitty +kitten icat"
# alias tmpv="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
# alias play="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
# alias apt="dnf"
alias gdown="gdown --fuzzy --continue"
alias gdownf="gdown --fuzzy --continue --folder"
alias rename="vidir --verbose"
alias yolo=$HOME/yolo-ai-cmdbot/yolo.py
alias computer=$HOME/yolo-ai-cmdbot/yolo.py
alias music=musikcube

incognito() {
     if [[ $1 == "off" || $1 == "disable" || $1 == "--off" || $1 == "--disable" || $1 == "d" || $1 == "-d" ]] ; then
          fc -P && incognito=false
          clear &&
          rm -rfv /tmp/.zsh_history.tmp && echo "Temporary history removed" &&
          echo -e "${FG_R_Black}${BG_R_Red}" &&
          align_center "Incognito Mode Disabled" "󱐡 " "󰗹 " &&
          echo -e "${ClearColor}\n"
     else
          /bin/cp ~/.zsh_history /tmp/.zsh_history.tmp &&
          fc -p /tmp/.zsh_history.tmp && incognito=true
          clear &&
          echo -e "${FG_R_Black}${BG_R_Green}" &&
          align_center "Incognito Mode Enabled" "󱐡 " "󰗹 " &&
          echo -e "${ClearColor}\n"
     fi
}





if command -v lvim &> /dev/null
then
     alias vi="lvim"
elif command -v nvim &> /dev/null
then
     alias vi="nvim"
elif command -v vim &> /dev/null
then
     alias vi="vim"
else
     alias vi="vi"
fi 

if command -v lvim &> /dev/null
then
     alias vim="lvim"
elif command -v nvim &> /dev/null
then
     alias vim="nvim"
elif command -v vim &> /dev/null
then
     alias vim="vim"
else
     alias vim="vi"
fi 


# vi() {
#      lvim $@ || nvim $@ || vim $@ || vi $@
# }
# vim() {
#      lvim $@ || nvim $@ || vim $@ || vi $@
# }

# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

unsetopt nomatch

#neofetch

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# exa settings
# source $(dirname $(gem which exa))/tab_complete.sh
alias lc='exa'
#source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zstyle ':autocomplete:*' min-input 2  # int
# Wait until this many characters have been typed, before showing completions.
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' default-context ''
zstyle ':autocomplete:*' widget-style complete-word


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#eval $(thefuck --alias)

autoload bashcompinit
bashcompinit
# source /usr/share/bash-completion/completions/nala

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

#python pakages
export PATH="$HOME/.local/bin:$PATH"

#doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"

export PATH="$HOME/shell//bin:$PATH"


# Flatpak
f() {
     flatpak list | grep -i $1 | awk '{ print $2 }' | xargs flatpak run
}

# man() {
#      batma $@ || sh -c 'col -bx  | bat -l man -p' || man $@
# }

if command -v bat &> /dev/null
then
     # export MANPAGER="sh -c 'col -bx  | bat -l man -p'"
     # export MANPAGER="batman"
     alias man="batman"
fi

# alias batgrep="batgrep -B 5 -A 5"

if command -v bat &> /dev/null
then
     alias watch="batwatch"
fi

if command -v rsync &> /dev/null
then
     # alias cp="rsync -avxHAXP --progress"
     # alias mv="rsync -avxHAXP --remove-source-files --progress"
     cp() {
          rsync -avxAHXhP $@ || echo -e "${FG_R_Black}${BG_R_Red}\n-XA skippin'\n${ClearColor}" && rsync -avxHP $@
     }
     mv() {
          rsync -avxAHXhP --remove-source-files $@ || echo -e "${FG_R_Black}${BG_R_Red}\n-XA skippin'\n${ClearColor}" && rsync -avxHP --remove-source-files $@
     }
fi
compdef cp=rsync
compdef mv=rsync


CON() {
     xset -q | grep "Caps Lock:   off" && xdotool key Caps_Lock
}
con() {
     xset -q | grep "Caps Lock:   off" && xdotool key Caps_Lock
}
COFF() {
     xset -q | grep "Caps Lock:   on" && xdotool key Caps_Lock
}
coff() {
     xset -q | grep "Caps Lock:   on" && xdotool key Caps_Lock
}

# cp() {
# if [ ! -d "$2" ]; then
#      mkdir -p "$2"
# fi
# rsync -avxHAXP --progress "$1" "$2"
# }

# mv() {
# if [ ! -d "$2" ]; then
#      mkdir -p "$2"
# fi
# rsync -avxHAXP --progress --remove-source-files "$1" "$2"
# }

if command -v bat &> /dev/null
then
     alias diff="batdiff"
fi
color256() {
     awk -v cols="$(tput cols)" 'BEGIN{
         for (colnum = 0; colnum<cols; colnum++) {
             r = 255-(colnum*255/cols);
             g = (colnum*510/cols);
             b = (colnum*255/cols);
             if (g>255) g = 510-g;
             printf "\033[48;2;%d;%d;%dm", r,g,b;
             printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
     	char=(colnum%2==0)?"/":"\\";
             printf "%s\033[0m", char;
         }
         printf "\n";
     }'
}

# watch() {
#      batwatch $@ || watch $@
# }

# diff() {
#      batdiff $@ || diff $@
# }

# batpipe
# To use batpipe, eval the output of this command in your shell init script.
LESSOPEN="|/usr/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;

# The following will enable colors when using batpipe with less:
LESS="$LESS -R";
BATPIPE="color";
export LESS;
export BATPIPE;

# Songs Play
# p() {
#      # song=${1:-\ }   
#      cd ~/songs
#      song={$(sk --preview="ffthumb {}"):=*}
#      mpv ~/songs/${song:2:-4}*
#      cd
#      
#      # /bin/ls -db ~/songs/* | fzf -q ${song:2:-4}| xargs mpv
#      # cd
# }
# p() {
#      /bin/ls -db ~/songs/* | grep -i $1 | xargs mpv
# }










# yolo() {
#      cd ~/yolo-ai-cmdbot
#      alias yolo=$(pwd)/yolo.py
#      alias computer=$(pwd)/yolo.py
#      yolo $1
#      cd
# }


# fp auto-completion
() {
  # A list of each flatpak app name in lowercase.
  # (First word of the name to be exact, so "Brave Browser" will be "brave").
  local FLATPAK_APPS=$(flatpak list --app | cut -f1 | awk '{print tolower($1)}')
  complete -W $FLATPAK_APPS fp
}

# Run Flatpak apps from CLI, e.g.: "fp okular"
function fp() {
  app=$(flatpak list --app | cut -f2 | awk -v app="$1" '(tolower($NF) ~ tolower(app))')

  # Abort if the app name was not entered
  test -z $1 && printf "Enter an app to fp.\n\$ fp <app>\n\nINSTALLED APPS\n$app\n" && return;

  # Remove app name from "$@" array
  shift 1;

  # Run the flatpak app asynchronous and don't show any stdout and stderr
  ( flatpak run "$app" "$@" &> /dev/null & )
}














# sudofox/shell-mommy.sh
# There's a function in .p10k.zsh

mommy() (

  # SHELL_MOMMYS_LITTLE - what to call you~ (default: "girl")
  # SHELL_MOMMYS_PRONOUNS - what pronouns mommy will use for themself~ (default: "her")
  # SHELL_MOMMYS_ROLES - what role mommy will have~ (default "mommy")

  COLORS_LIGHT_PINK='\e[38;5;217m'
  COLORS_LIGHT_BLUE='\e[38;5;117m'
  COLORS_FAINT='\e[2m'
  COLORS_RESET='\e[0m'

  DEF_WORDS_LITTLE="girl"
  DEF_WORDS_PRONOUNS="her"
  DEF_WORDS_ROLES="mommy"
  DEF_MOMMY_COLOR="${COLORS_LIGHT_PINK}"
  DEF_ONLY_NEGATIVE="false"

  NEGATIVE_RESPONSES="do you need MOMMYS_ROLE's help~? ❤️
Don't give up, my love~ ❤️
Don't worry, MOMMYS_ROLE is here to help you~ ❤️
I believe in you, my sweet AFFECTIONATE_TERM~ ❤️
It's okay to make mistakes, my dear~ ❤️
just a little further, sweetie~ ❤️
Let's try again together, okay~? ❤️
MOMMYS_ROLE believes in you, and knows you can overcome this~ ❤️
MOMMYS_ROLE believes in you~ ❤️
MOMMYS_ROLE is always here for you, no matter what~ ❤️
MOMMYS_ROLE is here to help you through it~ ❤️
MOMMYS_ROLE is proud of you for trying, no matter what the outcome~ ❤️
MOMMYS_ROLE knows it's tough, but you can do it~ ❤️
MOMMYS_ROLE knows MOMMYS_PRONOUN little AFFECTIONATE_TERM can do better~ ❤️
MOMMYS_ROLE knows you can do it, even if it's tough~ ❤️
MOMMYS_ROLE knows you're feeling down, but you'll get through it~ ❤️
MOMMYS_ROLE knows you're trying your best~ ❤️
MOMMYS_ROLE loves you, and is here to support you~ ❤️
MOMMYS_ROLE still loves you no matter what~ ❤️
You're doing your best, and that's all that matters to MOMMYS_ROLE~ ❤️
MOMMYS_ROLE is always here to encourage you~ ❤️"


  POSITIVE_RESPONSES="*pets your head*
awe, what a good AFFECTIONATE_TERM~\nMOMMYS_ROLE knew you could do it~ ❤️
good AFFECTIONATE_TERM~\nMOMMYS_ROLE's so proud of you~ ❤️
Keep up the good work, my love~ ❤️
MOMMYS_ROLE is proud of the progress you've made~ ❤️
MOMMYS_ROLE is so grateful to have you as MOMMYS_PRONOUN little AFFECTIONATE_TERM~ ❤️
I'm so proud of you, my love~ ❤️
MOMMYS_ROLE is so proud of you~ ❤️
MOMMYS_ROLE loves seeing MOMMYS_PRONOUN little AFFECTIONATE_TERM succeed~ ❤️
MOMMYS_ROLE thinks MOMMYS_PRONOUN little AFFECTIONATE_TERM earned a big hug~ ❤️
that's a good AFFECTIONATE_TERM~ ❤️
you did an amazing job, my dear~ ❤️
you're such a smart cookie~ ❤️"

# export SHELL_MOMMYS_POSITIVE_RESPONSES=(
#     "Your effort to improve your privacy and security is a step towards a better world."
#     "By taking control of your technology, you are empowering yourself and those around you."
#     "Keep up the good work! You are contributing to a world where privacy and security are the norm."
#     "You are making a positive difference in the world by prioritizing your privacy and security."
#     "Remember, every action you take towards protecting your privacy and security is a meaningful one."
#     "Your dedication to protecting your privacy and security is admirable and will pay off in the long run."
#     "Your commitment to privacy and security is a valuable contribution to society and will inspire others."
#     "Well done! You are setting an example for others by taking control of your technology."
#     "You are on the right track towards a more secure and private digital life."
#     "Keep going! Your efforts to improve your privacy and security are making a difference."
# )
# export SHELL_MOMMYS_NEGATIVE_RESPONSES=(
#     "Don't give up! The fight for privacy and security is more important than ever."
#     "Remember, setbacks are temporary. Keep pushing forward in your efforts to protect your privacy and security."
#     "Stay strong! Every challenge you face in protecting your privacy and security is an opportunity for growth."
#     "Keep your head up! The pursuit of privacy and security is a constant struggle, but it's worth it."
#     "Take a deep breath and remember why you're working so hard to protect your privacy and security."
#     "Don't be discouraged. Your efforts towards privacy and security are important, even in the face of obstacles."
#     "Remember that every failure is a learning opportunity. Use it to your advantage in your quest for privacy and security."
#     "Stay focused on your goal of protecting your privacy and security, even when faced with difficulties."
#     "Don't give up hope! Your efforts towards privacy and security are making a positive difference in the world."
#     "You are not alone in your fight for privacy and security. Keep going, and know that others are with you."
# )
# export SHELL_MOMMYS_NEGATIVE_RESPONSES=(
# 	"You call that effort? This is some weak-ass shit."
# 	"You ain't gonna make it with that attitude, son."
# 	"What the hell is wrong with you?"
# 	"You ain't got the skills to back that attitude up."
# 	"You better step up your game, before I step up mine."
# 	"I ain't got time for this amateur hour bullshit."
# 	"You ain't gonna make it in this world with that attitude."
# 	"You better wise up, before you get left behind."
# 	"I ain't impressed with that effort, son."
# 	"You ain't got what it takes to succeed."
# 	"You better bring your A-game, or get out of the game."
# 	"You better shape up, before I ship out."
# 	"I ain't gonna sugarcoat it - that was weak as hell."
# 	"You ain't got what it takes to make it in this world."
# 	"I ain't gonna hold your hand - you better step up."
# 	"You better bring your best effort, or don't even bother showing up."
# 	"I ain't gonna waste my time on half-ass efforts."
# 	"You ain't gonna make it with that attitude, son."
# 	"You better come correct, or don't come at all."
# )
# export SHELL_MOMMYS_POSITIVE_RESPONSES=(
# 	"You did it! Now that's what I'm talkin' about!"
# 	"I knew you had it in you, son."
# 	"You brought your A-game and it shows."
# 	"Now that's the effort I like to see."
# 	"You're killin' it, son."
# 	"I ain't gonna lie, you impressed the hell out of me."
# 	"You're on fire, son!"
# 	"You bringin' your best effort, and it shows."
# 	"You ain't playin' around, are you?"
# 	"I can see you're gonna make it in this world."
# 	"You're bringin' the heat, son."
# 	"You're killin' it out there."
# 	"I ain't seen effort like that in a long time."
# 	"You're bringin' your A-game, and it shows."
# 	"You ain't afraid to bring your best, and I respect that."
# 	"You're killin' it, son."
# 	"I can see you're gonna make it in this world."
# 	"You're bringin' the heat, son."
# )

  # allow for overriding of default words (IF ANY SET)

  if [ -n "$SHELL_MOMMYS_LITTLE" ]; then
    DEF_WORDS_LITTLE="${SHELL_MOMMYS_LITTLE}"
  fi
  if [ -n "$SHELL_MOMMYS_PRONOUNS" ]; then
    DEF_WORDS_PRONOUNS="${SHELL_MOMMYS_PRONOUNS}"
  fi
  if [ -n "$SHELL_MOMMYS_ROLES" ]; then
    DEF_WORDS_ROLES="${SHELL_MOMMYS_ROLES}"
  fi
  if [ -n "$SHELL_MOMMYS_COLOR" ]; then
    DEF_MOMMY_COLOR="${SHELL_MOMMYS_COLOR}"
  fi
  # allow overriding to true
  if [ "$SHELL_MOMMYS_ONLY_NEGATIVE" = "true" ]; then
    DEF_ONLY_NEGATIVE="true"
  fi
  # if the variable is set for positive/negative responses, overwrite it
  if [ -n "$SHELL_MOMMYS_POSITIVE_RESPONSES" ]; then
    POSITIVE_RESPONSES="$SHELL_MOMMYS_POSITIVE_RESPONSES"
  fi
  if [ -n "$SHELL_MOMMYS_NEGATIVE_RESPONSES" ]; then
    NEGATIVE_RESPONSES="$SHELL_MOMMYS_NEGATIVE_RESPONSES"
  fi

  # split a string on forward slashes and return a random element
  pick_word() {
    echo "$1" | tr '/' '\n' | shuf | sed 1q
  }

  pick_response() { # given a response type, pick an entry from the list

    if [ "$1" = "positive" ]; then
      element=$(echo "$POSITIVE_RESPONSES" | shuf | sed 1q)
    elif [ "$1" = "negative" ]; then
      element=$(echo "$NEGATIVE_RESPONSES" | shuf | sed 1q)
    else
      echo "Invalid response type: $1"
      exit 1
    fi

    # Return the selected response
    echo "$element"

  }

  sub_terms() { # given a response, sub in the appropriate terms
    response="$1"
    # pick_word for each term
    affectionate_term="$(pick_word "${DEF_WORDS_LITTLE}")"
    pronoun="$(pick_word "${DEF_WORDS_PRONOUNS}")"
    role="$(pick_word "${DEF_WORDS_ROLES}")"
    # sub in the terms, store in variable
    response="$(echo "$response" | sed "s/AFFECTIONATE_TERM/$affectionate_term/g")"
    response="$(echo "$response" | sed "s/MOMMYS_PRONOUN/$pronoun/g")"
    response="$(echo "$response" | sed "s/MOMMYS_ROLE/$role/g")"
    # we have string literal newlines in the response, so we need to printf it out
    # print faint and colorcode
    printf "${DEF_MOMMY_COLOR}$response${COLORS_RESET}\n"
  }

  success() {
    (
      # if we're only supposed to show negative responses, return
      if [ "$DEF_ONLY_NEGATIVE" = "true" ]; then
        return 0
      fi
      # pick_response for the response type
      response="$(pick_response "positive")"
      sub_terms "$response" >&2
    )
    return 0
  }
  failure() {
    rc=$?
    (
      response="$(pick_response "negative")"
      sub_terms "$response" >&2
    )
    return $rc
  }
  # eval is used here to allow for alias resolution

  # TODO: add a way to check if we're running from PROMPT_COMMAND to use the previous exit code instead of doing things this way
  eval "$@" && success || failure
  return $?
)
# precmd() { if (( $? != 0 )); then; mommy false; else; mommy true; fi }

# SHELL_MOMMYS_LITTLE: Sets the affectionate term that mommy will use to refer to the user. The default value is "girl".
# SHELL_MOMMYS_PRONOUNS: Sets the pronouns that mommy will use to refer to itself. The default value is "her".
# SHELL_MOMMYS_ROLES: Sets the role that mommy will have. The default value is "mommy".
# SHELL_MOMMYS_COLOR: Sets the color of the text output by mommy. The default value is a light pink color.
# SHELL_MOMMYS_ONLY_NEGATIVE: If set to true, mommy will provide encouragement (on non-zero exit status) but not praise. This will keep clutter down if you intend to use mommy as a PROMPT_COMMAND.
# SHELL_MOMMYS_NEGATIVE_RESPONSES/SHELL_MOMMYS_POSITIVE_RESPONSES: Sets the possible responses that mommy will use. This should be in the form of a bash array and will override the default responses. Want Samuel L. Jackson to chastise or compliment you? Now you can!

SHELL_MOMMYS_LITTLE="kid"
SHELL_MOMMYS_PRONOUNS="her"
SHELL_MOMMYS_ROLES="mommy"
SHELL_MOMMYS_COLOR=""
SHELL_MOMMYS_ONLY_NEGATIVE="false"
# SHELL_MOMMYS_NEGATIVE_RESPONSES/SHELL_MOMMYS_POSITIVE_RESPONSES=""




unalias ls
unalias l

# command replacer

# if command -v newcommand &> /dev/null
# then
#      alias command="newcommand"
# else
#      alias command="command"
# fi 

if command -v exa &> /dev/null
then
     alias ls="exa -a --icons"
     alias l="exa -alihgSUFHum --icons"
     alias lst="exa --tree"
else
     alias ls="ls -a"
     alias l="ls -alihgSUFHu --color"
     alias lst="ls"
fi 


srhs() {
     rg $@ ~/.zsh_history || cat ~/.zsh_history | grep $@
}

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}
[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"




# [[ $(($_) | grep "no such file or dirrectory") != "" ]] && mpv !!





# git auto launch ssh-agent

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



eval "$(register-python-argcomplete pipx)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"










#compdef _glow glow

# zsh completion for glow                                 -*- shell-script -*-

__glow_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_glow()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions

    __glow_debug "\n========= starting completion logic =========="
    __glow_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __glow_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __glow_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., glow -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __glow_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __glow_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __glow_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __glow_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __glow_debug "No directive found.  Setting do default"
        directive=0
    fi

    __glow_debug "directive: ${directive}"
    __glow_debug "completions: ${out}"
    __glow_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __glow_debug "Completion received error. Ignoring completions."
        return
    fi

    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            __glow_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __glow_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __glow_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __glow_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __glow_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __glow_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __glow_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __glow_debug "_describe did not find completions."
            __glow_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __glow_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __glow_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_glow" ]; then
    _glow
fi

source "$HOME/.cargo/env"
export EDITOR=$HOME/.local/bin/lvim
addESC() { sed 's/[][ \~`!@#$%^&*()=+{}|;:'"'"'",<>/?-]/\\&/g'; }
[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"

termuxexec() {
     if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then

          unalias man
          if command -v bat &> /dev/null
          then
               export MANPAGER="most"
          fi

          sshd -p 43434

          # echo -e "termux detected"
          # echo "/data/data/com.termux/files/usr/bin/sshdhd -p 43434" >> ~/.zshrc
          # sed 's/my_cpu_temp/\#\ my_cpu_temp/' ~/shell/.p10k.zsh > ~/shell/.p10k.zsh
          # # echo "sed 's/my_cpu_temp/\#\ my_cpu_temp/' .p10k.zsh > .p10k.zsh"
     # else
     #      amn > /dev/null 2>&1
     fi
}
termuxexec
