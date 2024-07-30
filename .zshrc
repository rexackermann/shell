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

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux new -AD -t main -s main && tmux = "xterm-kitty"
# fi

export ZSH="$XDG_DATA_HOME/oh-my-zsh"

zmodload zsh/zpty
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zstyle ':autocomplete:*' min-input 2  # int
# Wait until this many characters have been typed, before showing completions.
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' default-context ''
zstyle ':autocomplete:*' widget-style complete-word

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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
         zsh-lazyload
         # chromatic-zsh
         )

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.





if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


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


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#!/usr/bin/env zsh

# Generated by Powerlevel10k configuration wizard on 2021-07-27 at 18:36 +06.
# Based on romkatv/powerlevel10k/config/p10k-rainbow.zsh, checksum 20978.
# Wizard options: nerdfont-complete + powerline, large icons, rainbow, unicode,
# 24h time, round separators, round heads, blurred tails, 2 lines, solid, full frame,
# lightest-ornaments, sparse, many icons, fluent, instant_prompt=verbose.
# Type `p10k configure` to generate another config.
#
# Config for Powerlevel10k with powerline prompt style with colorful background.
# Type `p10k configure` to generate your own config based on it.
#
# Tip: Looking for a nice color? Here's a one-liner to print colormap.
#
#   for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done

# Temporarily change options.


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

  # Unset all configuration options. This allows you to apply configuration changes without
  # restarting zsh. Edit ~/.p10k.zsh and type `source ~/.p10k.zsh`.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  autoload -Uz is-at-least && is-at-least 5.1 || return

  # The list of segments shown on the left. Fill it with the most important segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    shell_mommy
    # newline               # \n
    # =========================[ Line #1 ]=========================
    os_icon               # os identifier
    example               # example user-defined segment (see prompt_example function below)
    # =========================[ Line #1 ]=========================
    newline               # \n
    dir                   # current directory
    incognito_flag
    nvidia_flag
    vcs                   # git status
    # =========================[ Line #2 ]=========================
    newline               # \n
    greeting

    newline
    prompt_char           # prompt symbol

  )

  # The list of segments shown on the right. Fill it with less important segments.
  # Right prompt on the last prompt line (where you are typing your commands) gets
  # automatically hidden when the input line reaches it. Right prompt above the
  # last prompt line gets hidden if it would overlap with left prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #2 ]=========================
    sudocheck
    username
    ip                      # ip address and bandwidth usage for a specified network interface
    public_ip               # public IP address
    # proxy                 # system-wide http/https/ftp proxy
    # wifi                  # wifi speed
    # =========================[ Line #1 ]=========================
    newline
    background_jobs         # presence of background jobs
    direnv                  # direnv status (https://direnv.net/)
    asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    anaconda                # conda environment (https://conda.io/)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    goenv                   # go environment (https://github.com/syndbg/goenv)
    nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
    nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    # node_version          # node.js version
    # go_version            # go version (https://golang.org)
    # rust_version          # rustc version (https://www.rust-lang.org)
    # dotnet_version        # .NET version (https://dotnet.microsoft.com)
    # php_version           # php version (https://www.php.net/)
    # laravel_version       # laravel php framework version (https://laravel.com/)
    # java_version          # java version (https://www.java.com/)
    package                 # name@version from package.json (https://docs.npmjs.com/files/package.json)
    rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
    rvm                     # ruby version from rvm (https://rvm.io)
    fvm                     # flutter version management (https://github.com/leoafarias/fvm)
    luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
    jenv                    # java version from jenv (https://github.com/jenv/jenv)
    plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
    phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
    scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
    haskell_stack           # haskell version from stack (https://haskellstack.org/)
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    terraform               # terraform workspace (https://www.terraform.io)
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
    azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
    gcloud                  # google cloud cli account and project (https://cloud.google.com/)
    google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
    context                 # user@hostname
    nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
    ranger                  # ranger shell (https://github.com/ranger/ranger)
    nnn                     # nnn shell (https://github.com/jarun/nnn)
    xplr                    # xplr shell (https://github.com/sayanarijit/xplr)
    vim_shell               # vim shell indicator (:sh)
    midnight_commander      # midnight commander shell (https://midnight-commander.org/)
    nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
    vi_mode                 # vi mode (you don't need this if you've enabled prompt_char)
    vpn_ip                  # virtual private network indicator
    load                    # CPU load
    # disk_usage            # disk usage
    ram                     # free RAM
    # swap                  # used swap
    todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
    timewarrior             # timewarrior tracking status (https://timewarrior.net/)
    taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
    my_cpu_temp             # cpu temperature
    battery                 # internal battery
    # =========================[ Line #1 ]=========================
    newline
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    time                    # current time
  )

  # Defines character set used by powerlevel10k. It's best to let `p10k configure` set it for you.
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  # When set to `moderate`, some icons will have an extra space after them. This is meant to avoid
  # icon overlap when using non-monospace fonts. When set to `none`, spaces are not added.
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate

  # When set to true, icons appear before content on both sides of the prompt. When set
  # to false, icons go after content. If empty or not set, icons go before content in the left
  # prompt and after content in the right prompt.
  #
  # You can also override it for a specific segment:
  #
  #   POWERLEVEL9K_STATUS_ICON_BEFORE_CONTENT=false
  #
  # Or for a specific segment in specific state:
  #
  #   POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=false
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=

  # Add an empty line before each prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Connect left prompt lines with these symbols. You'll probably want to use the same color
  # as POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND below.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%244F╭─'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%244F├─'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%244F╰─'
  # Connect right prompt lines with these symbols.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%244F─╮'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%244F─┤'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%244F─╯'

  # Filler between left and right prompt on the first prompt line. You can set it to ' ', '·' or
  # '─'. The last two make it easier to see the alignment between left and right prompt and to
  # separate prompt from command output. You might want to set POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  # for more compact prompt if using using this option.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='─'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
  if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
    # The color of the filler. You'll probably want to match the color of POWERLEVEL9K_MULTILINE
    # ornaments defined above.
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=244
    # Start filler from the edge of the screen if there are no left segments on the first line.
    typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
    # End filler on the edge of the screen if there are no right segments on the first line.
    typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
  fi

  # Separator between same-color segments on the left.
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B5'
  # Separator between same-color segments on the right.
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B7'
  # Separator between different-color segments on the left.
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
  # Separator between different-color segments on the right.
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6'
  # The right end of left prompt.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
  # The left end of right prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
  # The left end of left prompt.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='░▒▓'
  # The right end of right prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='▓▒░'
  # Left prompt terminator for lines without any segments.
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  #################################[ os_icon: os identifier ]##################################
  # OS identifier color.
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=green
  # Custom icon.
  # typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=' Kali '

  ################################[ prompt_char: prompt symbol ]################################
  # Transparent background.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  # Green prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Prompt symbol in visual vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  # Prompt symbol in overwrite vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  # No line terminator if prompt_char is the last segment.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  # No line introducer if prompt_char is the first segment.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  # No surrounding whitespace.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  ##################################[ dir: current directory ]##################################
  # Current directory background color.
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=4
  # Default current directory foreground color.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
  # If directory is too long, shorten some of its segments to the shortest possible unique
  # prefix. The shortened directory can be tab-completed to the original.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  # Replace removed segment suffixes with this symbol.
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  # Color of the shortened directory segments.
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250
  # Color of the anchor directory segments. Anchor segments are never shortened. The first
  # segment is always an anchor.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255
  # Display anchor directory segments in bold.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  # Don't shorten directories that contain any of these files. They are anchors.
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
  # If set to "first" ("last"), remove everything before the first (last) subdirectory that contains
  # files matching $POWERLEVEL9K_SHORTEN_FOLDER_MARKER. For example, when the current directory is
  # /foo/bar/git_repo/nested_git_repo/baz, prompt will display git_repo/nested_git_repo/baz (first)
  # or nested_git_repo/baz (last). This assumes that git_repo and nested_git_repo contain markers
  # and other directories don't.
  #
  # Optionally, "first" and "last" can be followed by ":<offset>" where <offset> is an integer.
  # This moves the truncation point to the right (positive offset) or to the left (negative offset)
  # relative to the marker. Plain "first" and "last" are equivalent to "first:0" and "last:0"
  # respectively.
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
  # Don't shorten this many last directory segments. They are anchors.
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  # Shorten directory if it's longer than this even if there is space for it. The value can
  # be either absolute (e.g., '80') or a percentage of terminal width (e.g, '50%'). If empty,
  # directory will be shortened only when prompt doesn't fit or when other parameters demand it
  # (see POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS and POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT below).
  # If set to `0`, directory will always be shortened to its minimum length.
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  # When `dir` segment is on the last prompt line, try to shorten it enough to leave at least this
  # many columns for typing commands.
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  # When `dir` segment is on the last prompt line, try to shorten it enough to leave at least
  # COLUMNS * POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT * 0.01 columns for typing commands.
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  # If set to true, embed a hyperlink into the directory. Useful for quickly
  # opening a directory in the file manager simply by clicking the link.
  # Can also be handy when the directory is shortened, as it allows you to see
  # the full directory that was used in previous commands.
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false

  # Enable special styling for non-writable and non-existent directories. See POWERLEVEL9K_LOCK_ICON
  # and POWERLEVEL9K_DIR_CLASSES below.
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

  # The default icon shown next to non-writable and non-existent directories when
  # POWERLEVEL9K_DIR_SHOW_WRITABLE is set to v3.
  # typeset -g POWERLEVEL9K_LOCK_ICON='⭐'

  # POWERLEVEL9K_DIR_CLASSES allows you to specify custom icons and colors for different
  # directories. It must be an array with 3 * N elements. Each triplet consists of:
  #
  #   1. A pattern against which the current directory ($PWD) is matched. Matching is done with
  #      extended_glob option enabled.
  #   2. Directory class for the purpose of styling.
  #   3. An empty string.
  #
  # Triplets are tried in order. The first triplet whose pattern matches $PWD wins.
  #
  # If POWERLEVEL9K_DIR_SHOW_WRITABLE is set to v3, non-writable and non-existent directories
  # acquire class suffix _NOT_WRITABLE and NON_EXISTENT respectively.
  #
  # For example, given these settings:
  #
  #   typeset -g POWERLEVEL9K_DIR_CLASSES=(
  #     '~/work(|/*)'  WORK     ''
  #     '~(|/*)'       HOME     ''
  #     '*'            DEFAULT  '')
  #
  # Whenever the current directory is ~/work or a subdirectory of ~/work, it gets styled with one
  # of the following classes depending on its writability and existence: WORK, WORK_NOT_WRITABLE or
  # WORK_NON_EXISTENT.
  #
  # Simply assigning classes to directories doesn't have any visible effects. It merely gives you an
  # option to define custom colors and icons for different directory classes.
  #
  #   # Styling for WORK.
  #   typeset -g POWERLEVEL9K_DIR_WORK_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_DIR_WORK_BACKGROUND=4
  #   typeset -g POWERLEVEL9K_DIR_WORK_FOREGROUND=254
  #   typeset -g POWERLEVEL9K_DIR_WORK_SHORTENED_FOREGROUND=250
  #   typeset -g POWERLEVEL9K_DIR_WORK_ANCHOR_FOREGROUND=255
  #
  #   # Styling for WORK_NOT_WRITABLE.
  #   typeset -g POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_BACKGROUND=4
  #   typeset -g POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_FOREGROUND=254
  #   typeset -g POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_SHORTENED_FOREGROUND=250
  #   typeset -g POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_ANCHOR_FOREGROUND=255
  #
  #   # Styling for WORK_NON_EXISTENT.
  #   typeset -g POWERLEVEL9K_DIR_WORK_NON_EXISTENT_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_DIR_WORK_NON_EXISTENT_BACKGROUND=4
  #   typeset -g POWERLEVEL9K_DIR_WORK_NON_EXISTENT_FOREGROUND=254
  #   typeset -g POWERLEVEL9K_DIR_WORK_NON_EXISTENT_SHORTENED_FOREGROUND=250
  #   typeset -g POWERLEVEL9K_DIR_WORK_NON_EXISTENT_ANCHOR_FOREGROUND=255
  #
  # If a styling parameter isn't explicitly defined for some class, it falls back to the classless
  # parameter. For example, if POWERLEVEL9K_DIR_WORK_NOT_WRITABLE_FOREGROUND is not set, it falls
  # back to POWERLEVEL9K_DIR_FOREGROUND.
  #
  # typeset -g POWERLEVEL9K_DIR_CLASSES=()

  # Custom prefix.
  # typeset -g POWERLEVEL9K_DIR_PREFIX='in '

  #####################################[ vcs: git status ]######################################
  # Version control system colors.
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=3
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8

  # Branch icon. Set this parameter to '\uF126 ' for the popular Powerline branch icon.
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '

  # Untracked files icon. It's really a question mark, your font isn't broken.
  # Change the value of this parameter to show a different icon.
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

  # Formatter for Git status.
  #
  # Example output: master wip ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
  #
  # You can edit the function to customize how Git status looks.
  #
  # VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
  # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
  function my_git_formatter() {
    emulate -L zsh

    if [[ -n $P9K_CONTENT ]]; then
      # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
      # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    # Styling for different parts of Git status.
    local       meta='%7F' # white foreground
    local      clean='%0F' # black foreground
    local   modified='%0F' # black foreground
    local  untracked='%0F' # black foreground
    local conflicted='%1F' # red foreground

    local res

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
      # If local branch name is at most 32 characters long, show it in full.
      # Otherwise show the first 12 … the last 12.
      # Tip: To always show local branch name in full without truncation, delete the next line.
      (( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line
      res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
    fi

    if [[ -n $VCS_STATUS_TAG
          # Show tag only if not on a branch.
          # Tip: To always show tag, delete the next line.
          && -z $VCS_STATUS_LOCAL_BRANCH  # <-- this line
        ]]; then
      local tag=${(V)VCS_STATUS_TAG}
      # If tag name is at most 32 characters long, show it in full.
      # Otherwise show the first 12 … the last 12.
      # Tip: To always show tag name in full without truncation, delete the next line.
      (( $#tag > 32 )) && tag[13,-13]="…"  # <-- this line
      res+="${meta}#${clean}${tag//\%/%%}"
    fi

    # Display the current Git commit if there is no branch and no tag.
    # Tip: To always display the current Git commit, delete the next line.
    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&  # <-- this line
      res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

    # Show tracking branch name if it differs from local branch.
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
      res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
    fi

    # Display "wip" if the latest commit's summary contains "wip" or "WIP".
    if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
      res+=" ${modified}wip"
    fi

    # ⇣42 if behind the remote.
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    # ⇠42 if behind the push remote.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    # *42 if have stashes.
    (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
    # 'merge' if the repo is in an unusual state.
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    # ~42 if have merge conflicts.
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    # +42 if have staged changes.
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    # !42 if have unstaged changes.
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    # ?42 if have untracked files. It's really a question mark, your font isn't broken.
    # See POWERLEVEL9K_VCS_UNTRACKED_ICON above if you want to use a different icon.
    # Remove the next line if you don't want to see untracked files at all.
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    # "─" if the number of unstaged files is unknown. This can happen due to
    # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a non-negative number lower
    # than the number of files in the Git index, or due to bash.showDirtyState being set to false
    # in the repository config. The number of staged and untracked files may also be unknown
    # in this case.
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null

  # Don't count the number of unstaged, untracked and conflicted files in Git repositories with
  # more than this many files in the index. Negative value means infinity.
  #
  # If you are working in Git repositories with tens of millions of files and seeing performance
  # sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY to a number lower than the output
  # of `git ls-files | wc -l`. Alternatively, add `bash.showDirtyState = false` to the repository's
  # config: `git config bash.showDirtyState false`.
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

  # Don't show Git status in prompt for repositories whose workdir matches this pattern.
  # For example, if set to '~', the Git repository at $HOME/.git will be ignored.
  # Multiple patterns can be combined with '|': '~(|/foo)|/bar/baz/*'.
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

  # Disable the default Git status formatting.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Install our own Git status formatter.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  # Custom icon.
  # typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # Custom prefix.
  typeset -g POWERLEVEL9K_VCS_PREFIX='on '

  # Show status of repositories of these types. You can add svn and/or hg if you are
  # using them. If you do, your prompt may become slow even when your current directory
  # isn't in an svn or hg reposotiry.
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

  ##########################[ status: exit code of the last command ]###########################
  # Enable OK_PIPE, ERROR_PIPE and ERROR_SIGNAL status states to allow us to enable, disable and
  # style them independently from the regular OK and ERROR state.
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true

  # Status on success. No content, just an icon. No need to show it if prompt_char is enabled as
  # it will signify success by turning green.
  typeset -g POWERLEVEL9K_STATUS_OK=true
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
  typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0

  # Status when some part of a pipe command fails but the overall exit status is zero. It may look
  # like this: 1|0.
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0

  # Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as
  # it will signify error by turning red.
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=1

  # Status when the last command was terminated by a signal.
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  # Use terse signal names: "INT" instead of "SIGINT(2)".
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=1

  # Status when some part of a pipe command fails and the overall exit status is also non-zero.
  # It may look like this: 1|0.
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=3
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=1

  ###################[ command_execution_time: duration of the last command ]###################
  # Execution time color.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=66
  # Show duration of the last command if takes at least this many seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  # Show this many fractional digits. Zero means round to seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=4
  # Duration format: 1d 2h 3m 4s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  # Custom icon.
  # typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # Custom prefix.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='took '

  #######################[ background_jobs: presence of background jobs ]#######################
  # Background jobs color.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
  # Don't show the number of background jobs.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #######################[ direnv: direnv status (https://direnv.net/) ]########################
  # Direnv color.
  typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=3
  typeset -g POWERLEVEL9K_DIRENV_BACKGROUND=0
  # Custom icon.
  # typeset -g POWERLEVEL9K_DIRENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###############[ asdf: asdf version manager (https://github.com/asdf-vm/asdf) ]###############
  # Default asdf color. Only used to display tools for which there is no color override (see below).
  # Tip:  Override these parameters for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_FOREGROUND and
  # POWERLEVEL9K_ASDF_${TOOL}_BACKGROUND.
  typeset -g POWERLEVEL9K_ASDF_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_BACKGROUND=7

  # There are four parameters that can be used to hide asdf tools. Each parameter describes
  # conditions under which a tool gets hidden. Parameters can hide tools but not unhide them. If at
  # least one parameter decides to hide a tool, that tool gets hidden. If no parameter decides to
  # hide a tool, it gets shown.
  #
  # Special note on the difference between POWERLEVEL9K_ASDF_SOURCES and
  # POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW. Consider the effect of the following commands:
  #
  #   asdf local  python 3.8.1
  #   asdf global python 3.8.1
  #
  # After running both commands the current python version is 3.8.1 and its source is "local" as
  # it takes precedence over "global". If POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW is set to false,
  # it'll hide python version in this case because 3.8.1 is the same as the global version.
  # POWERLEVEL9K_ASDF_SOURCES will hide python version only if the value of this parameter doesn't
  # contain "local".

  # Hide tool versions that don't come from one of these sources.
  #
  # Available sources:
  #
  # - shell   `asdf current` says "set by ASDF_${TOOL}_VERSION environment variable"
  # - local   `asdf current` says "set by /some/not/home/directory/file"
  # - global  `asdf current` says "set by /home/username/file"
  #
  # Note: If this parameter is set to (shell local global), it won't hide tools.
  # Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SOURCES.
  typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)

  # If set to false, hide tool versions that are the same as global.
  #
  # Note: The name of this parameter doesn't reflect its meaning at all.
  # Note: If this parameter is set to true, it won't hide tools.
  # Tip:  Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_PROMPT_ALWAYS_SHOW.
  typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false

  # If set to false, hide tool versions that are equal to "system".
  #
  # Note: If this parameter is set to true, it won't hide tools.
  # Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_SYSTEM.
  typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true

  # If set to non-empty value, hide tools unless there is a file matching the specified file pattern
  # in the current directory, or its parent directory, or its grandparent directory, and so on.
  #
  # Note: If this parameter is set to empty value, it won't hide tools.
  # Note: SHOW_ON_UPGLOB isn't specific to asdf. It works with all prompt segments.
  # Tip: Override this parameter for ${TOOL} with POWERLEVEL9K_ASDF_${TOOL}_SHOW_ON_UPGLOB.
  #
  # Example: Hide nodejs version when there is no package.json and no *.js files in the current
  # directory, in `..`, in `../..` and so on.
  #
  #   typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.js|package.json'
  typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=

  # Ruby version from asdf.
  typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_RUBY_BACKGROUND=1
  # typeset -g POWERLEVEL9K_ASDF_RUBY_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_RUBY_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Python version from asdf.
  typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PYTHON_BACKGROUND=4
  # typeset -g POWERLEVEL9K_ASDF_PYTHON_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_PYTHON_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Go version from asdf.
  typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_GOLANG_BACKGROUND=4
  # typeset -g POWERLEVEL9K_ASDF_GOLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_GOLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Node.js version from asdf.
  typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_NODEJS_BACKGROUND=2
  # typeset -g POWERLEVEL9K_ASDF_NODEJS_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Rust version from asdf.
  typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_RUST_BACKGROUND=208
  # typeset -g POWERLEVEL9K_ASDF_RUST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_RUST_SHOW_ON_UPGLOB='*.foo|*.bar'

  # .NET Core version from asdf.
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_BACKGROUND=5
  # typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Flutter version from asdf.
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_BACKGROUND=4
  # typeset -g POWERLEVEL9K_ASDF_FLUTTER_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_FLUTTER_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Lua version from asdf.
  typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_LUA_BACKGROUND=4
  # typeset -g POWERLEVEL9K_ASDF_LUA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_LUA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Java version from asdf.
  typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=1
  typeset -g POWERLEVEL9K_ASDF_JAVA_BACKGROUND=7
  # typeset -g POWERLEVEL9K_ASDF_JAVA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_JAVA_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Perl version from asdf.
  typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PERL_BACKGROUND=4
  # typeset -g POWERLEVEL9K_ASDF_PERL_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_PERL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Erlang version from asdf.
  typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_ERLANG_BACKGROUND=1
  # typeset -g POWERLEVEL9K_ASDF_ERLANG_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_ERLANG_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Elixir version from asdf.
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_BACKGROUND=5
  # typeset -g POWERLEVEL9K_ASDF_ELIXIR_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_ELIXIR_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Postgres version from asdf.
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_BACKGROUND=6
  # typeset -g POWERLEVEL9K_ASDF_POSTGRES_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_POSTGRES_SHOW_ON_UPGLOB='*.foo|*.bar'

  # PHP version from asdf.
  typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_PHP_BACKGROUND=5
  # typeset -g POWERLEVEL9K_ASDF_PHP_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_PHP_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Haskell version from asdf.
  typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_HASKELL_BACKGROUND=3
  # typeset -g POWERLEVEL9K_ASDF_HASKELL_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_HASKELL_SHOW_ON_UPGLOB='*.foo|*.bar'

  # Julia version from asdf.
  typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ASDF_JULIA_BACKGROUND=2
  # typeset -g POWERLEVEL9K_ASDF_JULIA_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # typeset -g POWERLEVEL9K_ASDF_JULIA_SHOW_ON_UPGLOB='*.foo|*.bar'

  ##########[ nordvpn: nordvpn connection status, linux only (https://nordvpn.com/) ]###########
  # NordVPN connection indicator color.
  typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=7
  typeset -g POWERLEVEL9K_NORDVPN_BACKGROUND=4
  # Hide NordVPN connection indicator when not connected.
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=
  # Custom icon.
  # typeset -g POWERLEVEL9K_NORDVPN_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #################[ ranger: ranger shell (https://github.com/ranger/ranger) ]##################
  # Ranger shell color.
  typeset -g POWERLEVEL9K_RANGER_FOREGROUND=3
  typeset -g POWERLEVEL9K_RANGER_BACKGROUND=0
  # Custom icon.
  # typeset -g POWERLEVEL9K_RANGER_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ######################[ nnn: nnn shell (https://github.com/jarun/nnn) ]#######################
  # Nnn shell color.
  typeset -g POWERLEVEL9K_NNN_FOREGROUND=0
  typeset -g POWERLEVEL9K_NNN_BACKGROUND=6
  # Custom icon.
  # typeset -g POWERLEVEL9K_NNN_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##################[ xplr: xplr shell (https://github.com/sayanarijit/xplr) ]##################
  # xplr shell color.
  typeset -g POWERLEVEL9K_XPLR_FOREGROUND=0
  typeset -g POWERLEVEL9K_XPLR_BACKGROUND=6
  # Custom icon.
  # typeset -g POWERLEVEL9K_XPLR_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########################[ vim_shell: vim shell indicator (:sh) ]###########################
  # Vim shell indicator color.
  typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_VIM_SHELL_BACKGROUND=2
  # Custom icon.
  # typeset -g POWERLEVEL9K_VIM_SHELL_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ######[ midnight_commander: midnight commander shell (https://midnight-commander.org/) ]######
  # Midnight Commander shell color.
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=3
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_BACKGROUND=0
  # Custom icon.
  # typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #[ nix_shell: nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html) ]##
  # Nix shell color.
  typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_NIX_SHELL_BACKGROUND=4

  # Tip: If you want to see just the icon without "pure" and "impure", uncomment the next line.
  # typeset -g POWERLEVEL9K_NIX_SHELL_CONTENT_EXPANSION=

  # Custom icon.
  # typeset -g POWERLEVEL9K_NIX_SHELL_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##################################[ disk_usage: disk usage ]##################################
  # Colors for different levels of disk usage.
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=3
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND=0
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=0
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND=3
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=7
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND=1
  # Thresholds for different levels of disk usage (percentage points).
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=90
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=95
  # If set to true, hide disk usage when below $POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL percent.
  typeset -g POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_DISK_USAGE_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########[ vi_mode: vi mode (you don't need this if you've enabled prompt_char) ]###########
  # Foreground color.
  typeset -g POWERLEVEL9K_VI_MODE_FOREGROUND=0
  # Text and color for normal (a.k.a. command) vi mode.
  typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=2
  # Text and color for visual vi mode.
  typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=4
  # Text and color for overtype (a.k.a. overwrite and replace) vi mode.
  typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
  typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3
  # Text and color for insert vi mode.
  typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=8

  ######################################[ ram: free RAM ]#######################################
  # RAM color.
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=0
  typeset -g POWERLEVEL9K_RAM_BACKGROUND=9
  # Custom icon.
  # typeset -g POWERLEVEL9K_RAM_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #####################################[ swap: used swap ]######################################
  # Swap color.
  typeset -g POWERLEVEL9K_SWAP_FOREGROUND=0
  typeset -g POWERLEVEL9K_SWAP_BACKGROUND=3
  # Custom icon.
  # typeset -g POWERLEVEL9K_SWAP_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ######################################[ load: CPU load ]######################################
  # Show average CPU load over this many last minutes. Valid values are 1, 5 and 15.
  typeset -g POWERLEVEL9K_LOAD_WHICH=5
  # Load color when load is under 50%.
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_NORMAL_BACKGROUND=2
  # Load color when load is between 50% and 70%.
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_WARNING_BACKGROUND=3
  # Load color when load is over 70%.
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=0
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND=1
  # Custom icon.
  # typeset -g POWERLEVEL9K_LOAD_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ################[ todo: todo items (https://github.com/todotxt/todo.txt-cli) ]################
  # Todo color.
  typeset -g POWERLEVEL9K_TODO_FOREGROUND=0
  typeset -g POWERLEVEL9K_TODO_BACKGROUND=8
  # Hide todo when the total number of tasks is zero.
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=true
  # Hide todo when the number of tasks after filtering is zero.
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false

  # Todo format. The following parameters are available within the expansion.
  #
  # - P9K_TODO_TOTAL_TASK_COUNT     The total number of tasks.
  # - P9K_TODO_FILTERED_TASK_COUNT  The number of tasks after filtering.
  #
  # These variables correspond to the last line of the output of `todo.sh -p ls`:
  #
  #   TODO: 24 of 42 tasks shown
  #
  # Here 24 is P9K_TODO_FILTERED_TASK_COUNT and 42 is P9K_TODO_TOTAL_TASK_COUNT.
  #
  # typeset -g POWERLEVEL9K_TODO_CONTENT_EXPANSION='$P9K_TODO_FILTERED_TASK_COUNT'

  # Custom icon.
  # typeset -g POWERLEVEL9K_TODO_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########[ timewarrior: timewarrior tracking status (https://timewarrior.net/) ]############
  # Timewarrior color.
  typeset -g POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=255
  typeset -g POWERLEVEL9K_TIMEWARRIOR_BACKGROUND=8

  # If the tracked task is longer than 24 characters, truncate and append "…".
  # Tip: To always display tasks without truncation, delete the following parameter.
  # Tip: To hide task names and display just the icon when time tracking is enabled, set the
  # value of the following parameter to "".
  typeset -g POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'

  # Custom icon.
  # typeset -g POWERLEVEL9K_TIMEWARRIOR_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##############[ taskwarrior: taskwarrior task count (https://taskwarrior.org/) ]##############
  # Taskwarrior color.
  typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND=0
  typeset -g POWERLEVEL9K_TASKWARRIOR_BACKGROUND=6

  # Taskwarrior segment format. The following parameters are available within the expansion.
  #
  # - P9K_TASKWARRIOR_PENDING_COUNT   The number of pending tasks: `task +PENDING count`.
  # - P9K_TASKWARRIOR_OVERDUE_COUNT   The number of overdue tasks: `task +OVERDUE count`.
  #
  # Zero values are represented as empty parameters.
  #
  # The default format:
  #
  #   '${P9K_TASKWARRIOR_OVERDUE_COUNT:+"!$P9K_TASKWARRIOR_OVERDUE_COUNT/"}$P9K_TASKWARRIOR_PENDING_COUNT'
  #
  # typeset -g POWERLEVEL9K_TASKWARRIOR_CONTENT_EXPANSION='$P9K_TASKWARRIOR_PENDING_COUNT'

  # Custom icon.
  # typeset -g POWERLEVEL9K_TASKWARRIOR_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##################################[ context: user@hostname ]##################################
  # Context color when running with privileges.
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0
  # Context color in SSH without privileges.
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=3
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_BACKGROUND=0
  # Default context color (no privileges, no SSH).
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=3
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0

  # Context format when running with privileges: user@hostname.
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%n@%m'
  # Context format when in SSH without privileges: user@hostname.
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
  # Default context format (no privileges, no SSH): user@hostname.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'

  # Don't show context unless running with privileges or in SSH.
  # Tip: Remove the next line to always show context.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

  # Custom icon.
  # typeset -g POWERLEVEL9K_CONTEXT_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # Custom prefix.
  typeset -g POWERLEVEL9K_CONTEXT_PREFIX='with '

  ###[ virtualenv: python virtual environment (https://docs.python.org/3/library/venv.html) ]###
  # Python virtual environment color.
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=4
  # Don't show Python version next to the virtual environment name.
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  # If set to "false", won't show virtualenv if pyenv is already shown.
  # If set to "if-different", won't show virtualenv if it's the same as pyenv.
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
  # Separate environment name from Python version only with a space.
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=
  # Custom icon.
  # typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #####################[ anaconda: conda environment (https://conda.io/) ]######################
  # Anaconda environment color.
  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=0
  typeset -g POWERLEVEL9K_ANACONDA_BACKGROUND=4

  # Anaconda segment format. The following parameters are available within the expansion.
  #
  # - CONDA_PREFIX                 Absolute path to the active Anaconda/Miniconda environment.
  # - CONDA_DEFAULT_ENV            Name of the active Anaconda/Miniconda environment.
  # - CONDA_PROMPT_MODIFIER        Configurable prompt modifier (see below).
  # - P9K_ANACONDA_PYTHON_VERSION  Current python version (python --version).
  #
  # CONDA_PROMPT_MODIFIER can be configured with the following command:
  #
  #   conda config --set env_prompt '({default_env}) '
  #
  # The last argument is a Python format string that can use the following variables:
  #
  # - prefix       The same as CONDA_PREFIX.
  # - default_env  The same as CONDA_DEFAULT_ENV.
  # - name         The last segment of CONDA_PREFIX.
  # - stacked_env  Comma-separated list of names in the environment stack. The first element is
  #                always the same as default_env.
  #
  # Note: '({default_env}) ' is the default value of env_prompt.
  #
  # The default value of POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION expands to $CONDA_PROMPT_MODIFIER
  # without the surrounding parentheses, or to the last path component of CONDA_PREFIX if the former
  # is empty.
  typeset -g POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'

  # Custom icon.
  # typeset -g POWERLEVEL9K_ANACONDA_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ################[ pyenv: python environment (https://github.com/pyenv/pyenv) ]################
  # Pyenv color.
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PYENV_BACKGROUND=4
  # Hide python version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  # If set to false, hide python version if it's the same as global:
  # $(pyenv version-name) == $(pyenv global).
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide python version if it's equal to "system".
  typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true

  # Pyenv segment format. The following parameters are available within the expansion.
  #
  # - P9K_CONTENT                Current pyenv environment (pyenv version-name).
  # - P9K_PYENV_PYTHON_VERSION   Current python version (python --version).
  #
  # The default format has the following logic:
  #
  # 1. Display just "$P9K_CONTENT" if it's equal to "$P9K_PYENV_PYTHON_VERSION" or
  #    starts with "$P9K_PYENV_PYTHON_VERSION/".
  # 2. Otherwise display "$P9K_CONTENT $P9K_PYENV_PYTHON_VERSION".
  typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT}${${P9K_CONTENT:#$P9K_PYENV_PYTHON_VERSION(|/*)}:+ $P9K_PYENV_PYTHON_VERSION}'

  # Custom icon.
  # typeset -g POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ################[ goenv: go environment (https://github.com/syndbg/goenv) ]################
  # Goenv color.
  typeset -g POWERLEVEL9K_GOENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_GOENV_BACKGROUND=4
  # Hide go version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_GOENV_SOURCES=(shell local global)
  # If set to false, hide go version if it's the same as global:
  # $(goenv version-name) == $(goenv global).
  typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide go version if it's equal to "system".
  typeset -g POWERLEVEL9K_GOENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_GOENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ nodenv: node.js version from nodenv (https://github.com/nodenv/nodenv) ]##########
  # Nodenv color.
  typeset -g POWERLEVEL9K_NODENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_NODENV_BACKGROUND=0
  # Hide node version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_NODENV_SOURCES=(shell local global)
  # If set to false, hide node version if it's the same as global:
  # $(nodenv version-name) == $(nodenv global).
  typeset -g POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide node version if it's equal to "system".
  typeset -g POWERLEVEL9K_NODENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_NODENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##############[ nvm: node.js version from nvm (https://github.com/nvm-sh/nvm) ]###############
  # Nvm color.
  typeset -g POWERLEVEL9K_NVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_NVM_BACKGROUND=5
  # Custom icon.
  # typeset -g POWERLEVEL9K_NVM_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ############[ nodeenv: node.js environment (https://github.com/ekalinin/nodeenv) ]############
  # Nodeenv color.
  typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_NODEENV_BACKGROUND=0
  # Don't show Node version next to the environment name.
  typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false
  # Separate environment name from Node version only with a space.
  typeset -g POWERLEVEL9K_NODEENV_{LEFT,RIGHT}_DELIMITER=
  # Custom icon.
  # typeset -g POWERLEVEL9K_NODEENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##############################[ node_version: node.js version ]###############################
  # Node version color.
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=7
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=2
  # Show node version only when in a directory tree containing package.json.
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_NODE_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #######################[ go_version: go version (https://golang.org) ]########################
  # Go version color.
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=255
  typeset -g POWERLEVEL9K_GO_VERSION_BACKGROUND=2
  # Show go version only when in a go project subdirectory.
  typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_GO_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #################[ rust_version: rustc version (https://www.rust-lang.org) ]##################
  # Rust version color.
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=0
  typeset -g POWERLEVEL9K_RUST_VERSION_BACKGROUND=208
  # Show rust version only when in a rust project subdirectory.
  typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_RUST_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###############[ dotnet_version: .NET version (https://dotnet.microsoft.com) ]################
  # .NET version color.
  typeset -g POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=7
  typeset -g POWERLEVEL9K_DOTNET_VERSION_BACKGROUND=5
  # Show .NET version only when in a .NET project subdirectory.
  typeset -g POWERLEVEL9K_DOTNET_VERSION_PROJECT_ONLY=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_DOTNET_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #####################[ php_version: php version (https://www.php.net/) ]######################
  # PHP version color.
  typeset -g POWERLEVEL9K_PHP_VERSION_FOREGROUND=0
  typeset -g POWERLEVEL9K_PHP_VERSION_BACKGROUND=5
  # Show PHP version only when in a PHP project subdirectory.
  typeset -g POWERLEVEL9K_PHP_VERSION_PROJECT_ONLY=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_PHP_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ laravel_version: laravel php framework version (https://laravel.com/) ]###########
  # Laravel version color.
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND=1
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_BACKGROUND=7
  # Custom icon.
  # typeset -g POWERLEVEL9K_LARAVEL_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #############[ rbenv: ruby version from rbenv (https://github.com/rbenv/rbenv) ]##############
  # Rbenv color.
  typeset -g POWERLEVEL9K_RBENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_RBENV_BACKGROUND=1
  # Hide ruby version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
  # If set to false, hide ruby version if it's the same as global:
  # $(rbenv version-name) == $(rbenv global).
  typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide ruby version if it's equal to "system".
  typeset -g POWERLEVEL9K_RBENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ####################[ java_version: java version (https://www.java.com/) ]####################
  # Java version color.
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=1
  typeset -g POWERLEVEL9K_JAVA_VERSION_BACKGROUND=7
  # Show java version only when in a java project subdirectory.
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true
  # Show brief version.
  typeset -g POWERLEVEL9K_JAVA_VERSION_FULL=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_JAVA_VERSION_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###[ package: name@version from package.json (https://docs.npmjs.com/files/package.json) ]####
  # Package color.
  typeset -g POWERLEVEL9K_PACKAGE_FOREGROUND=0
  typeset -g POWERLEVEL9K_PACKAGE_BACKGROUND=6

  # Package format. The following parameters are available within the expansion.
  #
  # - P9K_PACKAGE_NAME     The value of `name` field in package.json.
  # - P9K_PACKAGE_VERSION  The value of `version` field in package.json.
  #
  # typeset -g POWERLEVEL9K_PACKAGE_CONTENT_EXPANSION='${P9K_PACKAGE_NAME//\%/%%}@${P9K_PACKAGE_VERSION//\%/%%}'

  # Custom icon.
  # typeset -g POWERLEVEL9K_PACKAGE_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #######################[ rvm: ruby version from rvm (https://rvm.io) ]########################
  # Rvm color.
  typeset -g POWERLEVEL9K_RVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_RVM_BACKGROUND=240
  # Don't show @gemset at the end.
  typeset -g POWERLEVEL9K_RVM_SHOW_GEMSET=false
  # Don't show ruby- at the front.
  typeset -g POWERLEVEL9K_RVM_SHOW_PREFIX=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########[ fvm: flutter version management (https://github.com/leoafarias/fvm) ]############
  # Fvm color.
  typeset -g POWERLEVEL9K_FVM_FOREGROUND=0
  typeset -g POWERLEVEL9K_FVM_BACKGROUND=4
  # Custom icon.
  # typeset -g POWERLEVEL9K_FVM_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ luaenv: lua version from luaenv (https://github.com/cehoffman/luaenv) ]###########
  # Lua color.
  typeset -g POWERLEVEL9K_LUAENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_LUAENV_BACKGROUND=4
  # Hide lua version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_LUAENV_SOURCES=(shell local global)
  # If set to false, hide lua version if it's the same as global:
  # $(luaenv version-name) == $(luaenv global).
  typeset -g POWERLEVEL9K_LUAENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide lua version if it's equal to "system".
  typeset -g POWERLEVEL9K_LUAENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_LUAENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###############[ jenv: java version from jenv (https://github.com/jenv/jenv) ]################
  # Java color.
  typeset -g POWERLEVEL9K_JENV_FOREGROUND=1
  typeset -g POWERLEVEL9K_JENV_BACKGROUND=7
  # Hide java version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_JENV_SOURCES=(shell local global)
  # If set to false, hide java version if it's the same as global:
  # $(jenv version-name) == $(jenv global).
  typeset -g POWERLEVEL9K_JENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide java version if it's equal to "system".
  typeset -g POWERLEVEL9K_JENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_JENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########[ plenv: perl version from plenv (https://github.com/tokuhirom/plenv) ]############
  # Perl color.
  typeset -g POWERLEVEL9K_PLENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PLENV_BACKGROUND=4
  # Hide perl version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_PLENV_SOURCES=(shell local global)
  # If set to false, hide perl version if it's the same as global:
  # $(plenv version-name) == $(plenv global).
  typeset -g POWERLEVEL9K_PLENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide perl version if it's equal to "system".
  typeset -g POWERLEVEL9K_PLENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_PLENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ############[ phpenv: php version from phpenv (https://github.com/phpenv/phpenv) ]############
  # PHP color.
  typeset -g POWERLEVEL9K_PHPENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_PHPENV_BACKGROUND=5
  # Hide php version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_PHPENV_SOURCES=(shell local global)
  # If set to false, hide php version if it's the same as global:
  # $(phpenv version-name) == $(phpenv global).
  typeset -g POWERLEVEL9K_PHPENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide PHP version if it's equal to "system".
  typeset -g POWERLEVEL9K_PHPENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_PHPENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #######[ scalaenv: scala version from scalaenv (https://github.com/scalaenv/scalaenv) ]#######
  # Scala color.
  typeset -g POWERLEVEL9K_SCALAENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_SCALAENV_BACKGROUND=1
  # Hide scala version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_SCALAENV_SOURCES=(shell local global)
  # If set to false, hide scala version if it's the same as global:
  # $(scalaenv version-name) == $(scalaenv global).
  typeset -g POWERLEVEL9K_SCALAENV_PROMPT_ALWAYS_SHOW=false
  # If set to false, hide scala version if it's equal to "system".
  typeset -g POWERLEVEL9K_SCALAENV_SHOW_SYSTEM=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_SCALAENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ haskell_stack: haskell version from stack (https://haskellstack.org/) ]###########
  # Haskell color.
  typeset -g POWERLEVEL9K_HASKELL_STACK_FOREGROUND=0
  typeset -g POWERLEVEL9K_HASKELL_STACK_BACKGROUND=3

  # Hide haskell version if it doesn't come from one of these sources.
  #
  #   shell:  version is set by STACK_YAML
  #   local:  version is set by stack.yaml up the directory tree
  #   global: version is set by the implicit global project (~/.stack/global-project/stack.yaml)
  typeset -g POWERLEVEL9K_HASKELL_STACK_SOURCES=(shell local)
  # If set to false, hide haskell version if it's the same as in the implicit global project.
  typeset -g POWERLEVEL9K_HASKELL_STACK_ALWAYS_SHOW=true
  # Custom icon.
  # typeset -g POWERLEVEL9K_HASKELL_STACK_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ################[ terraform: terraform workspace (https://www.terraform.io) ]#################
  # Don't show terraform workspace if it's literally "default".
  typeset -g POWERLEVEL9K_TERRAFORM_SHOW_DEFAULT=false
  # POWERLEVEL9K_TERRAFORM_CLASSES is an array with even number of elements. The first element
  # in each pair defines a pattern against which the current terraform workspace gets matched.
  # More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
  # that gets matched. If you unset all POWERLEVEL9K_TERRAFORM_*CONTENT_EXPANSION parameters,
  # you'll see this value in your prompt. The second element of each pair in
  # POWERLEVEL9K_TERRAFORM_CLASSES defines the workspace class. Patterns are tried in order. The
  # first match wins.
  #
  # For example, given these settings:
  #
  #   typeset -g POWERLEVEL9K_TERRAFORM_CLASSES=(
  #     '*prod*'  PROD
  #     '*test*'  TEST
  #     '*'       OTHER)
  #
  # If your current terraform workspace is "project_test", its class is TEST because "project_test"
  # doesn't match the pattern '*prod*' but does match '*test*'.
  #
  # You can define different colors, icons and content expansions for different classes:
  #
  #   typeset -g POWERLEVEL9K_TERRAFORM_TEST_FOREGROUND=2
  #   typeset -g POWERLEVEL9K_TERRAFORM_TEST_BACKGROUND=0
  #   typeset -g POWERLEVEL9K_TERRAFORM_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_TERRAFORM_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
  typeset -g POWERLEVEL9K_TERRAFORM_CLASSES=(
      # '*prod*'  PROD    # These values are examples that are unlikely
      # '*test*'  TEST    # to match your needs. Customize them as needed.
      '*'         OTHER)
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=4
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_BACKGROUND=0
  # typeset -g POWERLEVEL9K_TERRAFORM_OTHER_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  # Show kubecontext only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show kubecontext.
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'

  # Kubernetes context classes for the purpose of using different colors, icons and expansions with
  # different contexts.
  #
  # POWERLEVEL9K_KUBECONTEXT_CLASSES is an array with even number of elements. The first element
  # in each pair defines a pattern against which the current kubernetes context gets matched.
  # More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
  # that gets matched. If you unset all POWERLEVEL9K_KUBECONTEXT_*CONTENT_EXPANSION parameters,
  # you'll see this value in your prompt. The second element of each pair in
  # POWERLEVEL9K_KUBECONTEXT_CLASSES defines the context class. Patterns are tried in order. The
  # first match wins.
  #
  # For example, given these settings:
  #
  #   typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
  #     '*prod*'  PROD
  #     '*test*'  TEST
  #     '*'       DEFAULT)
  #
  # If your current kubernetes context is "deathray-testing/default", its class is TEST
  # because "deathray-testing/default" doesn't match the pattern '*prod*' but does match '*test*'.
  #
  # You can define different colors, icons and content expansions for different classes:
  #
  #   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_FOREGROUND=0
  #   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_BACKGROUND=2
  #   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      # '*prod*'  PROD    # These values are examples that are unlikely
      # '*test*'  TEST    # to match your needs. Customize them as needed.
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=5
  # typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # Use POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION to specify the content displayed by kubecontext
  # segment. Parameter expansions are very flexible and fast, too. See reference:
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion.
  #
  # Within the expansion the following parameters are always available:
  #
  # - P9K_CONTENT                The content that would've been displayed if there was no content
  #                              expansion defined.
  # - P9K_KUBECONTEXT_NAME       The current context's name. Corresponds to column NAME in the
  #                              output of `kubectl config get-contexts`.
  # - P9K_KUBECONTEXT_CLUSTER    The current context's cluster. Corresponds to column CLUSTER in the
  #                              output of `kubectl config get-contexts`.
  # - P9K_KUBECONTEXT_NAMESPACE  The current context's namespace. Corresponds to column NAMESPACE
  #                              in the output of `kubectl config get-contexts`. If there is no
  #                              namespace, the parameter is set to "default".
  # - P9K_KUBECONTEXT_USER       The current context's user. Corresponds to column AUTHINFO in the
  #                              output of `kubectl config get-contexts`.
  #
  # If the context points to Google Kubernetes Engine (GKE) or Elastic Kubernetes Service (EKS),
  # the following extra parameters are available:
  #
  # - P9K_KUBECONTEXT_CLOUD_NAME     Either "gke" or "eks".
  # - P9K_KUBECONTEXT_CLOUD_ACCOUNT  Account/project ID.
  # - P9K_KUBECONTEXT_CLOUD_ZONE     Availability zone.
  # - P9K_KUBECONTEXT_CLOUD_CLUSTER  Cluster.
  #
  # P9K_KUBECONTEXT_CLOUD_* parameters are derived from P9K_KUBECONTEXT_CLUSTER. For example,
  # if P9K_KUBECONTEXT_CLUSTER is "gke_my-account_us-east1-a_my-cluster-01":
  #
  #   - P9K_KUBECONTEXT_CLOUD_NAME=gke
  #   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=my-account
  #   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east1-a
  #   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
  #
  # If P9K_KUBECONTEXT_CLUSTER is "arn:aws:eks:us-east-1:123456789012:cluster/my-cluster-01":
  #
  #   - P9K_KUBECONTEXT_CLOUD_NAME=eks
  #   - P9K_KUBECONTEXT_CLOUD_ACCOUNT=123456789012
  #   - P9K_KUBECONTEXT_CLOUD_ZONE=us-east-1
  #   - P9K_KUBECONTEXT_CLOUD_CLUSTER=my-cluster-01
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  # Show P9K_KUBECONTEXT_CLOUD_CLUSTER if it's not empty and fall back to P9K_KUBECONTEXT_NAME.
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  # Append the current context's namespace if it's not "default".
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

  # Custom prefix.
  typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='at '

  #[ aws: aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) ]#
  # Show aws only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show aws.
  typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'

  # POWERLEVEL9K_AWS_CLASSES is an array with even number of elements. The first element
  # in each pair defines a pattern against which the current AWS profile gets matched.
  # More specifically, it's P9K_CONTENT prior to the application of context expansion (see below)
  # that gets matched. If you unset all POWERLEVEL9K_AWS_*CONTENT_EXPANSION parameters,
  # you'll see this value in your prompt. The second element of each pair in
  # POWERLEVEL9K_AWS_CLASSES defines the profile class. Patterns are tried in order. The
  # first match wins.
  #
  # For example, given these settings:
  #
  #   typeset -g POWERLEVEL9K_AWS_CLASSES=(
  #     '*prod*'  PROD
  #     '*test*'  TEST
  #     '*'       DEFAULT)
  #
  # If your current AWS profile is "company_test", its class is TEST
  # because "company_test" doesn't match the pattern '*prod*' but does match '*test*'.
  #
  # You can define different colors, icons and content expansions for different classes:
  #
  #   typeset -g POWERLEVEL9K_AWS_TEST_FOREGROUND=28
  #   typeset -g POWERLEVEL9K_AWS_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_AWS_TEST_CONTENT_EXPANSION='> ${P9K_CONTENT} <'
  typeset -g POWERLEVEL9K_AWS_CLASSES=(
      # '*prod*'  PROD    # These values are examples that are unlikely
      # '*test*'  TEST    # to match your needs. Customize them as needed.
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=1
  # typeset -g POWERLEVEL9K_AWS_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # AWS segment format. The following parameters are available within the expansion.
  #
  # - P9K_AWS_PROFILE  The name of the current AWS profile.
  # - P9K_AWS_REGION   The region associated with the current AWS profile.
  typeset -g POWERLEVEL9K_AWS_CONTENT_EXPANSION='${P9K_AWS_PROFILE//\%/%%}${P9K_AWS_REGION:+ ${P9K_AWS_REGION//\%/%%}}'

  #[ aws_eb_env: aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/) ]#
  # AWS Elastic Beanstalk environment color.
  typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=2
  typeset -g POWERLEVEL9K_AWS_EB_ENV_BACKGROUND=0
  # Custom icon.
  # typeset -g POWERLEVEL9K_AWS_EB_ENV_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ azure: azure account name (https://docs.microsoft.com/en-us/cli/azure) ]##########
  # Show azure only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show azure.
  typeset -g POWERLEVEL9K_AZURE_SHOW_ON_COMMAND='az|terraform|pulumi|terragrunt'
  # Azure account name color.
  typeset -g POWERLEVEL9K_AZURE_FOREGROUND=7
  typeset -g POWERLEVEL9K_AZURE_BACKGROUND=4
  # Custom icon.
  # typeset -g POWERLEVEL9K_AZURE_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ##########[ gcloud: google cloud account and project (https://cloud.google.com/) ]###########
  # Show gcloud only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show gcloud.
  typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs'
  # Google cloud color.
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=7
  typeset -g POWERLEVEL9K_GCLOUD_BACKGROUND=4

  # Google cloud format. Change the value of POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION and/or
  # POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION if the default is too verbose or not informative
  # enough. You can use the following parameters in the expansions. Each of them corresponds to the
  # output of `gcloud` tool.
  #
  #   Parameter                | Source
  #   -------------------------|--------------------------------------------------------------------
  #   P9K_GCLOUD_CONFIGURATION | gcloud config configurations list --format='value(name)'
  #   P9K_GCLOUD_ACCOUNT       | gcloud config get-value account
  #   P9K_GCLOUD_PROJECT_ID    | gcloud config get-value project
  #   P9K_GCLOUD_PROJECT_NAME  | gcloud projects describe $P9K_GCLOUD_PROJECT_ID --format='value(name)'
  #
  # Note: ${VARIABLE//\%/%%} expands to ${VARIABLE} with all occurrences of '%' replaced with '%%'.
  #
  # Obtaining project name requires sending a request to Google servers. This can take a long time
  # and even fail. When project name is unknown, P9K_GCLOUD_PROJECT_NAME is not set and gcloud
  # prompt segment is in state PARTIAL. When project name gets known, P9K_GCLOUD_PROJECT_NAME gets
  # set and gcloud prompt segment transitions to state COMPLETE.
  #
  # You can customize the format, icon and colors of gcloud segment separately for states PARTIAL
  # and COMPLETE. You can also hide gcloud in state PARTIAL by setting
  # POWERLEVEL9K_GCLOUD_PARTIAL_VISUAL_IDENTIFIER_EXPANSION and
  # POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION to empty.
  typeset -g POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_ID//\%/%%}'
  typeset -g POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_NAME//\%/%%}'

  # Send a request to Google (by means of `gcloud projects describe ...`) to obtain project name
  # this often. Negative value disables periodic polling. In this mode project name is retrieved
  # only when the current configuration, account or project id changes.
  typeset -g POWERLEVEL9K_GCLOUD_REFRESH_PROJECT_NAME_SECONDS=60

  # Custom icon.
  # typeset -g POWERLEVEL9K_GCLOUD_VISUAL_IDENTIFIER_EXPANSION='⭐'

  #[ google_app_cred: google application credentials (https://cloud.google.com/docs/authentication/production) ]#
  # Show google_app_cred only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show google_app_cred.
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform|pulumi|terragrunt'

  # Google application credentials classes for the purpose of using different colors, icons and
  # expansions with different credentials.
  #
  # POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES is an array with even number of elements. The first
  # element in each pair defines a pattern against which the current kubernetes context gets
  # matched. More specifically, it's P9K_CONTENT prior to the application of context expansion
  # (see below) that gets matched. If you unset all POWERLEVEL9K_GOOGLE_APP_CRED_*CONTENT_EXPANSION
  # parameters, you'll see this value in your prompt. The second element of each pair in
  # POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES defines the context class. Patterns are tried in order.
  # The first match wins.
  #
  # For example, given these settings:
  #
  #   typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=(
  #     '*:*prod*:*'  PROD
  #     '*:*test*:*'  TEST
  #     '*'           DEFAULT)
  #
  # If your current Google application credentials is "service_account deathray-testing x@y.com",
  # its class is TEST because it doesn't match the pattern '* *prod* *' but does match '* *test* *'.
  #
  # You can define different colors, icons and content expansions for different classes:
  #
  #   typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_TEST_FOREGROUND=28
  #   typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_TEST_VISUAL_IDENTIFIER_EXPANSION='⭐'
  #   typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_TEST_CONTENT_EXPANSION='$P9K_GOOGLE_APP_CRED_PROJECT_ID'
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=(
      # '*:*prod*:*'  PROD    # These values are examples that are unlikely
      # '*:*test*:*'  TEST    # to match your needs. Customize them as needed.
      '*'             DEFAULT)
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=7
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_BACKGROUND=4
  # typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # Use POWERLEVEL9K_GOOGLE_APP_CRED_CONTENT_EXPANSION to specify the content displayed by
  # google_app_cred segment. Parameter expansions are very flexible and fast, too. See reference:
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion.
  #
  # You can use the following parameters in the expansion. Each of them corresponds to one of the
  # fields in the JSON file pointed to by GOOGLE_APPLICATION_CREDENTIALS.
  #
  #   Parameter                        | JSON key file field
  #   ---------------------------------+---------------
  #   P9K_GOOGLE_APP_CRED_TYPE         | type
  #   P9K_GOOGLE_APP_CRED_PROJECT_ID   | project_id
  #   P9K_GOOGLE_APP_CRED_CLIENT_EMAIL | client_email
  #
  # Note: ${VARIABLE//\%/%%} expands to ${VARIABLE} with all occurrences of '%' replaced by '%%'.
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_CONTENT_EXPANSION='${P9K_GOOGLE_APP_CRED_PROJECT_ID//\%/%%}'

  ###############################[ public_ip: public IP address ]###############################
  # Public IP color.
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=0
  typeset -g POWERLEVEL9K_PUBLIC_IP_BACKGROUND=5
  # Custom icon.
  # typeset -g POWERLEVEL9K_PUBLIC_IP_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ########################[ vpn_ip: virtual private network indicator ]#########################
  # VPN IP color.
  typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=0
  typeset -g POWERLEVEL9K_VPN_IP_BACKGROUND=6
  # When on VPN, show just an icon without the IP address.
  # Tip: To display the private IP address when on VPN, remove the next line.
  typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=
  # Regular expression for the VPN network interface. Run `ifconfig` or `ip -4 a show` while on VPN
  # to see the name of the interface.
  typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(gpd|wg|(.*tun)|tailscale)[0-9]*'
  # If set to true, show one segment per matching network interface. If set to false, show only
  # one segment corresponding to the first matching network interface.
  # Tip: If you set it to true, you'll probably want to unset POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION.
  typeset -g POWERLEVEL9K_VPN_IP_SHOW_ALL=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_VPN_IP_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ###########[ ip: ip address and bandwidth usage for a specified network interface ]###########
  # IP color.
  typeset -g POWERLEVEL9K_IP_BACKGROUND=4
  typeset -g POWERLEVEL9K_IP_FOREGROUND=0
  # The following paeters are accessible within the expansion:
  #
  #   Parameter             | Meaning
  #   ----------------------+-------------------------------------------
  #   P9K_IP_IP             | IP address
  #   P9K_IP_INTERFACE      | network interface
  #   P9K_IP_RX_BYTES       | total number of bytes received
  #   P9K_IP_TX_BYTES       | total number of bytes sent
  #   P9K_IP_RX_BYTES_DELTA | number of bytes received since last prompt
  #   P9K_IP_TX_BYTES_DELTA | number of bytes sent since last prompt
  #   P9K_IP_RX_RATE        | receive rate (since last prompt)
  #   P9K_IP_TX_RATE        | send rate (since last prompt)
  #typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='${P9K_IP_RX_RATE:+⇣$P9K_IP_RX_RATE }${P9K_IP_TX_RATE:+⇡$P9K_IP_TX_RATE }$P9K_IP_IP'

  typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='$P9K_IP_IP'

  # Show information for the first network interface whose name matches this regular expression.
  # Run `ifconfig` or `ip -4 a show` to see the names of all network interfaces.
  typeset -g POWERLEVEL9K_IP_INTERFACE='[ew].*'
  # Custom icon.
  # typeset -g POWERLEVEL9K_IP_VISUAL_IDENTIFIER_EXPANSION='⭐'
  typeset -g POWERLEVEL9K_IP_VISUAL_IDENTIFIER_EXPANSION='󰀑 '


  #########################[ proxy: system-wide http/https/ftp proxy ]##########################
  # Proxy color.
  typeset -g POWERLEVEL9K_PROXY_FOREGROUND=4
  typeset -g POWERLEVEL9K_PROXY_BACKGROUND=0
  # Custom icon.
  # typeset -g POWERLEVEL9K_PROXY_VISUAL_IDENTIFIER_EXPANSION='⭐'

  ################################[ battery: internal battery ]#################################
  # Show battery in red when it's below this level and not connected to power supply.
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1
  # Show battery in green when it's charging or fully charged.
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=2
  # Show battery in yellow when it's discharging.
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=7
  # Battery pictograms going from low to high level of charge.
  typeset -g POWERLEVEL9K_BATTERY_STAGES='\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  # Don't show the remaining time to charge/discharge.
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=true
  typeset -g POWERLEVEL9K_BATTERY_BACKGROUND=55

  #####################################[ wifi: wifi speed ]#####################################
  # WiFi color.
  typeset -g POWERLEVEL9K_WIFI_FOREGROUND=0
  typeset -g POWERLEVEL9K_WIFI_BACKGROUND=4
  # Custom icon.
  # typeset -g POWERLEVEL9K_WIFI_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # Use different colors and icons depending on signal strength ($P9K_WIFI_BARS).
  #
  #   # Wifi colors and icons for different signal strength levels (low to high).
  #   typeset -g my_wifi_fg=(0 0 0 0 0)                                # <-- change these values
  #   typeset -g my_wifi_icon=('WiFi' 'WiFi' 'WiFi' 'WiFi' 'WiFi')     # <-- change these values
  #
  #   typeset -g POWERLEVEL9K_WIFI_CONTENT_EXPANSION='%F{${my_wifi_fg[P9K_WIFI_BARS+1]}}$P9K_WIFI_LAST_TX_RATE Mbps'
  #   typeset -g POWERLEVEL9K_WIFI_VISUAL_IDENTIFIER_EXPANSION='%F{${my_wifi_fg[P9K_WIFI_BARS+1]}}${my_wifi_icon[P9K_WIFI_BARS+1]}'
  #
  # The following parameters are accessible within the expansions:
  #
  #   Parameter             | Meaning
  #   ----------------------+---------------
  #   P9K_WIFI_SSID         | service set identifier, a.k.a. network name
  #   P9K_WIFI_LINK_AUTH    | authentication protocol such as "wpa2-psk" or "none"; empty if unknown
  #   P9K_WIFI_LAST_TX_RATE | wireless transmit rate in megabits per second
  #   P9K_WIFI_RSSI         | signal strength in dBm, from -120 to 0
  #   P9K_WIFI_NOISE        | noise in dBm, from -120 to 0
  #   P9K_WIFI_BARS         | signal strength in bars, from 0 to 4 (derived from P9K_WIFI_RSSI and P9K_WIFI_NOISE)

  ####################################[ time: current time ]####################################
  # Current time color.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=7
  # Format for the current time: 09:51:02. See `man 3 strftime`.
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  # If set to true, time will update when you hit enter. This way prompts for the past
  # commands will contain the start times of their commands as opposed to the default
  # behavior where they contain the end times of their preceding commands.
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
  # Custom icon.
  # typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION='⭐'
  # Custom prefix.
  typeset -g POWERLEVEL9K_TIME_PREFIX='at '

  # Example of a user-defined prompt segment. Function prompt_example will be called on every
  # prompt if `example` prompt segment is added to POWERLEVEL9K_LEFT_PROMPT_ELEMENTS or
  # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS. It displays an icon and yellow text on red background
  # greeting the user.
  #
  # Type `p10k help segment` for documentation and a more sophisticated example.
  #function prompt_example() {
  #  p10k segment -b 1 -f 3 -i '⭐' -t 'hello, %n'
  #}
  function prompt_example() {
    p10k segment -b 1 -f 3 -i '' -t 'Rex Ackermann'
  }

  # User-defined prompt segments may optionally provide an instant_prompt_* function. Its job
  # is to generate the prompt segment for display in instant prompt. See
  # https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #
  # Powerlevel10k will call instant_prompt_* at the same time as the regular prompt_* function
  # and will record all `p10k segment` calls it makes. When displaying instant prompt, Powerlevel10k
  # will replay these calls without actually calling instant_prompt_*. It is imperative that
  # instant_prompt_* always makes the same `p10k segment` calls regardless of environment. If this
  # rule is not observed, the content of instant prompt will be incorrect.
  #
  # Usually, you should either not define instant_prompt_* or simply call prompt_* from it. If
  # instant_prompt_* is not defined for a segment, the segment won't be shown in instant prompt.
  function instant_prompt_example() {
    # Since prompt_example always makes the same `p10k segment` calls, we can call it from
    # instant_prompt_example. This will give us the same `example` prompt segment in the instant
    # and regular prompts.
    prompt_example
  }

  # User-defined prompt segments can be customized the same way as built-in segments.
  typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=0
  typeset -g POWERLEVEL9K_EXAMPLE_BACKGROUND=red
  # typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  #               typed after changing current working directory.
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

  # Instant prompt mode.
  #
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, haven't
  #              seen the warning, or if you are unsure what this all means.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose


function prompt_incognito_flag() {
     if [[ $incognito == "true" ]]; then
          p10k segment -b green -f black   -t "Incognito"
     fi
}

function prompt_nvidia_flag() {
     nvidia_available=$((lsmod | grep -q nvidia) && echo '1' || echo '0')
     if [[ $__NV_PRIME_RENDER_OFFLOAD == "1" && $nvidia_available == 1 ]]; then
          p10k segment -b green -f black   -t "nvidia"
     elif [[ $__NV_PRIME_RENDER_OFFLOAD == "1" && $nvidia_available == 0 ]]; then
          p10k segment -b white -f black   -t "nvidia[unavailable]"
     fi
}

function prompt_shell_mommy() {
     # precmd() { if (( $? != 0 )); then; mommy false; else; mommy true; fi }
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
               # echo -e "<no command> last was <$lcmd>"
               mommy_did_not_run=true
          fi
     }
}


function prompt_my_cpu_temp() {
if [[ $(uname -o) == "Android" ]]; then
  break
elif [[ $(uname -o) == "Msys" ]]; then
  break
elif [[ $(uname -o) == "GNU/Linux" ]]; then
  integer cpu_temp="$(</sys/class/thermal/thermal_zone0/temp) / 1000"
  if (( cpu_temp >= 80 )); then
    p10k segment -s HOT -b yollow -f red    -t "${cpu_temp}"$'\uE339' -i $'\uF737'
  elif (( cpu_temp >= 60 )); then
    p10k segment -s WARM -b yollow -f green -t "${cpu_temp}"$'\uE339' -i $'\uE350'
  fi
else
    break
fi
}

function prompt_username() {
    username="$(whoami)"
    p10k segment -b black -f green -t "$(whoami)" -i $'@'
}


function prompt_sudocheck() {
    if [[ $EUID -eq 0 ]]; then
        p10k segment -b red -f black -t "sudo" -i $'@'
        # echo "You are currently running with root privileges."
    else
        # echo "You do not have root privileges. Checking sudo access..."

        # Check if sudo access is available without password prompt
        sudo -n true >> /dev/null &> /dev/null
        if [[ $? -eq 0 ]]; then
            p10k segment -b red -f black -t "sudo" -i $'@'
            # echo "Sudo access is available without password prompt."
        else
            # echo "Sudo access is either not available or requires a password prompt."
        fi
    fi
}







  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'

source $ZSH/oh-my-zsh.sh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"

export PATH=$HOME/.yarn/bin:$PATH


fpath+=${ZDOTDIR:-~}/.zsh_functions




# eval $(thefuck --alias)

autoload bashcompinit
bashcompinit
# source /usr/share/bash-completion/completions/nala

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# python pakages
export PATH="$HOME/.local/bin:$PATH"

# go bin termux
export PATH="/data/data/com.termux/files/home/.local/share/go/bin:$PATH"

# doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.config/.emacs/bin:$PATH"

export PATH="$HOME/shell/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"

# messed up ones maybe ?
export PATH="$HOME/.config/bin:$PATH"

export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.config/zsh/bin:$PATH"

export PATH="/data/data/com.termux/files/usr/bin:$PATH"
export PATH="/data/data/com.termux/files/home/.config/zsh/bin:$PATH"

[ -f $XDG_CONFIG_HOME/zsh/history ] && export HISTFILE=$XDG_CONFIG_HOME/zsh/history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

source $XDG_CONFIG_HOME/zsh/.zshrc_private

# compdef dnf=yum

# fp auto-completion
# () {
#   # A list of each flatpak app name in lowercase.
#   # (First word of the name to be exact, so "Brave Browser" will be "brave").
#   local FLATPAK_APPS=$(flatpak list --app | cut -f1 | awk '{print tolower($1)}')
#   complete -W $FLATPAK_APPS fp
# }

# # Run Flatpak apps from CLI, e.g.: "fp okular"
# function fp() {
#   app=$(flatpak list --app | cut -f2 | awk -v app="$1" '(tolower($NF) ~ tolower(app))')

#   # Abort if the app name was not entered
#   test -z $1 && printf "Enter an app to fp.\n\$ fp <app>\n\nINSTALLED APPS\n$app\n" && return;

#   # Remove app name from "$@" array
#   shift 1;

#   # Run the flatpak app asynchronous and don't show any stdout and stderr
#   ( flatpak run "$app" "$@" &> /dev/null & )
# }

# compdef fp="flatpak run"
if command -v flatpak &> /dev/null
then
function fp() {
#PURPOSE: Wrapper for $(flatpak run)

##check if flatpak is installed and accesible to $PATH
command -v flatpak >/dev/null 2>&1 || { printf "Flatpak package was not found.\n"; exit 1; }

##check if any flatpak packages are installed
test "$(flatpak list --all | head -c1 | wc -c)" -eq "0" && { printf "No Flatpak packages are installed.\n"; exit 1; }

##check if an app name was entered
[ "$#" -eq "0" ] && { printf "%s\n\n%s\n%s\n%s" "Usage: fp [APP] [OPTION]" "INSTALLED APPS:" "$(flatpak list --all)"; exit 1; }

##store reverse dns name for package
app=$(flatpak list --app | cut -f2 | awk -F. -v app="$1" '(tolower($0) ~ tolower(app))')

##check if entered app name is valid
[ -z "$app" ] && { printf "Entered app name is invalid.\n"; exit 1; }

##remove app name from "$@" array
shift 1;

##main
flatpak run "$app" "$@"
}
# Tab completion for Flatpak applications
function _fp_completion() {
  local applications
  applications=($(flatpak list --app | awk -F '\t' '{print $2}'))
  _arguments '1: :("${applications[@]}")'
}

compdef _fp_completion fp
fi

# exa settings
# source $(dirname $(gem which exa))/tab_complete.sh
alias lc='exa'

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
     # Regular Colors=



      export FG_R_Black="\e[0;30m"
      export FG_R_Red="\e[0;31m"
      export FG_R_Green="\e[0;32m"
      export FG_R_Yellow="\e[0;33m"
      export FG_R_Blue="\e[0;34m"
      export FG_R_Purple="\e[0;35m"
      export FG_R_Cyan="\e[0;36m"
      export FG_R_White="\e[0;37m"

     # Bold=


      export FG_B_Black="\e[1;30m"
      export FG_B_Red="\e[1;31m"
      export FG_B_Green="\e[1;32m"
      export FG_B_Yellow="\e[1;33m"
      export FG_B_Blue="\e[1;34m"
      export FG_B_Purple="\e[1;35m"
      export FG_B_Cyan="\e[1;36m"
      export FG_B_White="\e[1;37m"

     # Underline=


      export FG_U_Black="\e[4;30m"
      export FG_U_Red="\e[4;31m"
      export FG_U_Green="\e[4;32m"
      export FG_U_Yellow="\e[4;33m"
      export FG_U_Blue="\e[4;34m"
      export FG_U_Purple="\e[4;35m"
      export FG_U_Cyan="\e[4;36m"
      export FG_U_White="\e[4;37m"

     # Background=



      export BG_R_Black="\e[40m"
      export BG_R_Red="\e[41m"
      export BG_R_Green="\e[42m"
      export BG_R_Yellow="\e[43m"
      export BG_R_Blue="\e[44m"
      export BG_R_Purple="\e[45m"
      export BG_R_Cyan="\e[46m"
      export BG_R_White="\e[47m"

     # High Intensty=


      export FG_HI_Black="\e[0;90m"
      export FG_HI_Red="\e[0;91m"
      export FG_HI_Green="\e[0;92m"
      export FG_HI_Yellow="\e[0;93m"
      export FG_HI_Blue="\e[0;94m"
      export FG_HI_Purple="\e[0;95m"
      export FG_HI_Cyan="\e[0;96m"
      export FG_HI_White="\e[0;97m"

     # Bold High Intensty=


      export FG_BHI_Black="\e[1;90m"
      export FG_BHI_Red="\e[1;91m"
      export FG_BHI_Green="\e[1;92m"
      export FG_BHI_Yellow="\e[1;93m"
      export FG_BHI_Blue="\e[1;94m"
      export FG_BHI_Purple="\e[1;95m"
      export FG_BHI_Cyan="\e[1;96m"
      export FG_BHI_White="\e[1;97m"

     # High Intensty backgrounds=



      export BG_HI_Black="\e[0;100m"
      export BG_HI_Red="\e[0;101m"
      export BG_HI_Green="\e[0;102m"
      export BG_HI_Yellow="\e[0;103m"
      export BG_HI_Blue="\e[0;104m"
      export BG_HI_Purple="\e[0;105m"
      export BG_HI_Cyan="\e[0;106m"
      export BG_HI_White="\e[0;107m"

     # Reset=




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
                    # get from history
                    # echo $OPTARG
                    # history=$(sk ~/.config/zsh/history)
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
                    "$EDITOR" "$(which "$OPTARG" | head -n 1)"
                    exit
                    ;;
               l)
                    hisline=$OPTARG
                    # tail -n ${hisline:-10} ~/.config/zsh/history
                    ;;
               *)
                    exit
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
         (*) exit 1
       esac
     done
     # echo "Now, the arguments are $*"
}

addESC() { sed 's/[][ \~`!@#$%^&*()=+{}|;:'"'"'",<>/?-]/\\&/g'; }

getnamedir () {
     if [[ $getnamedirpass == true ]] ; then
          echo working
          echo ""
     else
          t=$(date +%s)
          cdr=$(pwd)
          # pipe=$(cat -)
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
     # cat $cdr/c$t.c.sh | grep "^[^#]" | grep -v "^$" &> /dev/null && echo "Nothing to Execute" || rm $cdr/c$t.c.sh && exit
     scripttxt="$(echo "$cdr"/c"$t".c.sh | grep "^[^#]" | grep -v "^$")"
     if [[ $scripttxt == "" ]] ; then
          echo "Nothing to Execute" && rm "$cdr"/c"$t".c.sh && exit
     fi
     echo Executuing: &&
     tput setaf 198
     command -v bat >/dev/null && bat -P c"$t".c.sh || cat .c.sh &&
     tput setaf 7
     # cat c$t.c.sh | zsh
     chmod +x c"$t".c.sh
     mkdir -p ~/c
}

ifpiped () {
     echo "Data was piped to this script!"
     # echo -e "\e[0mIf you are sure Press \e[30m\e[42mEnter\e[0m otherwise Press \e[30m\e[41mCtrl-c\e[0m\"
     echo -e "#\ Warning : Piping is being used.Therefore, script will execute on save and exit.If you do not want it executing do not save just quit." >> c"$t".c.sh &&
     # echo -e "read" >> c"$t".c.sh
     echo -e "" >> c"$t".c.sh
     # If we want to read the input line by line
     while IFS= read  pipe; do
          echo "${pipe}" >> c"$t".c.sh
     done
     # Or if we want to simply grab all the data, we can simply use cat instead
     # cat
}

askc () {
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Green}Execute${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Green}y${ClearColor}"
     echo -e "${ClearColor}Do you want to                                    ${FG_B_Black}${BG_R_Red}Discard${ClearColor} it ?  Press ${FG_B_Black}${BG_R_Red}n${ClearColor} or ${FG_B_Black}${BG_R_Red}d${ClearColor}"
     echo -e "${ClearColor}Or perhaps you want to save the script with a     ${FG_B_Black}${BG_R_Purple}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Purple}r${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to save the script without a    ${FG_B_Black}${BG_R_Yellow}new name${ClearColor}   ?  Press ${FG_B_Black}${BG_R_Yellow}c${ClearColor}"
     echo -e "${ClearColor}Or maybe you want to rework the script, I mean    ${FG_B_Black}${BG_R_Cyan}rework${ClearColor}     ?  Press ${FG_B_Black}${BG_R_Cyan}e${ClearColor}"
     echo -e "${ClearColor}Oh ,and if you end up pressing enter or anything else except Ctrl-c ,it will count like c\n"
     # echo $(echo $(echo $(read) >> /dev/null) >> /dev/null) >> /dev/null
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
     # echo $scripttxt
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

nvidia() {
     if [[ $1 == "off" || $1 == "disable" || $1 == "--off" || $1 == "--disable" || $1 == "d" || $1 == "-d" ]] ; then
          fc -P && nvidia=false
          export __NV_PRIME_RENDER_OFFLOAD=0
          # clear &&
          # rm -rfv /tmp/.zsh_history.tmp && echo "Temporary history removed" &&
          # echo -e "${FG_R_Black}${BG_R_Red}" &&
          # align_center "Incognito Mode Disabled" "󱐡 " "󰗹 " &&
          # echo -e "${ClearColor}\n"
     else
          export __NV_PRIME_RENDER_OFFLOAD=1 && $@
          # "$(binpath cp)" "$HISTFILE" /tmp/.zsh_history.tmp &&
          # fc -p /tmp/.zsh_history.tmp && incognito=true
          # clear &&
          # echo -e "${FG_R_Black}${BG_R_Green}" &&
          # align_center "Incognito Mode Enabled" "󱐡 " "󰗹 " &&
          # echo -e "${ClearColor}\n"
     fi
}

# Define preexec function to be called before running a command
function command_permission() {
  # Get the command being run
  local cmd="${1}"
  local cmd=$(echo "${cmd}" | awk '{print $1}' )

  # Check if it starts with "./" and if the file doesn't have execute permission
  if [[ "${cmd}" =~ ^\./ && ! -x "${cmd#./}" ]]; then
    # Prompt for permission to chmod +x the file
    read -rq "REPLY?${cmd#./} is not executable. Do you want to make it executable (y/n)? "
    "$cmd" "$@"

    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Make the file executable
      chmod +x "${cmd#./}"
    fi

    # Add a newline after the prompt
    echo ""
  fi
}

# Set the preexec function to be called before running each command
autoload -Uz add-zsh-hook
add-zsh-hook preexec command_permission

unixtime() {
  date +%s
}

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
    printf "\n${DEF_MOMMY_COLOR}$response${COLORS_RESET}\n\n"
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

playepisodes() {

    ulimit -s 9999999

    video="${1}"
    sub="${2}"
    ep="${3:-25}"

    # video="name%02dsomethong"
    # sub="subofname%02dsomethong"

    # Loop through episodes 1 to 26 and generate links
    for (( i=01; i<="$ep"; i++ ))
    do
        # Generate link using printf with episode number as argument
        ii=$(printf '%02d\n' $i)
        linkv=${video/episode_nung/$ii}
        links=${sub/episode_nung/$ii}


        # Add link to list
        linkvs+=("$linkv")
        linkss+=("$links")
    done

    # Print list of links
    [[ "$sub" != "" ]] && comm="$(printf '%s --sub-files-append=%s %s ' "mpv" "${linkss[@]}" "${linkvs[@]}")"
    comm="$(printf '%s %s ' "mpv" "${linkvs[@]}")"

    printf '%s' "$comm"
    echo print now playing:
    eval ${comm}

}

extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

escapestring() {
  if [ -p /dev/stdin ]; then
    while IFS= read  pipe; do
      # echo "${pipe}" >> c"$t".c.sh
      string="$string\n$pipe"
      # echo $string
    done
  else
    string="$@"
  fi
  
  # echo "$string"
  echo "$string" | sed -e 's/[[:punct:]|[:space:]]/\\&/g' | sed -e 's/\\-/-/g'| sed -e 's/\\\//\//g' | sed '1d'
}

org-toc-update() {
  generate_toc_arrays() {
    IFS=''
    seg1col=()
    linecol=()
    seg1old=()
    seg2old=()
    tabcol=()
    while read -r line; do
      # if [[ ""$line"" =~ ^\* ]]; then
      if [[ "$(echo "$line" | grep -o '^**')" ]]; then
        linecol+=("$line")
        seg1=$(echo "$line" | sed 's/\ /-/g' | tr -cd '[:alnum:]._-' | sed 's/-//' | sed -e 's/\(.*\)/\L\1/' | sed 's/\.//g')
        seg2=$(echo "$line" | sed 's/^\**//g' | sed 's/^\ //')
        seg1old+=($seg1)
        seg2old+=($seg2)
        tab=$(echo "$line" | grep -o '^**' | wc -c)
        ((tab--))
        tab=$(printf "%${tab}c" ' ')
        tabcol+=("$tab")
        # echo "- [[#$seg1]["$line"]]"
        # seg1col=seg1col$seg1
      fi
    done < "$1"
    # echo ${seg1col[1]}

    # Create an associative array to keep track of counts
    declare -A counts
    
    # Iterate through the original array
    for element in "${seg1old[@]}"; do
      # Increment the count for this element
      ((counts["$element"]++))
      
      # Append the count to the element if it's not unique
      if ((counts["$element"] == 1)); then
        new_element="$element"
      elif ((counts["$element"] > 1)); then
        ((temcou=${counts["$element"]}-1))
        new_element="${element}-${temcou}"
      else
        new_element="$element"
      fi
      
      # Add the modified element to the new array
      seg1+=("$new_element")
    done

    echo "* TABLE OF CONTENTS :toc:"
    c=0
    for line in "${seg1old[@]}"
    do
      if [[ ${seg1[(($c+1))]} == "table-of-contents-toc" ]]
      then
        ((c++))
      else
        echo "${tabcol[$c]}- [[#${seg1[(($c+1))]}][${seg2old[$c]}]]" | sed 's/^\ -/-/'    
        ((c++))
      fi
    done
  }
  oldtoc="$(sed -n '/^\*\ TABLE\ OF\ CONTENTS/,/^$/p' "$1")"
  newtoc="$(generate_toc_arrays "$1")"
  oldfile=$(cat "$1")
  newfile=${oldfile//"${oldtoc}"/"${newtoc}"}
  echo "$newfile" > "$1"
}

org-tangle-from-zsh() {
  emacs --batch -l org --eval "(org-babel-tangle-file \"$1\")"
}

# alias feh="feh -Z"
alias fehr="feh -ZnzrF"
alias feh="feh -nZrF -S mtime"

feho() {
  pwd="$(pwd)"
  cd "$1"
  find . -type f -maxdepth 0 | xargs feh -ZnFS mtime
  cd "$pwd"
}

play() {

  args="$@"
  
  complay=" /home/rex/Music/songs/ -iname \"idonnowhattoputinhere\" "
  
  for ((i = 1 ; i <= $( echo "$@" | wc -w ) ; i++)); do
    if [[ $@[$i] == "-n" ]] ; then
      i=i+1
      ncomplay=" "$ncomplay" -a -not -iname \"*"${@["$i"]}"*\" "
    elif [[ $@[$i] == "-N" ]] ; then
      i=i+1
      ncomplay=" "$ncomplay" -a -not -name \"*"${@["$i"]}"*\" "
    fi
  done
  
  for ((i = 1 ; i <= $( echo "$@" | wc -w ) ; i++)); do
    if [[ $@[$i] == "-E" ]] ; then
      i=i+1
      complay=" "$complay" "$ncomplay" -o -name \"*"${@["$i"]}"*\" "
    else
      complay=" "$complay" "$ncomplay" -o -iname \"*"${@["$i"]}"*\" "
    fi
  done
  
  complay="$complay $ncomplay"
  
  # echo $complay
  
  listplay=$(eval find "$complay" |sed -e 's/[[:punct:]|[:space:]]/\\&/g' | sed -e 's/\\-/-/g'| sed -e 's/\\\//\//g')
  
  echo "find $complay"
  echo "$listplay"
  echo "$listplay" | sed -e 's/\n/\ /g' | xargs mpv --no-resume-playback

}

ftpplay() {

    if [[ "${@: -1}" == *10.16.100.244* ]] ; then
        link="${@: -1}"
        # links="$(curl -s "$1" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | tail -n $(( $(( $(curl -s "$1" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | wc -l) / 2 )) )) | sed "s/.*/'&'/" | tr '\n' ' ' )"
        links="$(curl -s "$link" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | tail -n $(( $(( $(curl -s "$link" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | wc -l) / 2 )) )) )"

        mpv_playlist=~/.config/ftpplaycircle/"${URL//\//_}"_"$(date +%s)"

        # Generate playlist folder
        mkdir -p ~/.config/ftpplaycircle/

        echo "$links"
        # Print the extracted MKV file links to the playlist file
        echo "$links" > "$mpv_playlist"

        # Play the playlist
        if [[ "$1" == 'd' ]] ; then
            cd ~/Downloads
            xargs -a "$mpv_playlist" -L1 wget
            # parallel --gnu -a "$mpv_playlist" wget
        elif [[ "$1" == 'f' ]] ; then
            mpv_flags="$2"
        else
            if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then xdg-open --content-type video $mpv_playlist ; else mpv "$mpv_flags" --playlist="$mpv_playlist" ; fi
        fi
        return 1
    fi

    if [[ $1 == "s" ]]; then
        P_URL="http://circleftp.net/?s=${2// /+}"
        # P_URL="http://new.circleftp.net/search%q=${2// /+}"
        # point="$(echo "$2" | awk '{print $1}')"
        echo "$P_URL"
	      URL="$(curl -s "$P_URL" | sed -n '/main-content/,/nav_menu-3/p' | grep /cn/ | sed 's/<a href\=\"//g' | sed 's/\">//g' | sed 's/\ //g' | uniq | fzf)"
    fi

    if [[ $1 == "c" ]] || [[ $1 == "s" ]]; then

        if [[ $1 == "c" ]]; then
          link="${@: -1}"
        elif [[ $1 == "s" ]]; then
          link="$URL"
        fi

        echo "$link"

        # links="$(curl -s "$1" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | tail -n $(( $(( $(curl -s "$1" | grep -o 'https\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | wc -l) / 2 )) )) | sed "s/.*/'&'/" | tr '\n' ' ' )"
        links="$(echo "$link" | tr -d '"' | xargs curl -v | grep -o 'http\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | tail -n $(( $(( $(echo "$link" |tr -d '"' | xargs curl -v | grep -o 'http\?://[^"]*' | grep -E '\.(mp4|avi|mkv|mov|wmv|flv)' | wc -l) )) )) )"

        # links="$(echo "$link" | tr -d '"' | xargs curl )"

        echo "$links"

        mpv_playlist=~/.config/ftpplaycircle/"${URL//\//_}"_"$(date +%s)"

        # Generate playlist folder
        mkdir -p ~/.config/ftpplaycircle/

        echo "$links"
        # Print the extracted MKV file links to the playlist file
        echo "$links" > "$mpv_playlist"

        # Play the playlist
        if [[ "$1" == 'd' ]] ; then
            cd ~/Downloads
            xargs -a "$mpv_playlist" -L1 wget
            # parallel --gnu -a "$mpv_playlist" wget
        elif [[ "$1" == 'f' ]] ; then
            mpv_flags="$2"
        else
            if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then xdg-open --content-type video $mpv_playlist ; else mpv "$mpv_flags" --playlist="$mpv_playlist" ; fi
        fi
        return 1
    fi

    # Circle ftp player

    # URL of the webpage to scrape


    if [[ $1 == "sn" ]]; then
        # P_URL="http://circleftp.net/?s=${2// /+}"
        # P_URL="http://new.circleftp.net/search?q=${2// /+}"
        base_URL="http://103.170.204.84/"
        P_URL=search?q=${base_URL}${2// /+}
        echo "$P_URL"
        URL="$(node ~/puppeteer/test.js "$P_URL")"
        # echo "$URL"text="$(while IFS= read -r line ; do echo "Received: $line" ; done | sed 's/></>\n</g')"
        URL="$(echo "$URL" | sed 's/></>\n</g')"

        # Replace 'input.html' with the actual HTML file you want to parse
        # html_file="input.html"

        # Extract div class and href using grep, awk, and sed
        # div_class_list=$(echo "$IFS" | grep -o '<div[^>]*class="[^"]*"' | awk -F 'class="' '{print $2}' | awk -F '"' '{print $1}')
        # href_list=$(echo "text" | grep -o '<a[^>]*href="[^"]*"' | awk -F 'href="' '{print $2}' | awk -F '"' '{print $1}')

        # Extract div class and href using grep, awk, and sed
        URL=$(echo "$URL" | grep -A 1 -i 'rounded SinglePost_singlePost_card__MLfCk' | awk -F '[ef]="' '{print $2}' | awk -F '"' '{print $1}' | sed 's/\/content\///' | sed 's/>//' | sed '/^$/d' | awk '{ORS = (NR % 2 == 0) ? "\n" : " IDCONTENT ";} 1' )

        # Print the extracted data
        # echo "Div Classes:"
        # echo "$div_class_list"

        URL="$(echo "$URL" | fzf | awk -F "IDCONTENT " '{print $2}')"
        echo "$URL"
        URL=${base_URL}${URL}
    elif [[ $1 == "s" ]]; then
        P_URL="http://circleftp.net/?s=${2// /+}"
        # P_URL="http://new.circleftp.net/search%q=${2// /+}"
        # point="$(echo "$2" | awk '{print $1}')"
        echo "$P_URL"
	      URL="$(curl "$P_URL" | sed -n '/main-content/,/nav_menu-3/p' | grep /cn/ | sed 's/<a href\=//g' | sed 's/>//g' | sed 's/\ //g' | uniq | fzf)"
    else
        URL="$1"
    fi

    echo "$URL"

    # Fetch the webpage content using curl
    page_content=$(curl -s "$URL")
    page_content=$(node ~/puppeteer/test.js "$URL")

    echo "$page_content" | grep -oP '(?<=<h2 class="text-white text-bolder">).*?(?=</h2)'

    # Use grep to extract all MKV file links
    mkv_links=$(echo "$page_content" | grep -oP 'href="\K[^"]*\.mkv')
    mkv_links+=$(echo "$page_content" | grep -oP 'href="\K[^"]*\.mp4')

    # Generate a playlist file name with path
    # mpv_playlist=~/.config/ftpplaycircle/mpv_playlist_"$(date +%s)"
    mpv_playlist=~/.config/ftpplaycircle/"${URL//\//_}"_"$(date +%s)"

    # Generate playlist folder
    mkdir -p ~/.config/ftpplaycircle/

    # Print the extracted MKV file links to the playlist file
    echo "$mkv_links" > "$mpv_playlist"

    # Play the playlist
    if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then xdg-open --content-type video $mpv_playlist ; else mpv "$mpv_flags" --playlist="$mpv_playlist" ; fi

    # rm -rfv "$mpv_playlist"

}

ccr() {

local dir
dir="$(dirname "$1")"

c_file_name="$(basename "$1")"

# Check if a file was passed as an argument
if [ -z "$1" ]; then
    echo "Error: No file specified"
    return 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File $c_file_name not found"
    return 1
fi

# Check if the file is a C or C++ source file
if [[ "$c_file_name" != *.c && "$1" != *.cpp ]]; then
    echo "Error: $c_file_name is not a C or C++ source file"
    return 1
fi

# Get the base name of the file (without extension)
file_base=$(basename -s .c "$c_file_name")
file_base=$(basename -s .cpp "$file_base")

# Compile the program
if [[ "$c_file_name" == *.c ]]; then
    gcc -g -O -o "$dir"/"$file_base" "$dir"/"$c_file_name" -lncurses -lm -lX11
else
    g++ -g -O -o "$dir"/"$file_base" "$dir"/"$c_file_name" -lncurses -lm -lX11
fi

# Check if the compilation was successful
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed"
    return 1
fi

# Shift the arguments to pass only the program arguments to it
shift

# Print provided arguments
# shellcheck disable=SC2145
echo -e "\nProvided arguments : $@ \n"

# Print binary size
echo -ne "Binary size: "
du -h "$dir"/"$file_base" | awk '{print $1}' | xargs echo -n
echo -ne " to "
strip "$dir"/"$file_base"
du -h "$dir"/"$file_base" | awk '{print $1}'
echo ""

# Run the program with any additional arguments
echo "Executing binary:"
line="$(printf %"$(tput cols)"s |tr " " "-")"
echo "$line"
"$dir"/"$file_base" "$@"

# Clean up
rm "$dir"/"$file_base"

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

alias :q="exit"

termuxexec() {
     if [[ $(uname -a | awk '{print $14}') == "Android" ]]; then

          # unalias man
          # if command -v bat &> /dev/null
          # then
          #      export MANPAGER="most"   # The batman script in shell/bin/ seems to work now
          # fi

          export PATH="/data/data/com.termux/files/usr/bin:$PATH"

          termux-wake-lock
          sshd -p 43434

          # echo -e "termux detected"
          # echo "/data/data/com.termux/files/usr/bin/sshdhd -p 43434" >> ~/.zshrc
          # sed 's/my_cpu_temp/\#\ my_cpu_temp/' ~/shell/.p10k.zsh > ~/shell/.p10k.zsh
          # # echo "sed 's/my_cpu_temp/\#\ my_cpu_temp/' .p10k.zsh > .p10k.zsh"
          alias mpv="xdg-open"
     else
          # amn > /dev/null 2>&1
          # which em 2&> /dev/null >> /dev/null && export EDITOR="em" || export EDITOR="emacsclient -ca "emacs""
     fi
}

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
alias ssh="ssh -F ~/.ssh/config"
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
# alias em="emacsclient -ca "emacs""
alias pipupgrade="pip-review --local --auto"
# alias vi="lvim || nvim || vim || vi"
# alias vim="lvim || nvim || vim || vi"
alias tik="$(binpath kitty) +kitten icat"
alias icat="~/.local/kitty.app/bin/kitty +kitten icat"
# alias tmpv="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
# alias play="mpv $1 -wid $(xwininfo | awk '{if(/Window id:/) print $4}' & xdotool click 1)"
# alias apt="dnf"
alias gdown="gdown --fuzzy --continue"
alias gdownf="gdown --fuzzy --continue --folder"
alias rename="vidir --verbose"
# alias yolo=$HOME/yolo-ai-cmdbot/yolo.py
# alias computer=$HOME/yolo-ai-cmdbot/yolo.py
# alias roxy="sgpt --role roxy"
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
# then
#      alias vi="lvim"
#      export EDITOR="lvim"
# elif command -v nvim &> /dev/null
then
     alias vi="nvim"
     export EDITOR="nvim"
elif command -v vim &> /dev/null
then
     alias vi="vim"
     export EDITOR="vim"
else
     alias vi="vi"
     export EDITOR="vi"
fi

alias lvim="nvim"

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
            # echo it\'s an image
            if command -v viu &> /dev/null
            then
                # viu -1 -t "$arg" && read -n 1
                viu -1 -t "$arg"
            else
                img2txt -f utf8 -W "$(tput cols)" "$arg"
            fi
            # args=("${(@)args:#"$arg"}")

        fi

        if file --mime-type "$arg" | grep -v image >> /dev/null
        then
            # echo it\'s an image
            bat --style=plain --paging=never "${args_bat[@]}" "$arg"
            # echo -e "bat -p --paging=never "${args_bat[@]}" "$arg""
        fi

    done

}
compdef bat=cat

if command -v batman &> /dev/null
then
     # export MANPAGER="sh -c 'col -bx  | bat -l man -p'"
     # export MANPAGER="batman"
     alias man="batman"
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

unalias ls
unalias l

eza_ls() {
    eza -a --icons "$@" || return 1
    printf '\e[31m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(eza -a --icons "$@" | wc -l)
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    echo -ne "count:  \e[31m$total_number_of_files\e[0m"
    for i in {1..$((6-${#total_number_of_files}))} ; do echo -n -e " " ; done
    echo -e "total_size:\e[32m $total_size\e[0m"
}
eza_l() {
    if [ $(tput cols) -gt "130" ]; then
        eza -alihgSUHumo -F always --icons "$@" || return 1
    else
        eza --long -o "$@" || return 1
    fi
    eza="$(eza -alihgSUHum --icons "$@" | head -1)"
    total_number_of_files=$(eza -a --icons "$@" | wc -l)
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    # echo -ne "count:  \e[31m$total_number_of_files\e[0m"
    for i in {1..$((6-${#total_number_of_files}))} ; do echo -n -e " " ; done
    # echo -e "total_size:\e[32m $total_size\e[0m"








    gap1="$(echo "$eza" | awk '{print index($0, "Permissions")-1}')"
    gap2="$(echo "$eza" | awk '{print index($0, "Size")-1}')"
    # echo $gap2
    gap2="$(($gap2-$gap1))"
    # echo $gap1
    # echo $gap2
    printf '\e[31m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(eza -alihgSUFum --icons "$@" | wc -l)-1))
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    echo -ne "count:"
    for i in {1..$(($gap1-6))} ; do echo -n -e " " ; done
    echo -ne "\e[31m$total_number_of_files\e[0m"
    for i in {1..$(($gap2-15))} ; do echo -n -e " " ; done
    echo -ne "total_size:"
    echo -e "\e[32m $total_size\e[0m"








}
eza_lst() {
    eza --tree "$@"
}

exa_ls() {
    exa -a --icons "$@" || return 1
    printf '\e[31m%*s\e[0m\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(exa -a --icons "$@" | wc -l)
    total_size="$(/bin/ls -gh "$@" | head -n 1 | awk '{print $2}')"
    echo -ne "count:  \e[31m$total_number_of_files\e[0m"
    for i in {1..$((6-${#total_number_of_files}))} ; do echo -n -e " " ; done
    echo -e "total_size:\e[32m $total_size\e[0m"
}
exa_l() {
    exa -alihgSUFHum --icons "$@" || return 1
    exa="$(exa -alihgSUFHum --icons "$@" | head -1)"
    gap1="$(echo "$exa" | awk '{print index($0, "Permissions")-1}')"
    gap2="$(echo "$exa" | awk '{print index($0, "Size")-1}')"
    # echo $gap2
    gap2="$(($gap2-$gap1))"
    # echo $gap1
    # echo $gap2
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
    /bin/ls -a "$@" || braek
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(/bin/ls -a "$@" | wc -l)-2))
    echo "$total_number_of_files"
}
gnu_l() {
    /bin/ls -alihgSUFHu "$@" || braek
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total_number_of_files=$(($(/bin/ls -alihgSUFHu "$@" | wc -l)-3))
    echo "$total_number_of_files"
}
gnu_lst() {
    /bin/ls "$@" || braek
    /bin/ls "$@" | wc -l
}

if command -v eza &> /dev/null
then
     alias ls="eza_ls"
     alias l="eza_l"
     alias lst="eza_lst"
elif command -v exa &> /dev/null
then
     # alias ls="exa -a --icons"
     # alias l="exa -alihgSUFHum --icons"
     # alias lst="exa --tree"
     alias ls="exa_ls"
     alias l="exa_l"
     alias lst="exa_lst"
else
     # alias ls="/bin/ls -a"
     # alias l="/bin/ls -alihgSUFHu --color"
     # alias lst="/bin/ls"
     alias ls="gnu_ls"
     alias l="gnu_l"
     alias lst="gnu_lst"
fi

if command -v bat &> /dev/null
then
    lsblk() {
        "$(which lsblk)" "$@" | bat -p --language=fstab
    }

    bcat() {
        bcat_var_func="$(functions "$1" | cat -pl sh)"
        if [ -n "$bcat_var_func" ] ; then
            echo "$bcat_var_func" | cat -pl sh
            echo -e "\n"
        fi

        bcat_var_alias="$(alias "$1" | cat -pl sh)"
        if [ -n "$bcat_var_alias" ] ; then
            echo "$bcat_var_alias" | cat -pl sh
            echo -e "\n"
        fi

        cat -p "$(type "$1" | grep -v 'function' | grep -v 'alias' | awk '{print $3}')"

        # bcat_var_scr="$(which "$1" 2&> /dev/null | uniq)"
        # echo "$bcat_var_scr" | while read -r line ; do
        #     if [ -f "$line" ] ; then
        #         cat "$line"
        #     fi
        # done
    }
    compdef bcat=which
fi

qr() {
    local qrname
    qrname="$(date +%s)"
    qrencode -s 9 -l H \'"$*"\' -o /tmp/"$qrname"
    cat /tmp/"$qrname"
}

if command -v bat &> /dev/null
then
    head() {
    /"$(binpath head)" "$@" | cat
    }
fi

if command -v bat &> /dev/null
then
    tail() {
    /"$(binpath tail)" "$@" | cat
    }
fi

roxy() {
    sgpt --role roxy "\"$*\""
}

tgpt() {
    echo \""$@"\" | xargs tgpt
}

co() {
    echo \""$@"\" | tgpt --shell
}

open() {
    mimeopen -a "$@"
}

openfzf() {
    # openfzf_out_path=$(fzf | sed -e 's/[^a-zA-Z0-9,._+@%/-]/\\&/g; 1{$s/^$/""/}; 1!s/^/"/; $!s/$/"/')
    openfzf_out_path=$(fzf)
    mimeopen -a "$openfzf_out_path"
}

alias fzfopen=openfzf
alias fzfo=openfzf
alias ofzf=openfzf

alias rm="rm -i"

try() {
    while ! "$@" ; do sleep 1; done
}

loop() {
    while true ; do "$@" && sleep 1 && clear ; done
}

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

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

[ -f "$CARGO_HOME"/env ] && source "$CARGO_HOME/env"
# addESC() { sed 's/[][ \~`!@#$%^&*()=+{}|;:'"'"'",<>/?-]/\\&/g'; }
[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"

export ANDROID_HOME="$XDG_DATA_HOME"/android

termuxexec

# if echo $TMUX | grep tmate
# then
#     trap "echo 'Command interrupted.'; exit 1" INT
#     su -c "/bin/zsh" rex ; exit 2
# fi

sed -i 's/\# .*$//g' ~/.config/zsh/.zshrc
sed -i '/^ *$/d' ~/.config/zsh/.zshrc
# sed -i '/^$/d' file.txt

head -n -3 ~/.config/zsh/.zshrc >> ~/.config/zsh/.zshrc.temp && /"$(binpath mv)" ~/.config/zsh/.zshrc.temp ~/.config/zsh/.zshrc
