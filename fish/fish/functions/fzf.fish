function fzf --wraps fzf --description 'fzf with directory positional argument added.'
	set -f flags
	set -f pos_args

	for arg in $argv
		switch $arg
			case '-*'
				set flags $flags $arg
			case '*'
				set pos_args $pos_args $arg
		end
	end

	# Call fzf with additional vim-like binds.
	set -l fzf_cmd \
		fzf --bind 'ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up' $flags

	switch (count $pos_args)
		case 0
			set -f output "$(command $fzf_cmd)"
		case 1
			set -f output "$(fish -c "cd $pos_args[1] && command $fzf_cmd")"
			if test (count (string split \n $output)) -eq 1
				# Prepend the directory to our one-line output.
				set output $pos_args[1]$output
			end
		case '*'
			echo "Error: expected no more than one positional argument; received: $($pos_args)" 1>&2
			return 1
	end
	echo $output
end

# By default, fish adds `complete -c fzf -f` to disable file positional argument
# completion, so we need to add it back here.
complete -c fzf -F
