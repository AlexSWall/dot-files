#!/bin/bash

PWD="$(pwd)"

# Home directory dotfiles
rm -rf "$HOME/.bashrc"
ln -s "$PWD/.bashrc" "$HOME/.bashrc"
rm -rf "$HOME/.vimrc"
ln -s "$PWD/.vimrc" "$HOME/.vimrc"
rm -rf "$HOME/.tmux.conf"
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"
rm -rf "$HOME/.gitconfig"
ln -s "$PWD/.gitconfig" "$HOME/.gitconfig"

# Vim Monokai
mkdir -p "$HOME/.vim/colors"
rm -rf "$HOME/.vim/colors/monokai.vim"
ln -s "$PWD/monokai.vim" "$HOME/.vim/colors/monokai.vim"

# Nvim
mkdir -p "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/init.vim"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
rm -rf "$HOME/.config/nvim/coc-settings.json"
ln -s "$PWD/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
