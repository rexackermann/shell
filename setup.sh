#!/usr/bin/env bash
# Rex Shell installer (Zim + Powerlevel10k). Idempotent; backs up what it replaces.
# Usage: setup.sh [--no-private] [--dir DIR]
set -euo pipefail

REPO_URL=${REX_SHELL_REPO_URL:-https://github.com/rexackermann/shell.git}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
ZDOTDIR_TARGET=$XDG_CONFIG_HOME/zsh
DO_PRIVATE=1
ts=$(date +%s)

while (($#)); do
  case $1 in
    --no-private) DO_PRIVATE=0 ;;
    --dir) ZDOTDIR_TARGET=$2; shift ;;
    -h|--help) sed -n '2,3p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

need() { command -v "$1" >/dev/null 2>&1 || { echo "missing required tool: $1" >&2; exit 127; }; }
need git; need zsh; need curl

backup() { # move an existing non-symlink path aside
  local p=$1
  if [[ -e $p || -L $p ]]; then mv -v -- "$p" "$p.bak.$ts"; fi
}

install_repo() {
  mkdir -p "$XDG_CONFIG_HOME"
  if [[ -d $ZDOTDIR_TARGET/.git ]]; then
    echo "Updating $ZDOTDIR_TARGET"
    git -C "$ZDOTDIR_TARGET" pull --ff-only
  else
    backup "$ZDOTDIR_TARGET"
    git clone --depth 1 "$REPO_URL" "$ZDOTDIR_TARGET"
  fi
}

link_files() { # link <source-in-repo> <destination>
  local src=$ZDOTDIR_TARGET/$1 dst=$2
  [[ -e $src ]] || { echo "skip (not in repo): $1"; return 0; }
  if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then return 0; fi
  backup "$dst"
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

restore_private() {
  local gh=${GNUPGHOME:-$XDG_DATA_HOME/gnupg}
  command -v gpg >/dev/null 2>&1 || { echo "gpg not found; skipping history/private restore"; return 0; }
  GNUPGHOME=$gh gpg --list-secret-keys >/dev/null 2>&1 || {
    echo "No secret key in $gh; import yours there first (it is NOT stored in this repo). Skipping."
    return 0
  }
  read -rp "Restore encrypted history and private config? [y/N] " -n 1 ans; echo
  [[ $ans == [yY] ]] || { echo skipped; return 0; }
  umask 077
  cd "$ZDOTDIR_TARGET"
  [[ -f history ]] && cp -- history "history.bak.$ts"
  [[ -f .zshrc_private ]] && cp -- .zshrc_private ".zshrc_private.bak.$ts"
  GNUPGHOME=$gh gpg -d .zsh_history.gpg >>history
  GNUPGHOME=$gh gpg -d .zsh_private.gpg >>.zshrc_private
  echo "restored history and .zshrc_private into $ZDOTDIR_TARGET"
}

termuxexec() {
  if [[ -n ${TERMUX_VERSION:-} || ${PREFIX:-} == /data/data/com.termux/files/usr ]]; then
    echo "termux detected (Termux handling lives in zshrc.org)"
  fi
}

install_repo
link_files home.zshenv "$HOME/.zshenv"
link_files .profile    "$HOME/.profile"
link_files .p10k.zsh   "$HOME/.p10k.zsh"
((DO_PRIVATE)) && restore_private
termuxexec

echo
echo "Done. Start a new zsh: Zim and Powerlevel10k install themselves on first launch."
echo "Config source of truth: $ZDOTDIR_TARGET/zshrc.org (regenerate with tools/tangle.py)."
