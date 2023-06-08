function fzf --wraps fzf --description 'fzf with directory positional argument added.'
	# Create local variable 'stdin' containing any stdin contents.
	isatty stdin || read --local --null stdin

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

	# Call fzf with additional vim-like bindings.
	set -l fzf_cmd \
		fzf --bind 'ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up' $flags

	# We have 2x2 valid cases:
	# - We either have stdin or not
	# - We either have a positional argument or we don't.
	#
	# We'll check the number of positional arguments and then check for stdin.
	switch (count $pos_args)
		case 0
			# Only provide $stdin if it's non-empty.
			if test "$stdin" = ''
				set -f output "$(              command $fzf_cmd)"
			else
				set -f output "$(echo $stdin | command $fzf_cmd)"
			end
		case 1
			# Only provide $stdin if it's non-empty.
			if test "$stdin" = ''
				set -f output "$(              fish -c "cd $pos_args[1] && command $fzf_cmd")"
			else
				set -f output "$(echo $stdin | fish -c "cd $pos_args[1] && command $fzf_cmd")"
			end

			# If we chose an entry, we need to prepend our directory positional
			# argument. We check this by checking for a (single) line of output.
			if test (count (string split \n $output)) -eq 1
				set output $pos_args[1]$output
			end
		case '*'
			echo "Error: expected no more than one positional argument; received: $($pos_args)" 1>&2
			return 1
	end

	# Only output if there's anything to output.
	if test (string trim $output) != ''
		echo $output
	end
end

# By default, fish adds `complete -c fzf -f` to disable file positional argument
# completion, so we need to add it back here.
complete -c fzf -F
