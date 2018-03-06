#!/bin/bash

# This script is part of vim-config
# Run to setup vim-config for vim and neovim on windows

# Requirement:
# MinGW

# Note: if you have git installed. It already included
# MinGW. Right click and select 'Git bash'

function get_os() { # {{{
	os=$(uname -s)
	if [[ "$os" =~ 'CYGWIN' ]] || [[ "$os" =~ 'MINGW' ]]; then
		echo 'win'
	elif [[ "$os" == 'Linux' ]]; then
		echo 'linux'
	fi
}
# }}}
function get_vimpath() { # {{{
	local os
	os="$(get_os)"
	if [[ "$os" == 'win' ]]; then
		echo "$HOME/vimfiles"
	elif [[ "$os" == 'linux' ]]; then
		echo "$HOME/.vim"
	fi
}
# }}}
function get_nvimpath() { # {{{
	local os
	os="$(get_os)"
	if [[ "$os" == 'win' ]]; then
		echo 'C:/Users/Near/AppData/Local/nvim'
	elif [[ "$os" == 'linux' ]]; then
		echo "$HOME/.config/nvim"
	fi
}
# }}}


VIM_PATH="$(get_vimpath)"
NVIM_PATH="$(get_nvimpath)"

function move_repo() { # {{{
	# If not in $vim_path now, copy content to that destination
	local cwd="$PWD"
	if [[ "$cwd" != "$VIM_PATH" ]]; then
		echo "copy $cwd to $VIM_PATH"
		cp -r "$cwd" "$VIM_PATH"
	fi
}
# }}}
function create_required_dirs() { # {{{
	local dirs='plugged session swapfiles undo'
	# Make necessary directories if not exists
	for dir in $dirs; do
		if [[ ! -d "$VIM_PATH/$dir" ]]; then
			echo "creating $VIM_PATH/$dir"
			mkdir -p "$VIM_PATH/$dir"
		fi
	done
}
# }}}
function download_plug() { # {{{
	# Download plug.vim if not exists
	if [[ ! -s "$VIM_PATH/autoload/plug.vim" ]]; then
		echo '>>> Downloading plug.vim'
		curl -o "$VIM_PATH/autoload/plug.vim" 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
}
# }}}
function setup_fzf() { # {{{
	# fzf setup
	if [[ ! -s "$VIM_PATH/plugged/fzf/plugin/fzf.vim" ]]; then
		echo
		echo '>>> Download fzf.vim from https://github.com/junegunn/fzf/blob/master/plugin/fzf.vim'
		mkdir -p "$VIM_PATH/plugged/fzf/plugin"
		curl -o "$VIM_PATH/plugged/fzf/plugin/fzf.vim" 'https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim'
	fi
}
# }}}
function download_neovim_init() { # {{{
	if [[ ! -s "$NVIM_PATH/init.vim" ]]; then
		mkdir -p "$NVIM_PATH"
		echo '>>> Downloading init.vim for neovim'
		curl -o "$NVIM_PATH/init.vim" 'https://raw.githubusercontent.com/NearHuscarl/dotfiles/master/.config/nvim/init.vim'
	fi
}
# }}}
function neovim_python() { # {{{
	# Install neovim for python and javascript if unavailable
	if ! python -c 'import neovim' 2> /dev/null; then
		echo
		echo '>>> Install neovim for python'
		pip install neovim 2> /dev/null
	fi
}
# }}}
function neovim_javascript() { # {{{
	if ! npm list --depth 0 --global neovim &> /dev/null; then
		echo
		echo '>>> Install neovim for javascript'
		npm install --global neovim 2> /dev/null
	fi
}
# }}}
function setup_neovim() { # {{{
	download_neovim_init
	neovim_python
	neovim_javascript
}
# }}}
function main() { # {{{
	move_repo
	create_required_dirs
	download_plug
	setup_fzf
	setup_neovim
}
# }}}

main
