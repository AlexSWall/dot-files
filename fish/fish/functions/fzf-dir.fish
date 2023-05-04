# Changes to another directory using fzf.
function fzf-dir
	set --local dir (fd . --type d 2> /dev/null | fzf)
	if test -n "$dir"
		cd "$dir"
	end
end
