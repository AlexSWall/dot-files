function pwd_alias_expansion
	switch (commandline)
		case "*(pwd*"
			return 1
		case '*'
			echo "$(pwd)/"
	end
end
