#!/bin/bash

PWD="$(pwd)"
OLD="$(pwd)/old"
mkdir -p "$OLD"

# == Home directory dotfiles ==
for f in .bashrc .vimrc .tmux.conf .gitconfig
do
	if [ -e "$HOME/$f" ]; then
		mv "$HOME/$f" "$OLD/$f"
	fi
	ln -s "$PWD/$f" "$HOME/$f"
done

# == Monokai ==
mkdir -p "$HOME/.vim/colors"
if [ -e "$HOME/.vim/colors/monokai.vim" ]; then
	mv "$HOME/.vim/colors/monokai.vim" "$OLD/monokai.vim"
fi
ln -s "$PWD/monokai.vim" "$HOME/.vim/colors/monokai.vim"

# == Neovim ==
mkdir -p "$HOME/.config/nvim"
# init.vim
if [ -e "$HOME/.config/nvim/init.vim" ]; then
	mv "$HOME/.config/nvim/init.vim" "$OLD/init.vim"
fi
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
# coc-settings.json
if [ -e "$HOME/.config/nvim/coc-settings.json" ]; then
	mv "$HOME/.config/nvim/coc-settings.json" "$OLD/coc-settings.json"
fi
ln -s "$PWD/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

# == Neovim plugins ==
# mkdir -p "$HOME/.local/share/nvim/site"

# if [ -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
# 	ln -s "$HOME/.vim/autoload" "$HOME/.local/share/nvim/site/autoload"
# fi

if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
		 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	echo "Install nodejs, npm, and yarn for neovim"
fi

# == Tmux plugins ==

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi