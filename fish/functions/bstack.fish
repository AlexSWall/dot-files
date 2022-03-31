function bstack
	git reflog | grep 'checkout:' | cut -d ' ' -f 8 | cat -n | sort -uk2 | sort -n | cut -f2- | head -$argv[1] | cat -n
end
