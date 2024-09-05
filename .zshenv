if [ "$TERM" = tramp ]; then
        unset RPROMPT
        unset RPS1
        PS1="$ "
        unsetopt zle
        unsetopt rcs  # Inhibit loading of further config files
fi

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

test -e "$XDG_CONFIG_HOME"/zsh/history && export HISTFILE="$XDG_CONFIG_HOME"/zsh/history
test -e "$HOME"/.config/zsh && export ZDOTDIR="$HOME"/.config/zsh

if [ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
# if [ -e $HOME/.local/bin/please ]; then $HOME/.local/bin/please; fi
# precmd() { if (( $? != 0 )); then; mommy false; else; mommy true; fi }

test -e "/home/rex/.local/share/cargo/env" && . "/home/rex/.local/share/cargo/env"
