function unbak --description 'Restores a file or directory.'

	# == Begin Validation ==

	function usage
		echo 'Restores a backed-up file or directory.'
		echo ''
		echo 'Usage:'
		echo '    unbak <file/directory path to create a backup for> [backup number]'
		echo '    unbak -h/--help'
		echo ''
		echo '    -h/--help'
		echo '        Prints this usage string and exits.'
	end

	argparse --name 'unbak' 'h/help' -- $argv
	or usage && return 1

	if set -q _flag_help
		usage && return
	end

	if test (count $argv) -eq 0 -o (count $argv) -gt 2
		usage && return 1
	end

	set -l FILEPATH $argv[1]
	set -l NUM $argv[2]

	# == End Validation ==

	set -l postfix
	if test -z $NUM
		set postfix ''
	else
		set postfix .$NUM
	end

	if string match -q -r ".*\.bak\.\d\d?" $FILEPATH > /dev/null
		# We have the backup's filepath.
		# Obtain the $RESTORE_PATH by stripping off ".bak$postfix".
		string match -q -r "(?<RESTORE_PATH>.*).bak$postfix" $FILEPATH

		if test -z $RESTORE_PATH
			echo "Failed to deduce RESTORE_PATH by stripping off .bak$postfix"
		end

		rm -rf $RESTORE_PATH
		cp -r $FILEPATH $RESTORE_PATH

	else
		# We have the file's filepath, maybe with a postfix number.
		rm -rf $FILEPATH
		cp -r "$FILEPATH.bak$postfix" "$FILEPATH"
	end
end
