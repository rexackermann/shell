#!/usr/bin/env zsh
# Keep the actual configuration under XDG while making the setting available
# early enough for the system/global zshrc.
export ZDOTDIR="$HOME/.config/zsh"
skip_global_compinit=1
export skip_global_compinit

# When this file is the active $ZDOTDIR/.zshenv, the next file is already the
# one Zsh is reading and this source is harmlessly skipped by the path check.
if [[ "$ZDOTDIR/.zshenv" != "$HOME/.zshenv" && -r "$ZDOTDIR/.zshenv" ]]; then
  source "$ZDOTDIR/.zshenv"
fi
