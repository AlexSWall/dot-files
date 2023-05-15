#!/usr/bin/env fish

# Manually add plugin-foreign-env functions to the fish functions path.
set fish_function_path $fish_function_path ~/.config/fish/plugins/plugin-foreign-env/functions

if status is-interactive
	set fish_greeting
	set -g fish_key_bindings fish_vi_key_bindings
	set -g -x fish_prompt_pwd_dir_length 4

	# Run before executing a command.
	bind \r execute_command_hook
	bind \n execute_command_hook
	bind --mode insert \r execute_command_hook
	bind --mode insert \n execute_command_hook

	# Ctrl-y accepts accept-autosuggestion
	bind \cY accept-autosuggestion
	bind --mode insert \cY accept-autosuggestion

	# Ctrl-n, Ctrl-p to recent arguments
	bind \cP history-token-search-backward
	bind --mode insert \cP history-token-search-backward
	bind \cN history-token-search-forward
	bind --mode insert \cN history-token-search-forward

	# Expand abbreviation without trailing space via Ctrl-Space.
	bind \cE expand-abbr
	bind --mode insert \cE expand-abbr

	# `i` and `a` in visual mode set the mode to 'insert'.
	bind --mode visual i --sets-mode insert repaint
	bind --mode visual a --sets-mode insert forward-single-char and repaint

	source ~/.fishrc
	fenv "source ~/.profile"

	# Set colourscheme for command line
	source ~/.config/fish/functions/fish_cli_colourscheme.fish && fish_cli_colourscheme

	# Configure fzf.fish.
	# Set fzf `git log` binding to be Ctrl-Alt-g (for 'git').
	fzf_configure_bindings --git_log=\e\cg

	# Configure fifc.
	# fifc can help with finding:
	# - command options
	# - processes
	# - variables
	# Works best with the following installed:
	# - fd (paths)
	# - bat (files)
	# - exa (directories)
	# - procs (processes)
	# - hexyl (binaries)
	# - chafa (pictures)
	# Use Ctrl-Alt-x to use it (e.g. for command-arguemnt completion), with
	# neovim as the editor, and show hiiden files by default with fd.
	set -U fifc_keybinding \e\cx
	set -Ux fifc_editor 'nvim'
	set -U fifc_fd_opts --hidden
end
