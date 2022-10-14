function unbak --argument-names FILEPATH

	if not test (count $argv) -eq 1
		echo 'Usage: unbak <file to restore from backup>'
		return 1
	end

	if string match '*.bak' $FILEPATH > /dev/null
		cp "$FILEPATH" (path change-extension '' $FILEPATH)
	else
		cp "$FILEPATH.bak" "$FILEPATH"
	end
end
