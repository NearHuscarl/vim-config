#!/bin/env bash

# This script is part of vim-config
# Run to setup vim-config for vim and neovim on windows

# Requirement:
# MinGW

# Note: if you have git installed. It already included
# MinGW. Right click and select 'Git bash'

os=$(uname -s)
if [[ "$os" =~ 'CYGWIN' ]] || [[ "$os" =~ 'MINGW' ]]; then
	vim_path="$HOME/vimfiles"
elif [[ "$os" == 'Linux' ]]; then
	vim_path="$HOME/.vim"
fi

cwd="$PWD"
vimplug_path="$vim_path/autoload/plug.vim"
dirs="plugged session swapfiles undo"

# If not in $vim_path now, copy content to that destination
if [[ "$cwd" != "$vim_path" ]]; then
	echo "copy $cwd to $vim_path"
	cp -r "$cwd" "$vim_path"
fi

# Make necessary directories if not exists
for dir in $dirs; do
	if [[ ! -d "$vim_path"/"$dir" ]]; then
		echo "creating $vim_path/$dir"
		mkdir -p "$vim_path"/"$dir"
	fi
done

# Download plug.vim if not exists
if [[ ! -s "$vimplug_path" ]]; then
	echo '>>> Downloading plug.vim'
	curl -o "$vimplug_path" 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# -- Setup for neovim --
# what does -s mean??
nvim_path='C:/Users/Near/AppData/Local/nvim'
if [[ ! -s "$nvim_path/init.vim" ]]; then
	mkdir -p "$nvim_path"
	echo '>>> Downloading init.vim for neovim'
	curl -o "$nvim_path/init.vim" 'https://raw.githubusercontent.com/NearHuscarl/dotfiles/master/.config/nvim/init.vim'
fi

# Install neovim for python and javascript if unavailable
if ! python -c 'import neovim' 2> /dev/null; then
	echo
	echo '>>> Install neovim for python'
	pip install neovim 2> /dev/null
fi

if ! npm list --depth 0 --global neovim &> /dev/null; then
	echo
	echo '>>> Install neovim for javascript'
	npm install --global neovim 2> /dev/null
fi
