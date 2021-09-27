#!/usr/bin/env bash

# Source Other Files
# ------------------

if [[ -r "$HOME/.profile" ]]; then source "$HOME/.profile"; fi

case "$-" in
	*i*)
		if [[ -r "$HOME/.bashrc" ]]; then source "$HOME/.bashrc"; fi
		;;
esac

