#!/usr/bin/env bash

# Source Other Files
# ------------------

if [[ -r "$HOME/.local_profile" ]]; then source "$HOME/.local_profile"; fi


# Set environment variables
# -------------------------------

# XDG Environment Variables.
# Set the defaults.
export XDG_CONFIG_HOME="$HOME/.config"
export   XDG_DATA_HOME="$HOME/.local/share"
export  XDG_STATE_HOME="$HOME/.local/state"
export  XDG_CACHE_HOME="$HOME/.cache"

# Set UID and GID (if not already set) and export both.
[ -z "$UID" ] && UID=$(id -u); export UID
[ -z "$GID" ] && GID=$(id -g); export GID

export PAGER=less

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
