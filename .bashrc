#!/usr/bin/env bash

# Only run if interactive
case $- in  *i*) ;;  *) return;;  esac

# Run standard shell setup
[ -f ~/.shrc ] && source ~/.shrc


: # General Bash Setup
  # -------------------

	: # Set TERM
	export TERM=xterm-256color

	# Ascend
	set -o vi

	# Append to the history file, don't overwrite it
	shopt -s histappend

	# Sets 'checkwinsize': After each command, the `LINES` and `COLUMNS` values are updated
	shopt -s checkwinsize

	# Extended globbing
	shopt -s extglob

	: # Bash: Ensure programmable bash completion is enabled.
	if ! shopt -oq posix; then
	  if [ -f /usr/share/bash-completion/bash_completion ]; then
		 . /usr/share/bash-completion/bash_completion
	  elif [ -f /etc/bash_completion ]; then
		 . /etc/bash_completion
	  fi
	fi


: # Prompt
  # ------

	: # For the command prompt to including the previous directory nicely when considering root (/) and home (~):
	PROMPT_COMMAND='
		if [ -z $_NEW_LINE_BEFORE_PROMPT ]
		then
			export _NEW_LINE_BEFORE_PROMPT=1
		else
			printf "\n"
		fi'

	green='\[\033[0;32m\]'
	gold='\[\033[0;33m\]'
	cyan='\[\033[0;36m\]'
	white='\[\033[0;0m\]'


	PS1=''
	PS1+=$green'┌──${debian_chroot:+($debian_chroot)──}'$cyan'('$gold'\u'$white'@'$gold''${HOST}''$cyan')'$green'─'$cyan'['$white'$PWD'$cyan']\n'
	PS1+=$green'└─'$gold'\$ '$white

