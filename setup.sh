#!/bin/bash

echo '-----'
echo 'You need to ensure git and curl are installed.'
echo ''
read -p 'If/when these are installed, please press enter...'
echo '-----'

PWD="$(pwd)"
OLD="$(pwd)/old"
mkdir -p "$OLD"

create_symlink () {
	# Arguments
	local FILE="$1"
	local DESTINATION_DIR="$2"

	# Create destination directory if needed
	mkdir -p "$DESTINATION_DIR"

	# If non-symlink file exists, move to $OLD
	if [ -e "$DESTINATION_DIR/$FILE" ]; then
		mv "$DESTINATION_DIR/$FILE" "$OLD/$FILE"

	# Else if a symlink exists, delete it
	elif [ -L "$DESTINATION_DIR/$FILE" ]; then
		rm "$DESTINATION_DIR/$FILE"
	fi

	# Create symlink
	ln -s "$PWD/$FILE" "$DESTINATION_DIR/$FILE"
}

create_git_repo () {
	# Arguments
	local REPO_URL="$1"
	local DESTINATION_DIR="$2"

	if [ ! -d "$DESTINATION_DIR" ]; then
		git clone "$REPO_URL" "$DESTINATION_DIR"
	fi
}

# == Symlinks ==

# Bash, Zsh, Vim, Tmux, and Git
for f in .profile .bash_profile .zshenv .shrc .bashrc .zshrc .fishrc .aliases .vimrc .tmux.conf .tmux.remote.conf .tmux.reset.conf .gitconfig
do
	create_symlink "$f" "$HOME"
done

# Prompt host string
touch "./host.txt"
create_symlink "host.txt" "$HOME/.config"

# Fish
create_symlink "fish" "$HOME/.config"

# Vim/Neovim Monokai
create_symlink "monokai.vim" "$HOME/.vim/colors"

# Neovim
create_symlink "init.vim" "$HOME/.config/nvim"
create_symlink "lua"      "$HOME/.config/nvim"


# == Git Repositories ==

# Zsh Plugin: zsh-autosuggestions
create_git_repo "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.zsh/zsh-autosuggestions"

# Zsh Plugin: zsh-syntax-highlighting
create_git_repo "https://github.com/zsh-users/zsh-syntax-highlighting" "$HOME/.zsh/zsh-syntax-highlighting"

# Tmux Package Manager (TPM)
create_git_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"


# == Neovim Plugins ==

if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
	curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	echo "Install nodejs, npm, and yarn for neovim"
fi


# == Miscellaneous ==

touch ~/.hushlogin


# == Finished ==
echo '-----'
echo 'Done!'
echo ''
echo 'You may now need to install: fish, zsh, neovim, tmux, nodejs, npm, and yarn.'
echo ''
echo ''
echo 'If italics are not working within tmux, you may need to run'
echo ''
echo '```'
echo '$ cat <<EOF|tic -x -'
echo 'tmux|tmux terminal multiplexer,'
echo '        ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,'
echo '        use=xterm+tmux, use=screen,'
echo ''
echo 'tmux-256color|tmux with 256 colors,'
echo '        use=xterm+256setaf, use=tmux,'
echo 'EOF'
echo '```'
echo ''
echo "and ensure 'set -g default-terminal \"tmux\"' is in our ~/.tmux.conf"
echo '-----'

