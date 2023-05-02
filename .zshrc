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
# alias vi="lvim || nvim || vim || vi"
# alias vim="lvim || nvim || vim || vi"
alias tik="~/.local/kitty.app/bin/kitty +kitten icat"
alias icat="~/.local/kitty.app/bin/kitty +kitten icat"
alias tmpv="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
alias play="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
# alias apt="dnf"
alias gdown="gdown --fuzzy --continue"
alias gdownf="gdown --fuzzy --continue --folder"
alias rename="vidir --verbose"
alias yolo=$HOME/yolo-ai-cmdbot/yolo.py
alias computer=$HOME/yolo-ai-cmdbot/yolo.py
alias music=musikcube
alias incognito="fc -p"

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
     export MANPAGER="sh -c 'col -bx  | bat -l man -p'"
fi

# alias batgrep="batgrep -B 5 -A 5"

if command -v batwatch &> /dev/null
then
     alias watch="batwatch"
fi

if command -v batdiff &> /dev/null
then
     alias diff="batdiff"
fi

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
