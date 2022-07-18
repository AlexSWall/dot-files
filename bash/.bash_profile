#!/usr/bin/env bash

# Source Other Files
# ------------------

if [[ -r "$HOME/.profile" ]]; then source "$HOME/.profile"; fi

# Source .bashrc if we have an interactive shell (i.e. 'i' is in $-).
case "$-" in
	*i*)
		if [[ -r "$HOME/.bashrc" ]]; then source "$HOME/.bashrc"; fi
		;;
esac

