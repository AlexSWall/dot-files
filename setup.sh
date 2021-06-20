#!/bin/bash

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
for f in .bashrc .zshrc .vimrc .tmux.conf .tmux.remote.conf .gitconfig
do
	create_symlink "$f" "$HOME"
done

# Vim/Neovim Monokai
create_symlink "monokai.vim" "$HOME/.vim/colors"

# Neovim
create_symlink "init.vim" "$HOME/.config/nvim"
create_symlink "coc-settings.json" "$HOME/.config/nvim"


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

