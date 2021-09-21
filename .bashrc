#!/usr/bin/env bash

# == General bash setup ==

case $- in
	*i*) ;;
	*) return;;
esac # Only run if interactive

# Ascend
set -o vi
alias vim='nvim'
export VISUAL=nvim
export EDITOR="$VISUAL"

# History
HISTSIZE=1000           # Number of commands.
HISTFILESIZE=2000       # Number of lines.
HISTCONTROL=ignoreboth  # Ignore duplicate lines and lines starting with a space.

shopt -s histappend    # Append to the history file, don't overwrite it
shopt -s checkwinsize  # Sets 'checkwinsize': After each command, the `LINES` and `COLUMNS` values are updated

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Completition
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# == Prompt ==

# For the command prompt to including the previous directory nicely when considering root (/) and home (~):
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

# PS1=$gold'\u '$cyan'$HPWD'"\n"$gold'\$'$white' '

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot); fi

PS1=''
PS1+=$green'┌──${debian_chroot:+($debian_chroot)──}'$cyan'('$gold'\u'$cyan')'$green'─'$cyan'['$white'$PWD'$cyan']\n'
PS1+=$green'└─'$gold'\$ '$white


# == Visuals ==

# Set the colours of directories, executables, etc., see: https://geoff.greer.fm/lscolors/
if [ -x "$(command -v dircolors)" ]; then
	# -- Linux --
	export CLICOLOR=1
	eval "$(dircolors -b)"
	export LS_COLORS='gxBxhxDxfxhxhxhxhxcxcx:di=0;35:'
else
	# -- MacOS --
	export CLI_COLOR=1
	export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
fi

# GCC colours
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add colours to man pages, etc.
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


# == Includes ==

[ -f ~/.profile ]       && source ~/.profile
[ -f ~/.aliases ]       && source ~/.aliases
[ -f ~/.local_aliases ] && source ~/.local_aliases

