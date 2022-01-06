function clear
	# Set _NO_NEW_LINE_BEFORE_PROMPT as we've run `clear`.
	set -g -x _NO_NEW_LINE_BEFORE_PROMPT 1
	/usr/bin/clear
end
