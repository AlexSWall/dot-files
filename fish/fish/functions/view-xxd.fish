function view-xxd

	# If we have no arguments, automatically consider all files in the current
	# directory.
	if test (count $argv) -eq 0
		set $argv ./*
	end

	# Create a temporary directory in which to store temporary files.
	set dir (mktemp -d)

	# Array for storing the file names of the files containing the `xxd` outputs.
	set outfiles

	for file in $argv
		# Create a name for the temporary file by taking the file, removing any
		# leading dot, and replacing any slashes with underscores.
		set outfile (string replace --all '/' '__' (string replace --regex '^\.' '_' $file))

		# Save the output of xxd for this file to its temporary file.
		xxd "$file" > "$dir/$outfile"

		# Accumulate all of the temporary output files.
		set -a outfiles "$dir/$outfile"
	end

	# View the xxd outputs.
	vim $outfiles

	# Tidy up the temporary files.
	rm -r $dir
end
