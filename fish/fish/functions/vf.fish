function vf --description 'Open in vim the result of an fzf'
	set -l files (fzf --multi)
	if test -n "$files"
		vim $files
	end
end
