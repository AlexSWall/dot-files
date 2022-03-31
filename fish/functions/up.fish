function up
	cd (printf '../%.0s' (seq 1 $argv[1]))
end
