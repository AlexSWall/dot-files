function bak --description 'Backs up a file or directory.'

	# == Begin Validation ==

	function usage
		echo 'Back up a file or directory.'
		echo ''
		echo 'Usage:'
		echo '    bak [-m/--mv] <file/directory path to create a backup for>'
		echo '    bak -h/--help'
		echo ''
		echo '    -h/--help'
		echo '        Prints this usage string and exits.'
		echo ''
		echo '    -m/--mv'
		echo '        Optionally, moves the file instead of copying it.'
	end

	argparse --name 'bak' 'm/mv' 'h/help' -- $argv
	or usage && return 1

	if set -q _flag_help
		usage && return
	end

	if not test (count $argv) -eq 1
		usage && return 1
	end

	set -l FILEPATH $argv[1]

	# == End Validation ==

	# Ensure we don't overwrite an existing backup.
	#
	# We also ensure we don't add a postfix which is smaller than an existing
	# backup postfix by counting down from 100 until we find a postfix that
	# exists, if any, and setting our new postfix to one above it.

	set -l postfix ''  # Initially empty; only set if we have existing backups.

	if test -e $FILEPATH.bak
		for i in (seq 100 -1 1)
			if test -e $FILEPATH.bak.$i
				set postfix .(math $i + 1)
				break
			end
		end

		# Handle special case where $FILEPATH.bak was taken but no
		# $FILEPATH.bak.$i were taken - this means we want to use the first
		# $FILEPATH.bak.$i, so we set the prefix to '.1'.
		if test -z $postfix
			set postfix '.1'
		end
	end

	# By default, (recursively) copy, but move if --mv is set.
	set -l cmd cp -r
	if set -q _flag_mv
		set cmd mv
	end

	command $cmd $FILEPATH $FILEPATH.bak$postfix
end
