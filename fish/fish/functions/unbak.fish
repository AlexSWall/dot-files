function unbak --description 'Restores a file or directory.'

	# == Begin Validation ==

	function usage -a error_msg
		if test -n "$error_msg"
			printf "Error: $error_msg.\n\n"
		end
		echo 'Restore a backed-up file or directory.'
		echo ''
		echo 'Usage:'
		echo ''
		echo '    unbak <path> [backup-postfix]'
		echo '    unbak -h/--help'
		echo ''
		echo 'Description:'
		echo ''
		echo '    Here, a backed-up file/directory is off the form'
		echo '        <original-name>.bak[.<optional-postfix>]'
		echo ''
		echo '    If both a path and backup postfix are given, a backup of the form'
		echo '        <path-given>.bak.<postfix>'
		echo '    is found and used.'
		echo '    As a special case, if <postfix> is 0, <path-given>.bak is used instead.'
		echo ''
		echo '    Else, if the path is in the format of a backup, the postfix is stripped to'
		echo '    restore the file/directory to.'
		echo ''
		echo '    Else, the path is considered to be the result of a restore and the backup is'
		echo '    deduced; the most recent backup (i.e. highest number) is used.'
		echo ''
		echo '    Confirmation will be obtained before overwriting if a file/directory already'
		echo '    exists at the target restore filepath.'
		echo ''
		echo 'Options:'
		echo ''
		echo '    -h/--help'
		echo '        Print this usage string and exit.'
		echo ''
	end

	argparse --name 'bak' 'h/help' -- $argv
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

	# We'll determine the path to back up -from and -to based on the arguments
	# provided, and then set these variables accordingly.
	set -l restore_from
	set -l restore_to

	if test -n "$postfix"

		# We were given $postfix, so use it as a postfix.
		# Include a special case of being given 0, in which case we just use the
		# .bak postfix
		if test $postfix = '0'
			set restore_from "$filepath.bak"
		else
			set restore_from "$filepath.bak.$postfix"
		end
		set restore_to "$filepath"

	else if string match -q -r '(?<restore_to>.*)\.bak(\..+)?$' $filepath > /dev/null
		# Our filepath matches a backup file filepath and the above has set
		# $restore_to, so just set $restore_from to be $filepath.
		set restore_from "$filepath"

	else
		# We've been given neither a postfix nor a backup-from filepath.
		# Assume we've been given a backup-to filepath and find a backup-from
		# filepath.
		set restore_to "$filepath"

		for i in (seq 100 -1 1)
			if test -e "$filepath.bak.$i"
				set restore_from "$filepath.bak.$i"
				break
			end
		end

		# If we haven't found a backup with a numeric postfix, 'guess' a standard
		# .bak postfix.
		if test -z "$restore_from"
			set restore_from "$filepath.bak"
		end
	end

	# $restore_from and $restore_to should now be set.
	# Ensure that they are and do final checks on them.

	if test -z "$restore_to"
		usage 'Failed to determine filepath to restore to' && return 1
	end
	if ! test -e "$restore_from"
		usage "Backup file $restore_from does not exist" && return 1
	end

	# If we'd be overwriting another file/directory, get user confirmation.
	if test -e "$restore_to"

		echo "This will overwrite '$restore_to' with '$restore_from'."
		echo ''
		read -l -P "Are you sure? [y/N] " confirm

		switch (string lower $confirm)
			case y ye yes
				# Continue.
			case '*'
				echo 'Cancelling...'
				return 1
		end

		rm -rf "$restore_to"
	end

	# Finally perform the restoration.
	cp -r "$restore_from" "$restore_to"
end

complete -c unbak -s h -l help -d 'Print the usage string and exit'
