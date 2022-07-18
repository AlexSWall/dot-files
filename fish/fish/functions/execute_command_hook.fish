function execute_command_hook

	set -g _NEW_FISH_PROMPT 'no'

	# Trim and store contents of command line.
	set -l command_trimmed (string trim (commandline))

	# Set _EMPTY_COMMAND if command being run is empty.
	# if not set -q command_trimmed; or test "$command_trimmed" = ''
	set -g _PREV_COMMAND_LEN (string length "$command_trimmed")

	# Set _NO_NEW_LINE_BEFORE_PROMPT if `clear` was not run.
	# This is done here to ensure we don't add a new line prefix after changing
	# vim mode (which re-runs fish_prompt to update the prompt).
	if test "$command_trimmed" != 'clear'
		set -e _NO_NEW_LINE_BEFORE_PROMPT
	end

	# Run command on command line.
	commandline -f execute
end
