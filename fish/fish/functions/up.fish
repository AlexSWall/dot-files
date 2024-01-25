function up
	# Support negative jumps, e.g. up -3 to go up until at depth three.
	argparse --name up 1/1 2/2 3/3 4/4 5/5 6/6 7/7 8/8 9/9 -- $argv
	or return

	if test (count $argv) -eq 1
		cd (printf '../%.0s' (seq 1 $argv[1]))
		return
	end

	set -l num_dirs_desired '0'
	if set -q _flag_1
		set num_dirs_desired '1'
	else if set -q _flag_2
		set num_dirs_desired '2'
	else if set -q _flag_3
		set num_dirs_desired '3'
	else if set -q _flag_4
		set num_dirs_desired '4'
	else if set -q _flag_5
		set num_dirs_desired '5'
	else if set -q _flag_6
		set num_dirs_desired '6'
	else if set -q _flag_7
		set num_dirs_desired '7'
	else if set -q _flag_8
		set num_dirs_desired '8'
	else if set -q _flag_9
		set num_dirs_desired '9'
	else if test (count $argv) -eq 0
		cd ..
		return
	else
		echo 'Usage:'
		echo '    $ up  N   Go up N directories.'
		echo '    $ up -N   Go up until N directories deep.'
		return 1
	end

	set -l num_dirs_currently (math (count (string split '/' (pwd))) - 1)

	if test $num_dirs_currently -lt $num_dirs_desired
		echo "Error: Currently nested $num_dirs_currently directories deep, so cannot go 'down' to $num_dirs_desired directories deep."
		return 1
	end

	set -l dir_array (string split '/' (pwd))
	set -l destination (string join '/' $dir_array[1..(math $num_dirs_desired + 1)])
	cd $destination
end
