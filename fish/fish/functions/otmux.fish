function otmux
	# Unsetting RUN_INNER_TMUX ensures we do not source the 'inner tmux' config.
	RUN_INNER_TMUX='' tmux -L default $argv
end
