# Changes to another directory using fzf.
function fzf-dir

	set --function flags
	set --function pos_args

	for arg in $argv
		switch $arg
			case '-*'
				set flags $flags $arg
			case '*'
				set pos_args $pos_args $arg
		end
	end

	# Set the base directory to be '.', or the single positional argument if one
	# was given.
	set --local base_dir (pwd)
	if test (count $pos_args) = 1
		set base_dir $pos_args[1]

		# Do some smart mappings to standard base directories.
		switch $base_dir
			case 'docs'
				set base_dir ~/Documents/
		end

	# Ensure we didn't get more than one positional argument.
	else if test (count $pos_args) -gt 1
		echo "Error: expected no more than one argument; received: $argv" 1>&2
		return 1
	end

	fd . $base_dir --type d 2> /dev/null | fzf $flags | read -f target_dir

	if test -n "$target_dir"
		cd "$target_dir"
	end
end
