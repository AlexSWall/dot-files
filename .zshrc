#!/usr/bin/env zsh

# Standard shell setup:
[ -f ~/.shrc ] && source ~/.shrc


: # General Zsh Setup
  # -----------------

	: # Configure key keybindings
	bindkey -v '^?' backward-delete-char  # Vim key bindings with normal backspace
	bindkey ' ' magic-space               # Do history expansion on space

	# Configure zsh shell
	setopt autocd               # Change directory just by typing its name
	setopt interactivecomments  # Allow comments in interactive mode
	setopt magicequalsubst      # Enable filename expansion for arguments of the form ‘anything=expression’
	setopt nonomatch            # Hide error message if there is no match for the pattern
	setopt notify               # Report the status of background jobs immediately
	setopt numericglobsort      # Sort filenames numerically when it makes sense
	setopt promptsubst          # Enable command substitution in prompt

	# History configurations
	HISTFILE=~/.zsh_history
	setopt hist_expire_dups_first  # Delete duplicates first when HISTFILE size exceeds HISTSIZE
	setopt hist_ignore_dups        # Ignore duplicated commands history list
	setopt hist_ignore_space       # Ignore commands that start with space
	setopt hist_verify             # Show command with history expansion to user before running it

	# Force zsh to show the complete history
	alias history="history 0"

	# Make Ctrl-R bind to searching through history, like in bash
	bindkey '^R' history-incremental-search-backward

	# Add forward-slash to characters which split a word, to avoid skipping over
	# entire paths.
	WORDCHARS=${WORDCHARS//\/}
	WORDCHARS=${WORDCHARS/\/}

	# Add tab completition
	autoload -Uz compinit
	compinit -d ~/.cache/zcompdump
	zstyle ':completion:*:*:*:*:*' menu select

	# Case-insensitive tab completion
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

	# Allows shift-tab to go backwards in menus
	bindkey '^[[Z' reverse-menu-complete


: # Prompt
  # ------

	: # Hide EOL sign ('%').
	PROMPT_EOL_MARK=""

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

	PROMPT=''
	PROMPT+=$'%F{green}┌──${debian_chroot:+($debian_chroot)──}%F{cyan}(%F{3}%n%F{grey}@%F{3}${HOST}%F{cyan})%F{green}─%F{cyan}[%F{reset}%(6~.%-1~/…/%4~.%5~)%F{cyan}]\n'
	PROMPT+=$'%F{green}└─%F{3}$%F{reset} '


: # Zsh Plugins
  # -----------

	: # Zsh Autosuggestions

		if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
			# Source plugin
			source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

			# Set color of auto-suggestions
			ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

			# Take advantage of $LS_COLORS for completion
			zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
		fi

	: # Zsh Syntax Highlighting

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


: # Includes
  # --------

	[ -f ~/.zshenv ]        && source ~/.zshenv

