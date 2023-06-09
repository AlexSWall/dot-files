# General
abbr --add l 'ls'
abbr --add sl 'ls'
abbr --add s ''
abbr --add c 'clear'
abbr --add v 'nvim'
abbr --add vf 'fzf | xargs nvim'
abbr --add --position 'anywhere' --function 'pwd_alias_expansion' 'pwd'

# Folder Traversal
abbr --add desk 'cd ~/Desktop'
abbr --add docs 'cd ~/Documents'
abbr --add down 'cd ~/Downloads'
abbr --add pics 'cd ~/Pictures'
abbr --add '-' 'cd -'
abbr --add '..' 'cd ..'

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

# Hex
abbr --add hx 'xxd -p'

# Networking
abbr --add wget 'curl -fLsS --no-clobber --remote-name-all'
