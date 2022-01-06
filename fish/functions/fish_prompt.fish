function fish_prompt
	# This prompt shows, in addition to standard,
	# - the current virtual environment, if any
	# - the current git status, if any, with fish_git_prompt
	# - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
	# - current background jobs, if any
	#
	# ┬─(nim@Hattori:~/w/dashboard)─(11:37:14)─(V:django20)─(G:master↑1|●1✚1…1)─(B:85%, 05:41:42 remaining)
	# │ 2    15054    0%    arrêtée    sleep 100000
	# │ 1    15048    0%    arrêtée    sleep 100000
	# ╰─>$ echo there

	# Must be at the beginning to capture an accurate value of `$status`.
	set -l last_cmd_was_error 'yes'
	test $status = 0
		and set -l last_cmd_was_error 'no'

	# If we have a previous command it it was empty, we just want empty space, so
	# add an extra new line.
	if set -q _PREV_COMMAND_LEN; and test "$_PREV_COMMAND_LEN" -eq '0'
		echo
	end

	# Set non-standard colours.
	set gold ccc404
	set light_blue a0e0ff

	set -q __fish_git_prompt_showupstream
		or set -g __fish_git_prompt_showupstream auto

	function _nim_prompt_wrapper
		set value_color $argv[1]
		set -l field_name $argv[2]
		set -l field_value $argv[3]

		set_color normal
		set_color green
		echo -n '─'
		set_color cyan
		echo -n '('

		set_color normal
		test -n $field_name
			and echo -n $field_name:

		set_color $value_color
		echo -n $field_value

		set_color cyan
		echo -n ')'
	end

	# If _NO_NEW_LINE_BEFORE_PROMPT has been set (by the 'clear' command)...
	if set -q _NO_NEW_LINE_BEFORE_PROMPT; or test "$_NEW_FISH_PROMPT" != 'no'
		# ...print no new line, ...
	else
		# ...else print a new line.
		echo ''
	end

	set_color green
	echo -n '┌──'
	set_color cyan
	echo -n '('

	if functions -q fish_is_root_user; and fish_is_root_user
		set_color red
	else
		set_color $gold
	end

	echo -n $USER
	set_color grey
	echo -n '@'

	if [ ! -z "$SSH_CLIENT" ]
		set_color -o $white
		echo -n '*'
		set_color normal
	end

	set_color $gold
	echo -n $HOST
	set_color cyan
	echo -n ')'
	set_color green
	echo -n '─'

	set_color cyan
	echo -n '['
	set_color eee
	echo -n (prompt_pwd)
	set_color cyan
	echo -n ']'


	# Date
	# _nim_prompt_wrapper $light_blue '' (date +%X)


	# Vi-mode
	# The default mode prompt would be prefixed, which ruins our alignment.
	function fish_mode_prompt
	end

	if test "$fish_key_bindings" = fish_vi_key_bindings
	or test "$fish_key_bindings" = fish_hybrid_key_bindings
		set -l mode
		switch $fish_bind_mode
			case default
				set mode (set_color --bold red)N
			case insert
				set mode (set_color --bold 00c000)I
			case replace_one
				set mode (set_color --bold blue)R
			case replace
				set mode (set_color --bold cyan)R
			case visual
				set mode (set_color --bold magenta)V
		end
		set mode $mode(set_color normal)
		_nim_prompt_wrapper green '' $mode
	end


	# Virtual Environment
	set -q VIRTUAL_ENV_DISABLE_PROMPT
		or set -g VIRTUAL_ENV_DISABLE_PROMPT true
	set -q VIRTUAL_ENV
		and _nim_prompt_wrapper green V (basename "$VIRTUAL_ENV")


	# git
	set -l prompt_git (fish_git_prompt '%s')
	test -n "$prompt_git"
		and _nim_prompt_wrapper cdf '' (set_color --bold)~$prompt_git(set_color normal)


	# Battery status
	type -q acpi
		and test (acpi -a 2> /dev/null | string match -r off)
		and _nim_prompt_wrapper green B (acpi -b | cut -d' ' -f 4-)


	# Set a tick/cross if a command was just run, depending on return code of
	# the command.
	if set -q _PREV_COMMAND_LEN; and not test "$_PREV_COMMAND_LEN" -eq '0'
		if test $last_cmd_was_error = 'no'
			set_color green
			echo -n '  ✓'
		else
			set_color red
			echo -n '  ✘'
		end
	end


	# New line
	echo


	# Background jobs
	set_color normal

	for job in (jobs)
		set_color green
		echo -n '│ '
		set_color brown
		echo $job
	end


	# End
	set_color normal
	set_color green
	echo -n '└─'
	set_color $gold
	echo -n '$ '
	set_color normal

	set -e _EMPTY_COMMAND
end
