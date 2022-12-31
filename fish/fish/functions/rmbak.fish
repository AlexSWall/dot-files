function rmbak --argument-names FILEPATH

	if not test (count $argv) -eq 1
		echo 'Usage: bak <file to backup>'
		return 1
	end

	rm $FILEPATH.bak
end
