function git-diff-untracked -d "View files not tracked by git"

	argparse h/help n/name-only -- $argv
	or return  # exit if argparse found an option it didn't recognize.

	if set -ql _flag_help
		echo "Description:"
		echo \t"View files not tracked by git."
		echo ""
		echo "Usage:"
		echo \t"$(status current-function) [-h|--help] [-n|--name-only] [directories...]"
		echo ""
		echo "Options:"
		echo \t"-h/--help"
		echo \t\t"Show this help text."
		echo ""
		echo \t"-n/--name-only"
		echo \t\t"Only display the names of the untracked files."
		echo ""
		echo "Arguments:"
		echo \t"directories..."
		echo \t\t"The directories to check for untracked files in."
		echo \t\t"Defaults to to the current directory."
		return 0
	end

	# Default to all contents of the current folder.
	if test (count $argv) -eq 0
		set argv '.'
	end

	set -l cmd 'git' 'ls-files' '--others' '--exclude-standard'
	set -l files ($cmd)

	if test (count $files) -eq 0
		if ! set -ql _flag_name_only
			echo 'No untracked files in the current directory.'
		end
		return
	end

	set -l desired_files
	for file in $files
		for path in $argv
			switch $(realpath $file)
				case "$(realpath $path)*"
					set -a desired_files $file
			end
		end
	end

	if test (count $files) -eq 0
		if ! set -ql _flag_name_only
			echo 'No untracked files after filtering.'
		end
		return
	end

	# We have untracked files included in our filter - show.
	if set -ql _flag_name_only
		printf "%s\n" $desired_files
	else
		bat --paging 'always' $desired_files
	end
end
