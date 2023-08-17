# General
abbr --add l 'ls'
abbr --add sl 'ls'
abbr --add s ''
abbr --add c 'clear'
abbr --add ear 'clear'
abbr --add v 'nvim'
abbr --add --position 'anywhere' --function 'pwd_alias_expansion' 'pwd'

# Folder Traversal
abbr --add desk 'cd ~/Desktop'
abbr --add docs 'cd ~/Documents'
abbr --add down 'cd ~/Downloads'
abbr --add pics 'cd ~/Pictures'
abbr --add '-' 'cd -'
abbr --add '..' 'cd ..'

# Dotfiles Helpers
abbr --add 'dfs' 'cd ~/.dot-files'
abbr --add 'fish-fns' 'cd ~/.dot-files/fish/fish/functions'
abbr --add 'abbrs' 'vim ~/.dot-files/fish/fish/conf.d/aliases.fish'

# Git Abbreviations
abbr --add g 'git'
abbr --add t 'git'
abbr --add ga 'git add'
abbr --add gap 'git add -p'
abbr --add gco 'git checkout'
abbr --add gcm 'git commit'
abbr --add gd 'git diff'
abbr --add gdc 'git diff --cached'
abbr --add gdu 'git-diff-untracked'
abbr --add gl 'git l'
abbr --add gs 'git status'
abbr --add gp 'git push'
abbr --add gps 'git push --set-upstream origin'
abbr --add gd0 'git d0'
abbr --add gd1 'git d1'
abbr --add gd2 'git d2'
abbr --add gd3 'git d3'
abbr --add gd4 'git d4'
abbr --add gd5 'git d5'
abbr --add gd6 'git d6'
abbr --add gd7 'git d7'
abbr --add gd8 'git d8'
abbr --add gd9 'git d9'

# Hex
abbr --add hx 'xxd -p'

# Networking
abbr --add wget 'curl -fLsS --no-clobber --remote-name-all'

# Miscellaneous
alias bat 'batcat'
alias fd 'fdfind'
