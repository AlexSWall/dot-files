function itmux
	# Setting RUN_INNER_TMUX ensures we source the 'inner tmux' config.
	RUN_INNER_TMUX='1' tmux -L inner $argv
end
