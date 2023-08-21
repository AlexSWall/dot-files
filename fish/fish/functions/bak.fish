function bak --description 'Backs up a file or directory.'

	# == Begin Validation ==

	function usage -a error_msg
		if test -n "$error_msg"
			printf "Error: $error_msg.\n\n"
		end
		echo 'Back up a file or directory.'
		echo ''
		echo 'Usage:'
		echo ''
		echo '    bak [-m/--mv] <path> [optional-postfix]'
		echo '    bak -h/--help'
		echo ''
		echo 'Description:'
		echo ''
		echo '    Here, a backed-up file/directory is off the form'
		echo '        <original-name>.bak[.<optional-postfix>]'
		echo ''
		echo '    Given the file/directory path, a backup is created by copying, or moving if'
		echo '    --mv is given, the file/directory to the same filepath with .bak appended.'
		echo ''
		echo '    If a postfix argument has been given, .<optional-postfix> will also be'
		echo '    appended.'
		echo ''
		echo '    If such a filepath already exists (and a numeric postfix was not provided),'
		echo '    a dot and number is appended. The number used is the smallest positive'
		echo '    number bigger than any existing backup (up to 99).'
		echo ''
		echo 'Options:'
		echo ''
		echo '    -h/--help'
		echo '        Print this usage string and exit.'
		echo ''
		echo '    -m/--mv'
		echo '        Move the file instead of copying it.'
	end

	argparse --name 'bak' 'm/mv' 'h/help' -- $argv
	or echo && usage && return 1

	if set -q _flag_help
		usage && return
	end

	if test (count $argv) -eq 0 -o (count $argv) -gt 2
		usage 'Incorrect number of arguments provided' && return 1
	end

	set -l filepath $argv[1]  # Required
	set -l postfix  $argv[2]  # Optional
	set -e argv

	if test -z "$filepath"
		usage 'Filepath cannot be empty' && return 1
	end

	# == End Validation ==

	# Ensure we strip trailing backslashes (if filepath is a directory).
	if test (string split '' $filepath)[-1] = '/'
		if not test -d $filepath
			usage 'Filepath with trailing slash given, but directory not found' && return 1
		end
		set filepath (string trim --right --chars '/' $filepath)
	end

	# Ensure we don't overwrite an existing backup.
	#
	# We also ensure we don't add a postfix which is smaller than an existing
	# backup postfix by counting down from 100 until we find a postfix that
	# exists, if any, and setting our new postfix to one above it.

	set -l backup_to "$filepath.bak"
	if test -n "$postfix"
		set backup_to "$filepath.bak.$postfix"
	end

	if string match -q -r '^\d\d?$' "$postfix" > /dev/null
		# Our postfix given is a number; don't try to avoid a clash by appending a
		# numeric postfix.
	else
		# Our postfix (if any) is not a number; ensure we avoid clashes.

		if test -e "$backup_to"

			set -l clash_avoidance_done false

			for i in (seq 100 -1 1)
				if test -e "$backup_to.$i"
					set numeric_postfix (math $i + 1)
					set backup_to "$backup_to.$numeric_postfix"
					set clash_avoidance_done true
					break
				end
			end

			# Handle special case where $filepath.bak was taken but no
			# $filepath.bak.$i were taken - this means we want to use the first
			# $filepath.bak.$i, so we set the prefix to '.1'.
			if not $clash_avoidance_done
				set backup_to "$backup_to.1"
			end
		end
	end

	# By default, (recursively) copy, but move if --mv is set.
	set -l cmd cp -r
	if set -q _flag_mv
		set cmd mv
	end

	# If we'd be overwriting another file/directory, get user confirmation.
	if test -e "$backup_to"

		echo "This will overwrite '$backup_to' with '$filepath'."
		echo ''
		read -l -P "Are you sure? [y/N] " confirm

		switch (string lower $confirm)
			case y ye yes
				# Continue.
			case '*'
				echo 'Cancelling...'
				return 1
		end

		rm -rf "$backup_to"
	end

	# Finally perform the back-up.
	$cmd "$filepath" "$backup_to"
end

complete -c bak -s m -l mv -d 'Move the file instead of copying it'
complete -c bak -s h -l help -d 'Print the usage string and exit'
