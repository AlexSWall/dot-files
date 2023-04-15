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
	bind -M insert \r execute_command_hook
	bind -M insert \n execute_command_hook

	# Ctrl-y accepts accept-autosuggestion
	bind \cY accept-autosuggestion
	bind -M insert \cY accept-autosuggestion

	# Ctrl-n, Ctrl-p to recent argument
	bind \cP history-token-search-backward
	bind -M insert \cP history-token-search-backward
	bind \cN history-token-search-forward
	bind -M insert \cN history-token-search-forward

	# Expand abbreviation without trailing space via Ctrl-Space.
	bind \cE expand-abbr
	bind -M insert \cE expand-abbr

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
