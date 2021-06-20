# == General zsh setup ==

export TERM=xterm-256color
# export TERM=xterm

# Ascend
alias vim='nvim'
export VISUAL=nvim
export EDITOR="$VISUAL"

# Configure key keybindings
bindkey -v '^?' backward-delete-char  # vim key bindings with normal backspace
bindkey ' ' magic-space  # do history expansion on space

# Configure zsh shell
setopt autocd               # change directory just by typing its name
setopt interactivecomments  # allow comments in interactive mode
setopt magicequalsubst      # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch            # hide error message if there is no match for the pattern
setopt notify               # report the status of background jobs immediately
setopt numericglobsort      # sort filenames numerically when it makes sense
setopt promptsubst          # enable command substitution in prompt

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # ignore duplicated commands history list
setopt hist_ignore_space       # ignore commands that start with space
setopt hist_verify             # show command with history expansion to user before running it

WORDCHARS=${WORDCHARS//\/}  # Don't consider certain characters part of the word

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		TERM_TITLE=$'\e]0;%n@%m: %~\a'
		;;
	*)
		;;
esac

# Completition
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive tab completion

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete  # Allows shift-tab to go backwards in search


# == Prompt ==

precmd() {
	# Print the previously configured title
	print -Pnr -- "$TERM_TITLE"

	# Print a new line before the prompt, but only if it is not the first line
	if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
		_NEW_LINE_BEFORE_PROMPT=1
	else
		print ""
	fi
}

# Hide EOL sign ('%')
PROMPT_EOL_MARK=""

# Set variable identifying the chroot for PROMPT
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PROMPT=''
PROMPT+=$'%F{green}┌──${debian_chroot:+($debian_chroot)──}%F{cyan}(%F{3}%n%F{cyan})%F{green}─%F{cyan}[%F{reset}%(6~.%-1~/…/%4~.%5~)%F{cyan}]\n'
PROMPT+=$'%F{green}└─%F{3}$%F{reset} '

# One-line prompt if needed:
#PROMPT=$'%F{3}%n %F{cyan}%(6~.%-1~/…/%4~.%5~)\n%F{3}$%F{reset} '


# == Visuals ==

# Set LS_COLORS
if [ -x "$(command -v dircolors)" ]; then
	# -- Linux --
	export CLICOLOR=1
	eval "$(dircolors -b)"
	export LS_COLORS='di=36:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32'
else
	# -- MacOS --
	export CLI_COLOR=1
	export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
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


# == Misc ==

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# == Zsh Plugins ==

if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
	# Source plugin
	source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

	# Set color of auto-suggestions
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

	# Take advantage of $LS_COLORS for completion
	zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

if [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
	# Source plugin
	source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

	# Plugin Configuration
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[default]=none
	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[path]=underline
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[command-substitution]=none
	ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[process-substitution]=none
	ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[assign]=none
	ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
	ZSH_HIGHLIGHT_STYLES[named-fd]=none
	ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
	ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi


# == Aliases ==

# Alias clear to clear the 'new line before prompt' environment variable to
# avoid new line at the top.
alias clear='unset _NEW_LINE_BEFORE_PROMPT; clear'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias pushtmp='pushd "$(mktemp -d)"'

poptmp () {
	if popd
	then
		OLD_LEVEL_TWO_DIR="$(sed -E "s/(\/tmp\/tmp[^\/]*\/).*/\1/g" <<< $OLDPWD)"
		if [[ "$OLD_LEVEL_TWO_DIR" =~ "/tmp/.*" ]]
		then
			rm -rf "$OLD_LEVEL_TWO_DIR"
		else
			echo '$OLDPWD not in /tmp/; will not delete directory'
		fi
	fi
}

# == Includes ==

[ -f ~/.profile ]       && source ~/.profile
[ -f ~/.zshenv ]        && source ~/.zshenv
[ -f ~/.local_aliases ] && source ~/.local_aliases

