function vim-open --description 'Opens many files conforming to a given glob or regex.'

	if test (count $argv) = 1
		set DIRECTORY '.'
		set REGEX_OR_GLOB $argv[1]

	else if test (count $argv) = 2
		set DIRECTORY $argv[1]
		set REGEX_OR_GLOB $argv[2]

	else
		echo 'Usage: vimdiff [directory] regex-or-glob-string'
		echo 'Number of arguments given:' (count $argv)
		return 1
	end

	# Check whether interpreting as a regex gives results...
	set FILES (find -E "$DIRECTORY" -regex "$REGEX_OR_GLOB" \( -type l -o -type f \) 2>/dev/null)

	if test ! -z "$FILES"
		#echo 'Interpreting input as a regular expression.'

	else
		# Check whether interpreting as a regex with ".*/" prefixed gives
		# results...
		set FILES (find -E "$DIRECTORY" -regex ".*/$REGEX_OR_GLOB" \( -type l -o -type f \) 2>/dev/null)

		if test ! -z "$FILES"
			#echo 'Interpreting input as a regular expression, adding a ".*/" prefix.'

		else
			# Regexes failed, assume it's meant to be a glob...

			#echo 'Interpreting input as a glob.'
			set FILES (find "$DIRECTORY" -name "$REGEX_OR_GLOB" \( -type l -o -type f \) 2>/dev/null)
		end
	end

	if test ! -z "$FILES"
		vim $FILES
	else
		echo 'No matches'
	end
end
