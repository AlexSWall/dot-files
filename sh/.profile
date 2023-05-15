#!/usr/bin/env bash

# Source Other Files
# ------------------

if [[ -r "$HOME/.local_profile" ]]; then source "$HOME/.local_profile"; fi


# Set environment variables
# -------------------------------

# Set UID and GID (if not already set) and export both.
[ -z "$UID" ] && UID=$(id -u); export UID
[ -z "$GID" ] && GID=$(id -g); export GID

# Use Neovim as the man pager.
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Pyflyby configuration path
PYFLYBY_PATH="$HOME/.config/pyflyby/pyflyby"
export PYFLYBY_PATH


# Set PATH
# ------------------

if [ -d "$HOME/bin"        ]; then PATH="$HOME/bin:$PATH";        fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

export PATH
