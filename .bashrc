# This file is executed by bash(1) for non-login shells.

case $- in *i*) ;; *) return;; esac # Only run if interactive

HISTSIZE=1000  # Number of commands.
HISTFILESIZE=2000  # Number of lines.
HISTCONTROL=ignoreboth  # Ignore duplicate lines and lines starting with a space.
shopt -s histappend  # Append to the history file, don't overwrite it
shopt -s checkwinsize  # Sets 'checkwinsize' in `shopt` (to 'on'). After each command, the window size will be checked and, if necessary, the values of LINES and COLUMNS will be updated.


# == Functionality ==

set -o vi

alias ls='ls -Fh'

function cs () {
	cd "$@" && ls
}

# Make the shortcuts for autojump work.
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


# == Visuals ==

# Set CLICOLOR if you want (Ansi) Colors
export CLICOLOR=1

# Set the colours of directories, executables, etc., see: https://geoff.greer.fm/lscolors/
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# For the command prompt to including the previous directory nicely when considering root (/) and home (~):
PROMPT_COMMAND='case $PWD in
        $HOME) HPWD="~";;
        $HOME/*/*) HPWD="${PWD#"${PWD%/*/*}/"}";;
        $HOME/*) HPWD="~/${PWD##*/}";;
        /*/*/*)    HPWD="${PWD#"${PWD%/*/*}/"}";;
        *) HPWD="$PWD";;
      esac'
# Setting the command prompt look:
PS1='\[\e[0;33m\]\u\[\e[0;33m\] @ \[\e[0;36m\]$HPWD \[\e[0;33m\]\$\[\e[0m\] '


# == Aliases ==

alias vim='nvim'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias composer='php composer.phar'

alias xamppssh='ssh -i ~/.bitnami/stackman/machines/xampp/ssh/id_rsa -o StrictHostKeyChecking=no root@192.168.64.4'
alias xamppcd='cd .bitnami/stackman/machines/xampp/volumes/root/project/'

# Good man pages:
#   man bash
#   man hier

export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/sbin:/usr/local/opt/llvm/bin:$PATH"
