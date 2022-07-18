function poptmp
	if popd
		# Location of temporary folders varies between OSes, so set regex for
		# checking whether path is in temporary files/folders directory.
		switch (uname -s)
			case 'Darwin'
				set REGEX "/var/folders/[a-zA-Z0-9]{2}/[^/]+/[a-zA-Z0-9]/tmp\.[^/]*/?"

			case 'Linux'
				set REGEX "/tmp/tmp[^/]*/?"

			case '*'
				echo 'OS is neither Darwin nor Linux; cannot check for temp folder.'
				return 1
		end

		# Check this regex matches the previous directory path.
		set MATCH (echo $dirprev[-1] | grep -oE "$REGEX")
		if test -n "$MATCH"
			# It matches, so delete the extracted regex match.
			rm -rf "$MATCH"
			echo 'Deleted temporary folder.'
		else
			# No matches
			echo 'Previous working directory not in a temporary folder; will not delete it.'
		end
	end
end
