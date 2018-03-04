#!/bin/env bash

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
	echo 'Downloading plug.vim'
	curl -o "$vimplug_path" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi
