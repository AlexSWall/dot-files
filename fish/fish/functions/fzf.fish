function fzf --wraps fzf --description 'fzf with directory positional argument added.'

	set -l flags
	set -l pos_args

	for arg in $argv
		switch $arg
			case '-*'
				set -a flags $arg
			case '*'
				set -a pos_args $arg
		end
	end

	# Call fzf with additional vim-like bindings.
	set -l fzf_cmd \
		fzf --bind 'ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up' $flags

	# We have a few cases.
	#
	# - We have more than one positional argument. This is not valid.
	# - If we do not a positional argument, we'll base a file search from there.
	# - Else we'll do a normal fzf search, ensuring we consume stdin here if any.
	#
	# Additionally, if we have a positional argument to base a file search from,
	# we'll need to prepend all results with the base directory.

	if test (count $pos_args) -gt 1
		echo "Error: expected no more than one positional argument; received: $pos_args" 1>&2
		return 1

	# Case where we have only a positional argument.
	# We ignore stdin.
	else if test -n "$pos_args"
		set -l base_dir $pos_args[1]

		# Do some smart mappings to standard base directories.
		switch $base_dir
			case 'docs'
				set base_dir '~/Documents/'
		end

		set -l output (fish -c "cd $base_dir && command $fzf_cmd")

		# If we chose an entry, we need to prepend our directory positional
		# argument.
		if test (string trim $output) = ''
			# No output - don't echo.

		else
			set -l lines (string split \n $output)
			set -l output
			for line in $lines
				set -a output $base_dir$line
			end
			echo $output
		end

	else
		# This will include the stdin if any.
		command $fzf_cmd
	end
end

# By default, fish adds `complete -c fzf -f` to disable file positional argument
# completion, so we need to add it back here.
complete -c fzf -F
