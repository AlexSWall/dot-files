# This file is executed by bash(1) for non-login shells.

case $- in
	*i*) ;;
	*) return;;
esac # Only run if interactive

OS=$(cat .operating_system)  # Sets `OS`; valid values: mac, ubuntu
if [[ ! "$OS" =~ ^(mac|ubuntu)$ ]]; then echo 'Error: .operating_system value not one of {mac,ubuntu}'; return; fi


set -o vi

HISTSIZE=1000           # Number of commands.
HISTFILESIZE=2000       # Number of lines.
HISTCONTROL=ignoreboth  # Ignore duplicate lines and lines starting with a space.

shopt -s histappend    # Append to the history file, don't overwrite it
shopt -s checkwinsize  # Sets 'checkwinsize': After each command, the `LINES` and `COLUMNS` values are updated

case $OS in
	mac) export BASH_SILENCE_DEPRECATION_WARNING=1 ;;
esac

# == Visuals ==

# Set CLI_COLOR/CLICOLOR if you want (Ansi) Colors
if [[ "$OS" == "mac" ]]; then
	export CLICOLOR=1
elif [[ "$OS" == "ubuntu" ]]; then
	export CLI_COLOR=1
fi

# Set the colours of directories, executables, etc., see: https://geoff.greer.fm/lscolors/
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# For the command prompt to including the previous directory nicely when considering root (/) and home (~):
PROMPT_COMMAND='case $PWD in
		$HOME)     HPWD="~";;
		$HOME/*/*) HPWD="${PWD#"${PWD%/*/*}/"}";;
		$HOME/*)   HPWD="~/${PWD##*/}";;
		/*/*/*)    HPWD="${PWD#"${PWD%/*/*}/"}";;
		 *)        HPWD="$PWD";;
	esac'
PS1='\[\e[0;33m\]\u\[\e[0;33m\] @ \[\e[0;36m\]$HPWD \[\e[0;33m\]\$\[\e[0m\] '


# == Includes ==

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.aliases ]      && source ~/.aliases
[ -f ~/.fzf.bash ]     && source ~/.fzf.bash
