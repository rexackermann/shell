#!/usr/bin/env zsh
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NVM_DIR="$XDG_DATA_HOME"/nvm
export ZSH="$XDG_DATA_HOME"/oh-my-zsh
export PYTHONSTARTUP="/etc/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export WINEPREFIX="$XDG_DATA_HOME"/wine
export _Z_DATA="$XDG_DATA_HOME/z"
export SSB_HOME="$XDG_DATA_HOME"/zoom
[ -f "$XDG_CONFIG_HOME"/zsh/history ] && export HISTFILE="$XDG_STATE_HOME"/zsh/history || export HISTFILE="$HOME"/.zsh_history
export ZDOTDIR="$HOME"/.config/zsh
export LIBVA_DRIVER_NAME=iHD
export PATH=/home/rex/.nimble/bin:$PATH
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
zmodload zsh/zpty
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zstyle ':autocomplete:*' min-input 2  
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' default-context ''
zstyle ':autocomplete:*' widget-style complete-word
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
         taskwarrior
         systemd
         systemadmin
         zsh-lazyload
         )
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"
#OWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="> "
#!/usr/bin/env zsh
#
#
#
 function prompt_greeting() {
    p10k segment -b 99 -f 0 -i '' -t '🥷 Did you need anything, honey ?'
 }
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'
() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  autoload -Uz is-at-least && is-at-least 5.1 || return
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    shell_mommy
    os_icon               
    example               
    newline               
    dir                   
    incognito_flag
    vcs                   
    newline               
    greeting
    newline
    prompt_char           
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    ip                      
    public_ip               
    newline
    background_jobs         
    direnv                  
    asdf                    
    virtualenv              
    anaconda                
    pyenv                   
    goenv                   
    nodenv                  
    nvm                     
    nodeenv                 
    package                 
    rbenv                   
    rvm                     
    fvm                     
    luaenv                  
    jenv                    
    plenv                   
    phpenv                  
    scalaenv                
    haskell_stack           
    kubecontext             
    terraform               
    aws                     
    aws_eb_env              
    azure                   
    gcloud                  
    google_app_cred         
    context                 
    nordvpn                 
    ranger                  
    nnn                     
    xplr                    
    vim_shell               
    midnight_commander      
    nix_shell               
    vi_mode                 
    vpn_ip                
    load                    
    ram                     
    todo                    
    timewarrior             
    taskwarrior             
    my_cpu_temp             
    battery                 
    newline
    status                  
    command_execution_time  
    time                  
  )
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%244F╭─'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%244F├─'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%244F╰─'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%244F─╮'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%244F─┤'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%244F─╯'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='─'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
  if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=244
    typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
    typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
  fi
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B5'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B7'
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='░▒▓'
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='▓▒░'
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  #################################[ os_icon: os identifier ]##################################
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=green
  ################################[ prompt_char: prompt symbol ]################################
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=
  ##################################[ dir: current directory ]##################################
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=4
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  local anchor_files=(
    .bzr
    .citc
    .git
    .hg
    .node-version
    .python-version
    .go-version
    .ruby-version
    .lua-version
    .java-version
    .perl-version
    .php-version
    .tool-version
    .shorten_folder_marker
    .svn
    .terraform
    CVS
    Cargo.toml
    composer.json
    go.mod
    package.json
    stack.yaml
  )
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  #
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #####################################[ vcs: git status ]######################################
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  #
  #
  #
  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi
    local       meta='%7F' 
    local      clean='%0F' 
    local   modified='%0F' 
    local  untracked='%0F' 
    local conflicted='%1F' 
    local res
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
      (( $#branch > 32 )) && branch[13,-13]="…"  
      res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
    fi
    if [[ -n $VCS_STATUS_TAG
          && -z $VCS_STATUS_LOCAL_BRANCH  
        ]]; then
      local tag=${(V)VCS_STATUS_TAG}
      (( $#tag > 32 )) && tag[13,-13]="…"  
      res+="${meta}#${clean}${tag//\%/%%}"
    fi
    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&  
      res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
      res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
    fi
    if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
      res+=" ${modified}wip"
    fi
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"
    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null
  #
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  typeset -g POWERLEVEL9K_VCS_PREFIX='on '
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  ##########################[ status: exit code of the last command ]###########################
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=true
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
  typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=1
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1
  ###################[ command_execution_time: duration of the last command ]###################
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=66
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=4
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='took '
  #######################[ background_jobs: presence of background jobs ]#######################
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  #######################[ direnv: direnv status (https://direnv.net/) ]########################
  typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=3
  typeset -g POWERLEVEL9K_DIRENV_BACKGROUND=0
  ###############[ asdf: asdf version manager (https://github.com/asdf-vm/asdf) ]###############
  typeset -g POWERLEVEL9K_ASDF_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_BACKGROUND=7
  #
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)
  #
  typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false
  #
  typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true
  #
  #
  #
  typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=
  typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_RUBY_BACKGROUND=1
  typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PYTHON_BACKGROUND=4
  typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_GOLANG_BACKGROUND=4
  typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_NODEJS_BACKGROUND=2
  typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_RUST_BACKGROUND=208
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_BACKGROUND=5
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_BACKGROUND=4
  typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_LUA_BACKGROUND=4
  typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=1
  typeset -g POWERLEVEL9K_ASDF_JAVA_BACKGROUND=7
  typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PERL_BACKGROUND=4
  typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_ERLANG_BACKGROUND=1
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_BACKGROUND=5
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_BACKGROUND=6
  typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PHP_BACKGROUND=5
  typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_HASKELL_BACKGROUND=3
  typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_JULIA_BACKGROUND=2
  ##########[ nordvpn: nordvpn connection status, linux only (https://nordvpn.com/) ]###########
  typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=7
  typeset -g POWERLEVEL9K_NORDVPN_BACKGROUND=4
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=
  #################[ ranger: ranger shell (https://github.com/ranger/ranger) ]##################
  typeset -g POWERLEVEL9K_RANGER_FOREGROUND=3
  typeset -g POWERLEVEL9K_RANGER_BACKGROUND=0
  ######################[ nnn: nnn shell (https://github.com/jarun/nnn) ]#######################
  typeset -g POWERLEVEL9K_NNN_FOREGROUND=0
  typeset -g POWERLEVEL9K_NNN_BACKGROUND=6
  ##################[ xplr: xplr shell (https://github.com/sayanarijit/xplr) ]##################
  typeset -g POWERLEVEL9K_XPLR_FOREGROUND=0
  typeset -g POWERLEVEL9K_XPLR_BACKGROUND=6
  ###########################[ vim_shell: vim shell indicator (:sh) ]###########################
  typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_VIM_SHELL_BACKGROUND=2
  ######[ midnight_commander: midnight commander shell (https://midnight-commander.org/) ]######
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=3
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_BACKGROUND=0
  #[ nix_shell: nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html) ]##
  typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_NIX_SHELL_BACKGROUND=4
  ##################################[ disk_usage: disk usage ]##################################
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=3
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND=0
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=0
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND=3
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=7
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND=1
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=90
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=95
  typeset -g POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=false
  ###########[ vi_mode: vi mode (you don't need this if you've enabled prompt_char) ]###########
  typeset -g POWERLEVEL9K_VI_MODE_FOREGROUND=0
  typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=2
  typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=4
  typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
  typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3
  typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=8
  ######################################[ ram: free RAM ]#######################################
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=0
  typeset -g POWERLEVEL9K_RAM_BACKGROUND=9
  #####################################[ swap: used swap ]######################################
  typeset -g POWERLEVEL9K_SWAP_FOREGROUND=0
  typeset -g POWERLEVEL9K_SWAP_BACKGROUND=3
  ######################################[ load: CPU load ]######################################
  typeset -g POWERLEVEL9K_LOAD_WHICH=5
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_NORMAL_BACKGROUND=2
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_WARNING_BACKGROUND=3
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND=1
  ################[ todo: todo items (https://github.com/todotxt/todo.txt-cli) ]################
  typeset -g POWERLEVEL9K_TODO_FOREGROUND=0
  typeset -g POWERLEVEL9K_TODO_BACKGROUND=8
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=true
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false
  #
  #
  #
  #
  #
  ###########[ timewarrior: timewarrior tracking status (https://timewarrior.net/) ]############
  typeset -g POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=255
  typeset -g POWERLEVEL9K_TIMEWARRIOR_BACKGROUND=8
  typeset -g POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'
  ##############[ taskwarrior: taskwarrior task count (https://taskwarrior.org/) ]##############
  typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND=0
  typeset -g POWERLEVEL9K_TASKWARRIOR_BACKGROUND=6
  #
  #
  #
  #
  #
  ##################################[ context: user@hostname ]##################################
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=3
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=3
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=
  typeset -g POWERLEVEL9K_CONTEXT_PREFIX='with '
  ###[ virtualenv: python virtual environment (https://docs.python.org/3/library/venv.html) ]###
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=4
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=
  #####################[ anaconda: conda environment (https://conda.io/) ]######################
  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ANACONDA_BACKGROUND=4
  #
  #
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'
  ################[ pyenv: python environment (https://github.com/pyenv/pyenv) ]################
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PYENV_BACKGROUND=4
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true
  #
  #
  #
  typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT}${${P9K_CONTENT:#$P9K_PYENV_PYTHON_VERSION(|/*)}:+ $P9K_PYENV_PYTHON_VERSION}'
  ################[ goenv: go environment (https://github.com/syndbg/goenv) ]################
  typeset -g POWERLEVEL9K_GOENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_GOENV_BACKGROUND=4
  typeset -g POWERLEVEL9K_GOENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_GOENV_SHOW_SYSTEM=true
  ##########[ nodenv: node.js version from nodenv (https://github.com/nodenv/nodenv) ]##########
  typeset -g POWERLEVEL9K_NODENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_NODENV_BACKGROUND=0
  typeset -g POWERLEVEL9K_NODENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_NODENV_SHOW_SYSTEM=true
  ##############[ nvm: node.js version from nvm (https://github.com/nvm-sh/nvm) ]###############
  typeset -g POWERLEVEL9K_NVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_NVM_BACKGROUND=5
  ############[ nodeenv: node.js environment (https://github.com/ekalinin/nodeenv) ]############
  typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_NODEENV_BACKGROUND=0
  typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false
  typeset -g POWERLEVEL9K_NODEENV_{LEFT,RIGHT}_DELIMITER=
  ##############################[ node_version: node.js version ]###############################
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=7
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=2
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
  #######################[ go_version: go version (https://golang.org) ]########################
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=255
  typeset -g POWERLEVEL9K_GO_VERSION_BACKGROUND=2
  typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true
  #################[ rust_version: rustc version (https://www.rust-lang.org) ]##################
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=0
  typeset -g POWERLEVEL9K_RUST_VERSION_BACKGROUND=208
  typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true
  ###############[ dotnet_version: .NET version (https://dotnet.microsoft.com) ]################
  typeset -g POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=7
  typeset -g POWERLEVEL9K_DOTNET_VERSION_BACKGROUND=5
  typeset -g POWERLEVEL9K_DOTNET_VERSION_PROJECT_ONLY=true
  #####################[ php_version: php version (https://www.php.net/) ]######################
  typeset -g POWERLEVEL9K_PHP_VERSION_FOREGROUND=0
  typeset -g POWERLEVEL9K_PHP_VERSION_BACKGROUND=5
  typeset -g POWERLEVEL9K_PHP_VERSION_PROJECT_ONLY=true
  ##########[ laravel_version: laravel php framework version (https://laravel.com/) ]###########
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND=1
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_BACKGROUND=7
  #############[ rbenv: ruby version from rbenv (https://github.com/rbenv/rbenv) ]##############
  typeset -g POWERLEVEL9K_RBENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_RBENV_BACKGROUND=1
  typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_RBENV_SHOW_SYSTEM=true
  ####################[ java_version: java version (https://www.java.com/) ]####################
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=1
  typeset -g POWERLEVEL9K_JAVA_VERSION_BACKGROUND=7
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true
  typeset -g POWERLEVEL9K_JAVA_VERSION_FULL=false
  ###[ package: name@version from package.json (https://docs.npmjs.com/files/package.json) ]####
  typeset -g POWERLEVEL9K_PACKAGE_FOREGROUND=0
  typeset -g POWERLEVEL9K_PACKAGE_BACKGROUND=6
  #
  #
  #######################[ rvm: ruby version from rvm (https://rvm.io) ]########################
  typeset -g POWERLEVEL9K_RVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_RVM_BACKGROUND=240
  typeset -g POWERLEVEL9K_RVM_SHOW_GEMSET=false
  typeset -g POWERLEVEL9K_RVM_SHOW_PREFIX=false
  ###########[ fvm: flutter version management (https://github.com/leoafarias/fvm) ]############
  typeset -g POWERLEVEL9K_FVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_FVM_BACKGROUND=4
  ##########[ luaenv: lua version from luaenv (https://github.com/cehoffman/luaenv) ]###########
  typeset -g POWERLEVEL9K_LUAENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_LUAENV_BACKGROUND=4
  typeset -g POWERLEVEL9K_LUAENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_LUAENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_LUAENV_SHOW_SYSTEM=true
  ###############[ jenv: java version from jenv (https://github.com/jenv/jenv) ]################
  typeset -g POWERLEVEL9K_JENV_FOREGROUND=1
  typeset -g POWERLEVEL9K_JENV_BACKGROUND=7
  typeset -g POWERLEVEL9K_JENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_JENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_JENV_SHOW_SYSTEM=true
  ###########[ plenv: perl version from plenv (https://github.com/tokuhirom/plenv) ]############
  typeset -g POWERLEVEL9K_PLENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PLENV_BACKGROUND=4
  typeset -g POWERLEVEL9K_PLENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PLENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PLENV_SHOW_SYSTEM=true
  ############[ phpenv: php version from phpenv (https://github.com/phpenv/phpenv) ]############
  typeset -g POWERLEVEL9K_PHPENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PHPENV_BACKGROUND=5
  typeset -g POWERLEVEL9K_PHPENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PHPENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PHPENV_SHOW_SYSTEM=true
  #######[ scalaenv: scala version from scalaenv (https://github.com/scalaenv/scalaenv) ]#######
  typeset -g POWERLEVEL9K_SCALAENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_SCALAENV_BACKGROUND=1
  typeset -g POWERLEVEL9K_SCALAENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_SCALAENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_SCALAENV_SHOW_SYSTEM=true
  ##########[ haskell_stack: haskell version from stack (https://haskellstack.org/) ]###########
  typeset -g POWERLEVEL9K_HASKELL_STACK_FOREGROUND=0
  typeset -g POWERLEVEL9K_HASKELL_STACK_BACKGROUND=3
  #
  typeset -g POWERLEVEL9K_HASKELL_STACK_SOURCES=(shell local)
  typeset -g POWERLEVEL9K_HASKELL_STACK_ALWAYS_SHOW=true
  ################[ terraform: terraform workspace (https://www.terraform.io) ]#################
  typeset -g POWERLEVEL9K_TERRAFORM_SHOW_DEFAULT=false
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_TERRAFORM_CLASSES=(
      '*'         OTHER)
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=4
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_BACKGROUND=0
  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'
  #
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=5
  #
  #
  #
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'
  typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='at '
  #[ aws: aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) ]#
  typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_AWS_CLASSES=(
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=1
  #
  typeset -g POWERLEVEL9K_AWS_CONTENT_EXPANSION='${P9K_AWS_PROFILE//\%/%%}${P9K_AWS_REGION:+ ${P9K_AWS_REGION//\%/%%}}'
  #[ aws_eb_env: aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/) ]#
  typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_AWS_EB_ENV_BACKGROUND=0
  ##########[ azure: azure account name (https://docs.microsoft.com/en-us/cli/azure) ]##########
  typeset -g POWERLEVEL9K_AZURE_SHOW_ON_COMMAND='az|terraform|pulumi|terragrunt'
  typeset -g POWERLEVEL9K_AZURE_FOREGROUND=7
  typeset -g POWERLEVEL9K_AZURE_BACKGROUND=4
  ##########[ gcloud: google cloud account and project (https://cloud.google.com/) ]###########
  typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs'
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=7
  typeset -g POWERLEVEL9K_GCLOUD_BACKGROUND=4
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_ID//\%/%%}'
  typeset -g POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_NAME//\%/%%}'
  typeset -g POWERLEVEL9K_GCLOUD_REFRESH_PROJECT_NAME_SECONDS=60
  #[ google_app_cred: google application credentials (https://cloud.google.com/docs/authentication/production) ]#
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform|pulumi|terragrunt'
  #
  #
  #
  #
  #
  #
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=(
      '*'             DEFAULT)
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_BACKGROUND=4
  #
  #
  #
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_CONTENT_EXPANSION='${P9K_GOOGLE_APP_CRED_PROJECT_ID//\%/%%}'
  ###############################[ public_ip: public IP address ]###############################
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=0
  typeset -g POWERLEVEL9K_PUBLIC_IP_BACKGROUND=5
  ########################[ vpn_ip: virtual private network indicator ]#########################
  typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=0
  typeset -g POWERLEVEL9K_VPN_IP_BACKGROUND=6
  typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(gpd|wg|(.*tun)|tailscale)[0-9]*'
  typeset -g POWERLEVEL9K_VPN_IP_SHOW_ALL=false
  ###########[ ip: ip address and bandwidth usage for a specified network interface ]###########
  typeset -g POWERLEVEL9K_IP_BACKGROUND=4
  typeset -g POWERLEVEL9K_IP_FOREGROUND=0
  #
  #typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='${P9K_IP_RX_RATE:+⇣$P9K_IP_RX_RATE }${P9K_IP_TX_RATE:+⇡$P9K_IP_TX_RATE }$P9K_IP_IP'
  typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='$P9K_IP_IP'
  typeset -g POWERLEVEL9K_IP_INTERFACE='[ew].*'
  typeset -g POWERLEVEL9K_IP_VISUAL_IDENTIFIER_EXPANSION='󰀑 '
  #########################[ proxy: system-wide http/https/ftp proxy ]##########################
  typeset -g POWERLEVEL9K_PROXY_FOREGROUND=4
  typeset -g POWERLEVEL9K_PROXY_BACKGROUND=0
  ################################[ battery: internal battery ]#################################
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=2
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=7
  typeset -g POWERLEVEL9K_BATTERY_STAGES='\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=true
  typeset -g POWERLEVEL9K_BATTERY_BACKGROUND=55
  #####################################[ wifi: wifi speed ]#####################################
  typeset -g POWERLEVEL9K_WIFI_FOREGROUND=0
  typeset -g POWERLEVEL9K_WIFI_BACKGROUND=4
  #
  #
  #
  #
  ####################################[ time: current time ]####################################
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=7
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
  typeset -g POWERLEVEL9K_TIME_PREFIX='at '
  #
  #function prompt_example() {
  #}
  function prompt_example() {
    p10k segment -b 1 -f 3 -i '' -t 'Rex Ackermann'
  }
  #
  #
  function instant_prompt_example() {
    prompt_example
  }
  typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=0
  typeset -g POWERLEVEL9K_EXAMPLE_BACKGROUND=red
  #
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  #
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
function prompt_incognito_flag() {
     if [[ $incognito == "true" ]]; then
          p10k segment -b green -f black   -t "Incognito"
     fi
}
function prompt_shell_mommy() {
     preexec(){
          cmd=$1
     }
     precmd(){
          if [ "$cmd" ]; then
               lcmd=$cmd &&
                    if (( $? != 0 )); then
                         mommy false
                    else
                         mommy true
                    fi
               cmd=
          else
               mommy_did_not_run=true
          fi
     }
}
function prompt_my_cpu_temp() {
if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then
  break
else
  integer cpu_temp="$(</sys/class/thermal/thermal_zone0/temp) / 1000"
  if (( cpu_temp >= 80 )); then
    p10k segment -s HOT -b yollow -f red    -t "${cpu_temp}"$'\uE339' -i $'\uF737'
  elif (( cpu_temp >= 60 )); then
    p10k segment -s WARM -b yollow -f green -t "${cpu_temp}"$'\uE339' -i $'\uE350'
  fi
fi
}
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  (( ! $+functions[p10k] )) || p10k reload
}
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
source $ZSH/oh-my-zsh.sh
[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"
export PATH=$HOME/.yarn/bin:$PATH
fpath+=${ZDOTDIR:-~}/.zsh_functions
autoload bashcompinit
bashcompinit
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.config/.emacs/bin:$PATH"
export PATH="$HOME/shell/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"
export PATH="$HOME/.config/bin:$PATH"
[ -f $XDG_CONFIG_HOME/zsh/history ] && export HISTFILE=$XDG_CONFIG_HOME/zsh/history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
source $XDG_CONFIG_HOME/zsh/.zshrc_private
() {
  local FLATPAK_APPS=$(flatpak list --app | cut -f1 | awk '{print tolower($1)}')
  complete -W $FLATPAK_APPS fp
}
function fp() {
  app=$(flatpak list --app | cut -f2 | awk -v app="$1" '(tolower($NF) ~ tolower(app))')
  test -z $1 && printf "Enter an app to fp.\n\$ fp <app>\n\nINSTALLED APPS\n$app\n" && return;
  shift 1;
  ( flatpak run "$app" "$@" &> /dev/null & )
}
alias lc='exa'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
eval "$(register-python-argcomplete pipx)"
[ -s /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
binpath() {
  bin_path="$(type -a "$1" | grep -v 'function' | grep -v 'alias' | awk '{print $3 ; exit}')"
  echo "$bin_path"
}
load_colors() {
      export FG_R_Black="\e[0;30m"
      export FG_R_Red="\e[0;31m"
      export FG_R_Green="\e[0;32m"
      export FG_R_Yellow="\e[0;33m"
      export FG_R_Blue="\e[0;34m"
      export FG_R_Purple="\e[0;35m"
      export FG_R_Cyan="\e[0;36m"
      export FG_R_White="\e[0;37m"
      export FG_B_Black="\e[1;30m"
      export FG_B_Red="\e[1;31m"
      export FG_B_Green="\e[1;32m"
      export FG_B_Yellow="\e[1;33m"
      export FG_B_Blue="\e[1;34m"
      export FG_B_Purple="\e[1;35m"
      export FG_B_Cyan="\e[1;36m"
      export FG_B_White="\e[1;37m"
      export FG_U_Black="\e[4;30m"
      export FG_U_Red="\e[4;31m"
      export FG_U_Green="\e[4;32m"
      export FG_U_Yellow="\e[4;33m"
      export FG_U_Blue="\e[4;34m"
      export FG_U_Purple="\e[4;35m"
      export FG_U_Cyan="\e[4;36m"
      export FG_U_White="\e[4;37m"
      export BG_R_Black="\e[40m"
      export BG_R_Red="\e[41m"
      export BG_R_Green="\e[42m"
      export BG_R_Yellow="\e[43m"
      export BG_R_Blue="\e[44m"
      export BG_R_Purple="\e[45m"
      export BG_R_Cyan="\e[46m"
      export BG_R_White="\e[47m"
      export FG_HI_Black="\e[0;90m"
      export FG_HI_Red="\e[0;91m"
      export FG_HI_Green="\e[0;92m"
      export FG_HI_Yellow="\e[0;93m"
      export FG_HI_Blue="\e[0;94m"
      export FG_HI_Purple="\e[0;95m"
      export FG_HI_Cyan="\e[0;96m"
      export FG_HI_White="\e[0;97m"
      export FG_BHI_Black="\e[1;90m"
      export FG_BHI_Red="\e[1;91m"
      export FG_BHI_Green="\e[1;92m"
      export FG_BHI_Yellow="\e[1;93m"
      export FG_BHI_Blue="\e[1;94m"
      export FG_BHI_Purple="\e[1;95m"
      export FG_BHI_Cyan="\e[1;96m"
      export FG_BHI_White="\e[1;97m"
      export BG_HI_Black="\e[0;100m"
      export BG_HI_Red="\e[0;101m"
      export BG_HI_Green="\e[0;102m"
      export BG_HI_Yellow="\e[0;103m"
      export BG_HI_Blue="\e[0;104m"
      export BG_HI_Purple="\e[0;105m"
      export BG_HI_Cyan="\e[0;106m"
      export BG_HI_White="\e[0;107m"
}
load_colors
init() {
     while getopts hie:l:s:f: option; do
          case "$option" in
               h)
                    echo -e ""
                    echo -e "${FG_R_White}${BG_R_Black}This is${ClearColor} ${FG_B_Black}${BG_R_Red}Command${BG_R_Green}Scrach${BG_R_White}Pad${ClearColor} ${FG_B_White}${BG_R_Black}or${ClearColor} ${FG_B_Black}${BG_R_Red}c${BG_R_Green}s${BG_R_White}p${ClearColor}\n"
                    echo -e "${FG_B_Cyan}${BG_R_Black}This script lets you create a script and execute it on the fly.\n"
                    echo -e "${FG_R_Green}-f${ClearColor}  ${FG_R_White}file/script/path${ClearColor}"
                    echo -e "${FG_R_Green}-s${ClearColor}  ${FG_R_White}script_in_your_path${ClearColor}"
                    echo -e "${FG_R_Green}-i${ClearColor}  ${FG_R_White}edit dirrectly \(use with -f or -s\)"
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
                    "$EDITOR" "$(which "$OPTARG" | head -n 1)"
                    exit
                    ;;
               l)
                    hisline=$OPTARG
                    ;;
               *)
                    exit
                    ;;
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
         (*) exit 1
       esac
     done
}
addESC() { sed 's/[][ \~`!@#$%^&*()=+{}|;:'"'"'",<>/?-]/\\&/g'; }
getnamedir () {
     if [[ $getnamedirpass == true ]] ; then
          echo working
          echo ""
     else
          t=$(date +%s)
          cdr=$(pwd)
     fi
}
inject () {
     echo "#!/usr/bin/env bash" > c"$t".c.sh &&
     echo "$pipe" >> c"$t".c.sh &&
     echo "" >> c"$t".c.sh &&
     tail -n "${hisline:-10}" "$HISTFILE" | sed 's/:.*;/#c /' >> c"$t".c.sh &&
     echo "" >> c"$t".c.sh &&
     echo '#c Tip: To get a increamental sequence in numbers select with Ctrl-v and g-v-g and then Ctrl-a' >> c"$t".c.sh &&
     echo "" >> c"$t".c.sh &&
     echo -e "$comm" >> c"$t".c.sh
}
makekscript () {
     ${EDITOR:-vi} ./c"$t".c.sh &&
     scripttxt="$(echo "$cdr"/c"$t".c.sh | grep "^[^#]" | grep -v "^$")"
     if [[ $scripttxt == "" ]] ; then
          echo "Nothing to Execute" && rm "$cdr"/c"$t".c.sh && exit
     fi
     echo Executuing: &&
     tput setaf 198
     command -v bat >/dev/null && bat -P c"$t".c.sh || cat .c.sh &&
     tput setaf 7
     chmod +x c"$t".c.sh
     mkdir -p ~/c
}
ifpiped () {
     echo "Data was piped to this script!"
     echo -e "#\ Warning : Piping is being used.Therefore, script will execute on save and exit.If you do not want it executing do not save just quit." >> c"$t".c.sh &&
     echo -e "" >> c"$t".c.sh
     while IFS= read  pipe; do
          echo "${pipe}" >> c"$t".c.sh
     done
}
askc () {
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Green}Execute${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Green}y${ClearColor}"
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Red}Discard${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Red}n${ClearColor} or ${FG_B_Black}${BG_R_Red}d${ClearColor}"
     echo -e "${ClearColor}Or perhaps you want to save the script with a     ${FG_B_Black}${BG_R_Purple}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Purple}r${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to save the script without a    ${FG_B_Black}${BG_R_Yellow}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Yellow}c${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to rework the script, I mean    ${FG_B_Black}${BG_R_Cyan}rework${ClearColor}     ?  Press ${FG_B_Black}${BG_R_Cyan}e${ClearColor}"
     echo -e "${ClearColor}Oh ,and if you end up pressing enter or anything else except Ctrl-c ,it will count like c\n"
     read -k confirmation
     echo ""
     if [[ $confirmation == "y" ]] ; then
          export run=true
     elif [[ $confirmation == "n" || $confirmation == "d" ]] ; then
          rm "$cdr"/c"$t".c.sh && echo removed
          break
     elif [[ $confirmation == "r" ]] ; then
          echo -e "What\'s the new name ? It will be saved in ~/c btw !\n"
          read newname
          mv "$cdr"/c"$t".c.sh ~/c/"$(echo "$newname" | addESC)" && echo "saved ~/c/$newname"
          break
     elif [[ $confirmation == "c" ]] ; then
          mv "$cdr"/c"$t".c.sh ~/c && echo -e "saved ~/c/c$t.c.sh"
          break
     elif [[ $confirmation == "e" ]] ; then
          getnamedirpass=true
          mainscript "$cdr"/c"$t".c.sh
          break
     else
          mv "$cdr"/c"$t".c.sh ~/c && echo "saved ~/c/c$t.c.sh"
          break
     fi
}
executeandsave () {
     ./c"$t".c.sh && echo -e "\n\e[30m\e[42mExecuted\e[0m\n"
     scripttxt="$(echo "$cdr"/c"$t".c.sh | grep "^[^#]" | grep -v "^$")"
     if [[ $scripttxt == "" ]] ; then
          rm "$cdr"/c"$t".c.sh
     else
          echo -e ""
          echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Green}save${ClearColor} it           ?       Press ${FG_B_Black}${BG_R_Green}y${ClearColor}"
          echo -e "${ClearColor}Or perhaps you want to                            ${FG_R_Black}${BG_R_Red}delete${ClearColor} the script ?       Press ${FG_R_Black}${BG_R_Red}d${ClearColor} or ${FG_R_Black}${BG_R_Red}n${ClearColor}"
          echo -e "${ClearColor}Do you want to save it with a                     ${FG_R_Black}${BG_R_Purple}custom name${ClearColor}       ?       Press ${FG_R_Black}${BG_R_Purple}r${ClearColor}"
          echo -e "${ClearColor}Or maybe you want to rework the script, I mean    ${FG_B_Black}${BG_R_Cyan}rework${ClearColor}            ?       Press ${FG_B_Black}${BG_R_Cyan}e${ClearColor}"
          echo -e "${ClearColor}Oh ,and if you end up pressing enter or anything else ,it will count like y"
          read -k confirmation
          echo ""
          echo -e ""
          if [[ $confirmation == "y" ]] ; then
               mv "$cdr"/c"$t".c.sh ~/c && echo "saved ~c/c$t.c.sh"
          elif [[ $confirmation == "n" || $confirmation == "d" ]] ; then
               rm "$cdr"/c"$t".c.sh && echo removed
          elif [[ $confirmation == "r" ]] ; then
               echo -e "What\'s the new name ? It will be saved in ~/c btw !\n"
               read newname
               mv "$cdr"/c"$t".c.sh ~/c/"$(echo "$newname" | addESC)" && echo -e "saved ~/c/$newname"
          elif [[ $confirmation == "e" ]] ; then
               getnamedirpass=true
               mainscript "$cdr"/c"$t".c.sh
               break
               ut enter
          else
               mv "$cdr"/c"$t".c.sh ~/c && echo -e "saved ~c/c$t.c.sh"
          fi
     fi
}
s () {
     if [[ $s == "true" ]] ; then
          if [[ $i == "true" ]] ; then
               cat "$(which "$loc" | head -n 1)" >> "$cdr"/c"$t".c.sh
          else
               cp "$(which "$loc")" "$cdr"/c"$t".c.sh
          fi
     fi
}
f () {
     if [[ $f == "true" ]] ; then
          if [[ $i == "true" ]] ; then
               cat "$(realpath "$loc")" >> "$cdr"/c"$t".c.sh
          else
               cp "$(realpath "$loc")" "$cdr"/c"$t".c.sh
          fi
     fi
}
comm=$*
c () {
     init "$comm"
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
          askc
          executeandsave
     fi
}
align_center() {
    local terminal_width=$(tput cols)     
    local text="${1:?}"                   
    local glyph="${2:-=}"                 
    local glyph2="${3:-=}"                 
    local padding="${4:-2}"               
    local text_width=${#text}
    local glyph_width="${#glyph}"                 
    local glyph2_width="${#glyph2}"                 
    local border_width=$(( ((terminal_width - (padding * 2) - text_width) / 2) / $glyph_width ))
    local border=                         
    for ((i=0; i<border_width; i++))
    do
        border+="${glyph}"
    done
    if (( ( terminal_width - ( padding * 2 ) - text_width ) % 2 == 0 ))
    then
        local left_border=$border
        local right_border=$left_border
    else
        local left_border=$border
        local right_border="${border}${glyph}"
    fi
    local spacing=
    for ((i=0; i<$padding; i++))
    do
        spacing+=" "
    done
    for i in {1..$(($terminal_width/$glyph2_width))}; do echo -n "$glyph2"; done
    for i in {1..$(($terminal_width%$glyph2_width))}; do echo -n "${glyph2:0:$(($terminal_width%$glyph2_width))}"; done
    printf "${left_border}${spacing}${text}${spacing}${right_border}"
    for i in {1..$(($terminal_width%$glyph_width))}; do echo -n "${glyph:0:$(($terminal_width%$glyph2_width))}"; done
    for i in {1..$(($terminal_width/$glyph2_width))}; do echo -n "$glyph2"; done
    for i in {1..$(($terminal_width%$glyph2_width))}; do echo -n "${glyph2:0:$(($terminal_width%$glyph2_width))}"; done
}
incognito() {
     if [[ $1 == "off" || $1 == "disable" || $1 == "--off" || $1 == "--disable" || $1 == "d" || $1 == "-d" ]] ; then
          fc -P && incognito=false
          clear &&
          rm -rfv /tmp/.zsh_history.tmp && echo "Temporary history removed" &&
          echo -e "${FG_R_Black}${BG_R_Red}" &&
          align_center "Incognito Mode Disabled" "󱐡 " "󰗹 " &&
          echo -e "${ClearColor}\n"
     else
          "$(binpath cp)" "$HISTFILE" /tmp/.zsh_history.tmp &&
          fc -p /tmp/.zsh_history.tmp && incognito=true
          clear &&
          echo -e "${FG_R_Black}${BG_R_Green}" &&
          align_center "Incognito Mode Enabled" "󱐡 " "󰗹 " &&
          echo -e "${ClearColor}\n"
     fi
}
function command_permission() {
  local cmd="${1}"
  local cmd=$(echo "${cmd}" | awk '{print $1}' )
  if [[ "${cmd}" =~ ^\./ && ! -x "${cmd#./}" ]]; then
    read -rq "REPLY?${cmd#./} is not executable. Do you want to make it executable (y/n)? "
    "$cmd" "$@"
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      chmod +x "${cmd#./}"
    fi
    echo ""
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec command_permission
unixtime() {
  date +%s
}
mommy() (
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
  if [ "$SHELL_MOMMYS_ONLY_NEGATIVE" = "true" ]; then
    DEF_ONLY_NEGATIVE="true"
  fi
  if [ -n "$SHELL_MOMMYS_POSITIVE_RESPONSES" ]; then
    POSITIVE_RESPONSES="$SHELL_MOMMYS_POSITIVE_RESPONSES"
  fi
  if [ -n "$SHELL_MOMMYS_NEGATIVE_RESPONSES" ]; then
    NEGATIVE_RESPONSES="$SHELL_MOMMYS_NEGATIVE_RESPONSES"
  fi
  pick_word() {
    echo "$1" | tr '/' '\n' | shuf | sed 1q
  }
  pick_response() { 
    if [ "$1" = "positive" ]; then
      element=$(echo "$POSITIVE_RESPONSES" | shuf | sed 1q)
    elif [ "$1" = "negative" ]; then
      element=$(echo "$NEGATIVE_RESPONSES" | shuf | sed 1q)
    else
      echo "Invalid response type: $1"
      exit 1
    fi
    echo "$element"
  }
  sub_terms() { 
    response="$1"
    affectionate_term="$(pick_word "${DEF_WORDS_LITTLE}")"
    pronoun="$(pick_word "${DEF_WORDS_PRONOUNS}")"
    role="$(pick_word "${DEF_WORDS_ROLES}")"
    response="$(echo "$response" | sed "s/AFFECTIONATE_TERM/$affectionate_term/g")"
    response="$(echo "$response" | sed "s/MOMMYS_PRONOUN/$pronoun/g")"
    response="$(echo "$response" | sed "s/MOMMYS_ROLE/$role/g")"
    printf "\n${DEF_MOMMY_COLOR}$response${COLORS_RESET}\n\n"
  }
  success() {
    (
      if [ "$DEF_ONLY_NEGATIVE" = "true" ]; then
        return 0
      fi
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
  eval "$@" && success || failure
  return $?
)
SHELL_MOMMYS_LITTLE="kid"
SHELL_MOMMYS_PRONOUNS="her"
SHELL_MOMMYS_ROLES="mommy"
SHELL_MOMMYS_COLOR=""
SHELL_MOMMYS_ONLY_NEGATIVE="false"
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
ftpplay() {
ulimit -s 9999999
video="${1}"
sub="${2}"
ep="${3:-25}"
for (( i=01; i<="$ep"; i++ ))
do
    ii=$(printf '%02d\n' $i)
    linkv=${video/episode_nung/$ii}
    links=${sub/episode_nung/$ii}
    linkvs+=("$linkv")
    linkss+=("$links")
done
[[ "$sub" != "" ]] && comm="$(printf '%s --sub-files-append=%s %s ' "mpv" "${linkss[@]}" "${linkvs[@]}")"
comm="$(printf '%s %s ' "mpv" "${linkvs[@]}")"
printf '%s' "$comm"
echo print now playing:
eval ${comm}
}
ccr() {
if [ -z "$1" ]; then
    echo "Error: No file specified"
    break
fi
if [ ! -f "$1" ]; then
    echo "Error: File $1 not found"
    break
fi
if [[ "$1" != *.c && "$1" != *.cpp ]]; then
    echo "Error: $1 is not a C or C++ source file"
    break
fi
file_base=$(basename -s .c "$1")
file_base=$(basename -s .cpp "$file_base")
if [[ "$1" == *.c ]]; then
    gcc -o "$file_base" "$1"
else
    g++ -o "$file_base" "$1"
fi
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed"
    break
fi
shift
"./$file_base" "$@"
rm "$file_base"
}
encryptdir() {
cp -rfv $(which encryptdir) $(pwd)/close
echo "Do you really wanna continue ? All files and folder in this dirrectory will be encrypted if you do this !"
echo "You are currently in the dirrectory : "
echo $(pwd)
echo "If you want to continue type password.You will have to retype it to confirm.Keep the password !!!"
tar -czf - * --remove-files | openssl enc -e -aes256 -salt -out secured && echo "done" &&
echo "#!/usr/bin/env bash" > open &&
echo "openssl enc -d -aes256 -in secured | tar xz && rm -rfv secured open && echo done &&" >> open &&
echo "ls" >> open &&
echo "dust -n 100" >> open &&
echo "mv -fv open .open" &&
chmod +x open &&
ls &&
dust -n 100 &&
echo ""
echo "The contents of the folder has been encrypted.(Or not ! Look at the file list.)"
echo "If they were encrpted and you want to get them back run the 'open' script using ./open ."
}
pdfmerge() {
mkdir ./tmp
tp="./tmp/tmp.pdf"
td="./tmp/data"
for i in *.pdf; do
    echo "Bookmarking $i"
    printf "BookmarkBegin\nBookmarkTitle: %s\nBookmarkLevel: 1\nBookmarkPageNumber: 1\n" "${i%.*}"> "$td"
    pdftk "$i" update_info "$td" output "$tp"
    mv "$tp" "$i"
done
pdftk *.pdf cat output ${1:-merged.pdf}
 rm -rfv ./tmp
 echo "\ndone"
}
srhs() {
     rg "$*" "$HISTFILE" || cat $HISTFILE | grep "$*"
}
termuxexec() {
     if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then
          sshd -p 43434
     else
          which em 2&> /dev/null >> /dev/null && export EDITOR="em" || export EDITOR="emacsclient -ca "emacs""
     fi
}
#alias walfix="dbus-send --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval "string:global.reexec_self()""
#alias minimize="$bash xdotool windowminimize $(xdotool getactivewindow)"
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias tvp="mplayer -vo fbdev2 -fs -zoom -xy"
alias beelogger="sudo python /home/rex/BeeLogger/bee.py"
alias bh="sync && sudo sysctl -w vm.drop_caches=3 && sudo sysctl -w vm.drop_caches=2"
alias fullscreen="wmctrl -r ':ACTIVE:' -b add,fullscreen"
alias unfullscreen="wmctrl -r ':ACTIVE:' -b add,fullscreen"
alias sublime="/opt/sublime_text/sublime_text"
alias glances="glances -C $HOME/Documents/glances.conf"
alias vm.drop="sudo sysctl -w vm.drop_caches=3 && sudo sysctl -w vm.drop_caches=2 && sudo sysctl -w vm.drop_caches=1"
alias iris="xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -debug -- mpv -wid WID --loop --no-audio ~/Videos/video.mp4 /home/rex/Videos/iris.mp4 &; disown"
alias irisk="pkill -f "xwinwrap""
alias pk="pkill -9 -e"
alias wallpaper="tiv /home/rex/.config/autowallp/wall-dark0 && tiv /home/rex/.config/autowallp/wall-dark1 && tiv /home/rex/.config/autowallp/wall-dark2 && tiv /home/rex/.config/autowallp/wall-dark3 && tiv /home/rex/.config/autowallp/wall-dark4"
alias m="mpv --demuxer-max-bytes=50M"
alias define="sdcv"
alias fetch="cpufetch -Fs fancy -c intel && neofetch"
alias magick="magick -limit memory 2GiB "
alias mvi='mpv --config-dir=$HOME/.config/mvi'
alias mpvu="mpv --ytdl-raw-options=geo-bypass-country=UK"
alias emacs="emacsclient -ca "emacs""
alias pipupgrade="pip-review --local --auto"
alias tik="$(binpath kitty) +kitten icat"
alias icat="~/.local/kitty.app/bin/kitty +kitten icat"
alias gdown="gdown --fuzzy --continue"
alias gdownf="gdown --fuzzy --continue --folder"
alias rename="vidir --verbose"
alias yolo=$HOME/yolo-ai-cmdbot/yolo.py
alias computer=$HOME/yolo-ai-cmdbot/yolo.py
alias music=musikcube
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
if command -v newcommand &> /dev/null
then
     alias command="newcommand"
else
     alias command="command"
fi
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
cat() {
    args=("$@")
    args_bat=("$@")
    for arg in "${args[@]}" ; do
        if [[ ! -f "$arg" ]]
        then
            args=("${(@)args:#"$arg"}")
        fi
    done
    for arg in "${args[@]}" ; do
        if [[ -f "$arg" ]]
        then
            args_bat=("${(@)args_bat:#"$arg"}")
        fi
    done
    if [[ -p /dev/stdin ]]
    then
        bat -p --paging=never "${args_bat[@]}" /dev/stdin
        return 0
    fi
    for arg in "${args[@]}" ; do
        if file --mime-type "$arg" | grep -i image >> /dev/null
        then
            if command -v viu &> /dev/null
            then
                viu -1 -t "$arg"
            else
                img2txt -f utf8 -W "$(tput cols)" "$arg"
            fi
        fi
        if file --mime-type "$arg" | grep -v image >> /dev/null
        then
            bat -p --paging=never "${args_bat[@]}" "$arg"
        fi
    done
}
compdef cat=bat
if command -v batman &> /dev/null
then
     alias man="batman"
fi
if command -v batwatch &> /dev/null
then
     alias watch="batwatch"
fi
if command -v batdiff &> /dev/null
then
     alias diff="batdiff"
fi
if command -v rsync &> /dev/null
then
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
unalias ls
unalias l
exa_ls() {
    exa -a --icons "$@"
    printf '\e[31m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(exa -a --icons "$@" | wc -l)
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    echo -ne "count:  \e[31m$total_number_of_files\e[0m"
    for i in {1..$((6-${#total_number_of_files}))} ; do echo -n -e " " ; done
    echo -e "total_size:\e[32m $total_size\e[0m"
}
exa_l() {
    exa -alihgSUFHum --icons "$@"
    exa="$(exa -alihgSUFHum --icons "$@" | head -1)"
    gap1="$(echo "$exa" | awk '{print index($0, "Permissions")-1}')"
    gap2="$(echo "$exa" | awk '{print index($0, "Size")-1}')"
    gap2="$(($gap2-$gap1))"
    printf '\e[31m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(exa -alihgSUFum --icons "$@" | wc -l)-1))
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    echo -ne "count:"
    for i in {1..$(($gap1-6))} ; do echo -n -e " " ; done
    echo -ne "\e[31m$total_number_of_files\e[0m"
    for i in {1..$(($gap2-15))} ; do echo -n -e " " ; done
    echo -ne "total_size:"
    echo -e "\e[32m $total_size\e[0m"
}
exa_lst() {
    exa --tree "$@"
}
gnu_ls() {
    /bin/ls -a "$@"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(/bin/ls -a "$@" | wc -l)-2))
    echo "$total_number_of_files"
}
gnu_l() {
    /bin/ls -alihgSUFHu "$@"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(/bin/ls -alihgSUFHu "$@" | wc -l)-3))
    echo "$total_number_of_files"
}
gnu_lst() {
    /bin/ls "$@"
    /bin/ls "$@" | wc -l
}
if command -v exa &> /dev/null
then
     alias ls="exa_ls"
     alias l="exa_l"
     alias lst="exa_lst"
else
     alias ls="gnu_ls"
     alias l="gnu_l"
     alias lst="gnu_lst"
fi
if command -v bat &> /dev/null
then
    lsblk() {
        "$(which lsblk)" "$@" | cat --language=fstab
    }
    bcat() {
        bcat_var_func="$(functions "$1" | cat -l sh)"
        if [ -n "$bcat_var_func" ] ; then
            echo "$bcat_var_func" | cat -l sh
            echo -e "\n"
        fi
        bcat_var_alias="$(alias "$1" | cat -l sh)"
        if [ -n "$bcat_var_alias" ] ; then
            echo "$bcat_var_alias" | cat -l sh
            echo -e "\n"
        fi
        cat "$(type "$1" | grep -v 'function' | grep -v 'alias' | awk '{print $3}')"
    }
    compdef bcat=which
fi
if command -v bat &> /dev/null
then
    head() {
    /"$(binpath head)" "$@" | cat
    }
fi
if command -v bat &> /dev/null
then
    tail() {
    /"$(binpath head)" "$@" | cat
    }
fi
roxy() {
    sgpt --role roxy "\"$*\""
}
lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  
}
nvm() {
  lazynvm
  nvm "$@"
}
node() {
  lazynvm
  node "$@"
}
npm() {
  lazynvm
  npm "$@"
}
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
LESSOPEN="|/usr/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;
LESS="$LESS -R";
BATPIPE="color";
export LESS;
export BATPIPE;
env=~/.ssh/agent.env
agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }
agent_load_env
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi
unset env
#compdef _glow glow
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
    words=("${=words[1,CURRENT]}")
    __glow_debug "Truncated words[*]: ${words[*]},"
    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __glow_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        flagPrefix="-P ${BASH_REMATCH}"
    fi
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        __glow_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi
    __glow_debug "About to call: eval ${requestComp}"
    out=$(eval ${requestComp} 2>/dev/null)
    __glow_debug "completion output: ${out}"
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __glow_debug "last line: ${lastLine}"
    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
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
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"
        __glow_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
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
            return 0
        else
            __glow_debug "_describe did not find completions."
            __glow_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __glow_debug "deactivating file completion"
                return 1
            else
                __glow_debug "Activating file completion"
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}
if [ "$funcstack[1]" = "_glow" ]; then
    _glow
fi
[ -f "$CARGO_HOME"/env ] && source "$CARGO_HOME/env"
export EDITOR=$(where lvim | head -n 1)
[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"
export ANDROID_HOME="$XDG_DATA_HOME"/android
termuxexec
