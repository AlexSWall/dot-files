#!/usr/bin/env bash

# Immediately error on command execution failure.
set -e


echo '-----'
echo 'You need to ensure git, curl, fish, and neovim (nvim) are installed.'
echo ''
echo "For installing all LSP servers, you'll also need to install npm."
echo ''
read -r -p 'If/when these are installed, please press enter...'
echo '-----'
echo 'Installing...'

PWD="$(pwd)"
OLD="$(pwd)/old"
rm -rf "$OLD"
mkdir -p "$OLD"

create_symlink () {
	# Arguments
	local DOT_FILES_DIR="$PWD"
	local SRC_PATH="$1"
	local DESTINATION_DIR="$2"

	local FILENAME
	FILENAME="$(basename "$SRC_PATH")"

	# Create destination directory if needed
	mkdir -p "$DESTINATION_DIR"

	# If a symlink exists, delete it
	if [ -L "$DESTINATION_DIR/$FILENAME" ]; then
		rm "$DESTINATION_DIR/$FILENAME"

	# Else if non-symlink file exists, move to $OLD
	elif [ -f "$DESTINATION_DIR/$FILENAME" ]; then
		# Quick hack to make the parent folder
		mkdir -p "$OLD/$FILENAME" && rmdir "$OLD/$FILENAME"

		# Backup the file
		mv "$DESTINATION_DIR/$FILENAME" "$OLD/$FILENAME"
	fi

	# Create symlink
	ln -s "$DOT_FILES_DIR/$SRC_PATH" "$DESTINATION_DIR/$FILENAME"
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

# Bash, Zsh, Fish, Tmux, Git, and Vim
for f in \
	'./sh/.profile' './sh/.shrc' './sh/.aliases' \
	'./bash/.bash_profile' './bash/.bashrc' \
	'./zsh/.zshenv' './zsh/.zshrc' \
	'./fish/.fishrc' \
	'./tmux/.tmux.conf' './tmux/.tmux.inner.conf' './tmux/.tmux.reset.conf' \
	'./git/.gitconfig' \
	'./vim/.vimrc'
do
	create_symlink "$f" "$HOME"
done

# Fish Directory
create_symlink "./fish/fish"            "$HOME/.config"

# Neovim
create_symlink "./neovim/init.lua"      "$HOME/.config/nvim"
create_symlink "./neovim/lua"           "$HOME/.config/nvim"

# Vim Monokai
create_symlink "./vim/monokai.vim"      "$HOME/.vim/colors"

# Pip
create_symlink "./pip/pip.conf"         "$HOME/.config/pip"

# Python
create_symlink "./python/pyflyby"       "$HOME/.config/pyflyby"

# Wezterm
create_symlink "./wezterm/wezterm.lua"  "$HOME/.config/wezterm"


# == Git Repositories ==

# Zsh Plugin: zsh-autosuggestions
create_git_repo "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.zsh/zsh-autosuggestions"

# Zsh Plugin: zsh-syntax-highlighting
create_git_repo "https://github.com/zsh-users/zsh-syntax-highlighting" "$HOME/.zsh/zsh-syntax-highlighting"

# Tmux Package Manager (TPM)
create_git_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"


# == Miscellaneous ==

# Prompt host string
touch "./host.txt"
create_symlink "host.txt" "$HOME/.config"

# Remove shell login spam
touch ~/.hushlogin

# Remove the $OLD directory if it's empty.
if [ -z "$(ls -A "$OLD")" ]; then
   rmdir "$OLD"
fi


# == Finished ==

echo '-----'
echo 'Done!'
echo ''
echo 'You may now also want to install to ensure zsh and tmux are installed.'
echo ''
echo "For installing all LSP servers, you'll also need to install npm."
echo ''
echo 'For full Python support, you will need pyflyby, black, flake8, isort, and pyquotes (pip-)installed.'
echo 'You may also need pylint and mccabe.'
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

