# This file is executed by bash(1) for non-login shells.
# Helpful man pages: bash, hier

case $- in
	*i*) ;;
	*) return;;
esac # Only run if interactive

set -o vi
alias vim='nvim'
export VISUAL=nvim
export EDITOR="$VISUAL"

HISTSIZE=1000           # Number of commands.
HISTFILESIZE=2000       # Number of lines.
HISTCONTROL=ignoreboth  # Ignore duplicate lines and lines starting with a space.

shopt -s histappend    # Append to the history file, don't overwrite it
shopt -s checkwinsize  # Sets 'checkwinsize': After each command, the `LINES` and `COLUMNS` values are updated

# == Visuals ==

export CLI_COLOR=1  # MacOS
export CLICOLOR=1   # Linux

# Set the colours of directories, executables, etc., see: https://geoff.greer.fm/lscolors/
#Are these needed? Taken from my kali .bashrc, might be outdated
#LS_OPTIONS='--color=auto'
#eval "$(dircolors -b)"
#alias ls-'ls $LS_OPTIONS'
#export LS_COLORS='gxBxhxDxfxhxhxhxhxcxcx:di=0;35:'
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# For the command prompt to including the previous directory nicely when considering root (/) and home (~):
PROMPT_COMMAND='case $PWD in
		$HOME)     HPWD="~";;
		$HOME/*/*) HPWD="${PWD#"${PWD%/*/*}/"}";;
		$HOME/*)   HPWD="~/${PWD##*/}";;
		/*/*/*)    HPWD="${PWD#"${PWD%/*/*}/"}";;
		 *)        HPWD="$PWD";;
	esac'
PS1='\[\e[0;33m\]\u\[\e[0;33m\] @ \[\e[0;36m\]$HPWD'"\n"'\[\e[0;33m\]\$\[\e[0m\] '
# PS1='\[\e[0;33m\]\u\[\e[0;33m\] @ \[\e[0;36m\]$HPWD \[\e[0;33m\](\[\e[0;36m\]CentOS\[\e[0;33m\])'"\n"'\[\e[0;33m\]\$\[\e[0m\] '


# == Includes ==

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.aliases ]      && source ~/.aliases
[ -f ~/.local_aliases ]      && source ~/.local_aliases
# [ -f ~/.fzf.bash ]     && source ~/.fzf.bash
