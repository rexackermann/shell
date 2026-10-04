#!/usr/bin/env zsh
# Point Zsh at this directory so it loads $ZDOTDIR/.zshrc.
export ZDOTDIR="$HOME/.config/zsh"

# This configuration owns completion initialization. Ask Termux/global
# startup code not to initialize compinit before our completion stack.
skip_global_compinit=1
export skip_global_compinit
