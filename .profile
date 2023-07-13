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

[ -f "${HOME}/.gdrive-downloader/gdl" ] && [ -x "${HOME}/.gdrive-downloader/gdl" ] && PATH="${HOME}/.gdrive-downloader:${PATH}"

export PATH=$HOME/.yarn/bin:$PATH







export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# python pakages
export PATH="$HOME/.local/bin:$PATH"

# doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.config/.emacs/bin:$PATH"

export PATH="$HOME/shell/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"

# messed up ones maybe ?
export PATH="$HOME/.config/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM=/urs/bin/ibus-daemon -drx
