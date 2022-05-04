# Enable `!!`, `$$`, `!$`, `<text>!$`, and `$?`.
#   (Including all with backslashes in the middle for literal text.)

# Enables `!!`
function bind_bang

	switch (commandline --current-token)[-1]

		# `!\!`
		# (for typing literal `!!`)
		case "*!\\"
			commandline --current-token -- (echo -ns (commandline --current-token)[-1] | sed 's/.$//')
			commandline --insert '!'

		# `!!`
		case "!"
			commandline --current-token -- $history[1]
			commandline --function repaint

		# Otherwise
		case "*"
			commandline --insert '!'

	end
end

# Enables `!$` and `$$`
function bind_dollar

	switch (commandline --current-token)[-1]

		# `$\$` and `!\$`
		# (for typing literal `!$` and `$$`)
		case "*\$\\" "*!\\"
			commandline --current-token -- (echo -ns (commandline --current-token)[-1] | sed 's/.$//')
			commandline --insert '$'

		# `$$`
		case '$'
			commandline --current-token ""
			commandline --insert (echo '$fish_pid')

		# `!$`
		case "!"
			commandline --current-token ""
			commandline --function history-token-search-backward

		# `<text>!$`
		#
		# If `!$` is preceded by text, search backward for tokens that contain
		# the text as a substring.
		# E.g., if we'd previously run
		#
		#   git checkout -b a_feature_branch
		#   git checkout master
		#
		# then the `fea!$` in the following would be replaced with
		# `a_feature_branch`
		#
		#   git branch -d fea!$
		#
		# and our command line would look like
		#
		#   git branch -d a_feature_branch
		#
		case "*!"
			commandline --current-token -- (echo -ns (commandline --current-token)[-1] | sed 's/.$//')
			commandline --function history-token-search-backward

		# Otherwise
		case "*"
			commandline --insert '$'

	end
end

# Enables $?
function bind_question_mark

	switch (commandline --current-token)[-1]

		# `$\?`
		# (for typing literal `$?`)
		case "*\$\\"
			commandline --current-token -- (echo -ns (commandline --current-token)[-1] | sed 's/.$//')
			commandline --insert '?'

		case "\$"
			commandline --current-token ""
			commandline --insert (echo '$status')

		case "*"
			commandline --insert '?'

	end
end

# Enable `!!`, `$$`, `!$`, `<text>!$`, and `$?`.
#   (Including all with backslashes in the middle for literal text.)
function fish_user_key_bindings
	bind -M insert !    bind_bang
	bind -M insert '$'  bind_dollar
	bind -M insert '?'  bind_question_mark
end
