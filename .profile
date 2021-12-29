#!/usr/bin/env bash

# PATH Variable
# -------------

if [ -d "$HOME/bin"        ]; then PATH="$HOME/bin:$PATH";        fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

export PATH


# Source Other Files
# ------------------

if [[ -r "$HOME/.local_profile" ]]; then source "$HOME/.local_profile"; fi

# Export UID and GID
export UID=$(id -u)
export GID=$(id -g)
