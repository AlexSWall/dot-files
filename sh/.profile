#!/usr/bin/env bash

# Source Other Files
# ------------------

if [[ -r "$HOME/.local_profile" ]]; then source "$HOME/.local_profile"; fi


# Set environment variables
# -------------------------------

# Pyflyby configuration path
PYFLYBY_PATH="$HOME/.config/pyflyby/pyflyby"
export PYFLYBY_PATH

# Export UID and GID
if [[ "$SHELL" != *fish ]]
then
	# fish already does this for us, so only do it for non-fish shells.
	UID=$(id -u)
	export UID
fi

GID=$(id -g)
export GID


# Set PATH
# ------------------

if [ -d "$HOME/bin"        ]; then PATH="$HOME/bin:$PATH";        fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

export PATH
