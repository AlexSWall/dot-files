function view-pem

	# If we have no arguments, automatically consider all PEM files in the
	# current directory.
	if test (count $argv) -eq 0
		set $argv ./*.pem
	end

	# Create a temporary directory in which to store temporary files.
	set dir (mktemp -d)

	# Array for storing the file names of the files containing the output of the
	# `openssl x509` commands.
	set outfiles

	for file in $argv
		# Create a name for the temporary file by taking the file, removing any
		# leading dot, and replacing any slashes with underscores.
		set outfile (string replace --all '/' '__' (string replace --regex '^\.' '_' $file))

		# Find all of the instances of CERTIFICATE-----.
		# These come in pairs; the first of each pair will be START and the second
		# will be END.
		# Treat the certificates separately and concatenate the outputs together.
		set positions (grep -n -- ' CERTIFICATE-----' $file | awk -F: '{print $1}')
		for i in (seq (math (count $positions) / 2))
			# This command extracts the certificate from the $i-th BEGIN
			# CERTIFICATE to the $i-th END CERTIFICATE (using tail and head) and
			# passes this to an openssl command to be parsed and have the output
			# saved to the temporary output file.
			set start $positions[(math 2 x $i - 1 )]
			set end   $positions[(math 2 x $i     )]
			openssl x509 \
				-in (tail -n +$start $file | head -n (echo (math $end - $start + 1)) | psub) \
				-inform pem \
				-noout \
				-text >> "$dir/$outfile"
		end

		# Accumulate all of the temporary output files.
		set -a outfiles "$dir/$outfile"
	end

	# View the openssl outputs.
	vim $outfiles

	# Tidy up the temporary files.
	rm -r $dir
end
