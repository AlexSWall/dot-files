function abbr-prefix

	set -l usage "Usage: abbr-prefix <shortest abbr key prefix> <full abbr key> <expansion>"

	if not test (count $argv) -eq 3
		echo $usage && return 1
	end

	set -l start     $argv[1]
	set -l end       $argv[2]
	set -l expansion $argv[3]

	# Check that $end starts with $start
	set -l check (string sub --length (string length $start) $end)
	if test "$start" != "$check"
		echo 'Full abbr key does not begin with shortest abbr key prefix' && echo $usage && return 1
	end

	abbr --add "$end" "$expansion"

	# Repeatedly remove a letter from $end and add that abbreviation, until $end
	# is equal to $start.
	while test "$end" != "$start"
		set end (string sub --end -1 $end)
		abbr --add "$end" "$expansion"
	end
end

# General
abbr --add l 'ls'
abbr --add sl 'ls'
abbr --add s ''
abbr --add cl 'clear'
abbr --add ear 'clear'
abbr --add r 'cd (pwd)'  # Refresh
abbr --add v 'nvim'
abbr --add vimf 'nvim $FZF_LAST_OUTPUT'
abbr --add vimr 'nvim (eval (string split " " (echo $history[1] | sed "s/rg/rg -l/")) ~ sort)'
abbr --add cdf 'cd $FZF_LAST_OUTPUT'
abbr --add cfz 'fcd'
abbr --add crg 'rg -p -C 3 --sort path'
abbr --add watch-size 'watch -n 0.2 du -sh *'
abbr --add --position 'anywhere' --function 'pwd_alias_expansion' 'pwd'

# Folder Traversal
abbr --add desk 'cd ~/Desktop'
abbr --add docs 'cd ~/Documents'
abbr --add down 'cd ~/Downloads'
abbr --add pics 'cd ~/Pictures'
abbr --add dfs  'cd ~/.dot-files'
abbr --add '-'  'cd -'
abbr --add '..' 'cd ..'

# Dotfiles Helpers
abbr --add dotf 'cd ~/.dot-files'
abbr --add 'fish-fns' 'cd ~/.dot-files/fish/fish/functions'
abbr --add 'abbrs' 'vim ~/.dot-files/fish/fish/conf.d/aliases.fish && source ~/.dot-files/fish/fish/conf.d/aliases.fish'

# Coding Helpers
abbr --add touch-all 'for f in (find . -type f); touch $f; end'
abbr --add touch-all-cpp 'for f in (find . -type f -name "*.cpp" -or -name "*.hpp"); touch $f; end'

# Docker Helpers
abbr-prefix dk dkill 'docker kill (docker ps -aq)'     # Kill all containers
abbr --add drm 'docker rm (docker ps -aq)'             # Remove stopped containers
abbr --add drmi 'docker rmi (docker images -a)'        # Remove all images stopped containers
abbr --add dsh 'docker exec -i -t /bin/bash'           # Exec a shell on a container
abbr --add dshr 'docker exec -i -t -u root /bin/bash'  # Exec a shell as root on a container

# Git Abbreviations
abbr --add g      'git'
abbr --add t      'git'
abbr --add ga     'git add'
abbr --add ga-p   'git add -p'
abbr --add gb     'git branch'
abbr --add gbr    'git branch'
abbr --add gcl    'git clone'
abbr --add gcm    'git commit'
abbr --add gcm-a  'git commit --amend'
abbr --add gco    'git checkout'
abbr --add gcom   'git checkout master'
abbr --add gco-   'git checkout -'
abbr --add gco-b  'git checkout -b'
abbr --add gd     'git diff'
abbr --add gdc    'git diff --cached'
abbr --add gdu    'git-diff-untracked'
abbr --add gf     'git fetch'
abbr --add gf-p   'git fetch --prune origin'
abbr --add gl     'git l'
abbr --add glb    'git b'
abbr --add gp     'git push'
abbr --add gpsh   'git push'
abbr --add gpd    'git push origin --delete (git symbolic-ref --short HEAD 2>/dev/null)'
abbr --add gpl    'git pull'
abbr --add grb    'git rebase'
abbr --add grbm   'git rebase master'
abbr --add grb-i  'git rebase -i'
abbr --add grb-im 'git rebase -i master'
abbr --add grsh   'git reset HEAD'
abbr --add grshh  'git reset HEAD --hard'
abbr --add grst   'git restore'
abbr --add grst-p 'git restore -p'
abbr --add grv    'git revert'
abbr --add gs     'git status'
abbr --add gsdr   'git stash drop'
abbr --add gsl    'git stash list'
abbr --add gspo   'git stash pop'
abbr --add gspu   'git stash push'

abbr --add g-r 'git-resolve'

# Git Diff <Num>
abbr --add gd0 'git diff HEAD~1 HEAD~0'
abbr --add gd1 'git diff HEAD~2 HEAD~1'
abbr --add gd2 'git diff HEAD~3 HEAD~2'
abbr --add gd3 'git diff HEAD~4 HEAD~3'
abbr --add gd4 'git diff HEAD~5 HEAD~4'
abbr --add gd5 'git diff HEAD~6 HEAD~5'
abbr --add gd6 'git diff HEAD~7 HEAD~6'
abbr --add gd7 'git diff HEAD~8 HEAD~7'
abbr --add gd8 'git diff HEAD~9 HEAD~8'
abbr --add gd9 'git diff HEAD~10 HEAD~9'

# Git Diff Stash <Num>
abbr --add gds  'git diff stash@{0}~1 stash@{0}'
abbr --add gds0 'git diff stash@{0}~1 stash@{0}'
abbr --add gds1 'git diff stash@{1}~1 stash@{1}'
abbr --add gds2 'git diff stash@{2}~1 stash@{2}'
abbr --add gds3 'git diff stash@{3}~1 stash@{3}'
abbr --add gds4 'git diff stash@{4}~1 stash@{4}'
abbr --add gds5 'git diff stash@{5}~1 stash@{5}'
abbr --add gds6 'git diff stash@{6}~1 stash@{6}'
abbr --add gds7 'git diff stash@{7}~1 stash@{7}'
abbr --add gds8 'git diff stash@{8}~1 stash@{8}'
abbr --add gds9 'git diff stash@{9}~1 stash@{9}'

# Hex
abbr --add hx 'xxd -p'

# Networking
abbr --add wget 'curl -fLsS --no-clobber --remote-name-all'

