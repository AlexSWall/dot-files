function fcd --description 'Change to another directory using fzf'

	fzfd $argv | read -f target_dir

	if test -n "$target_dir"
		cd "$target_dir"
	end
end
