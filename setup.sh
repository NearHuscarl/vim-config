#!/bin/bash

# This script is part of vim-config
# Run to setup vim-config for vim and neovim on windows

# Requirement:
# MinGW
# pip
# npm

# Note: if you have git installed. It already included
# MinGW. Right click and select 'Git bash'

# COLORS {{{
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
RESET="$(tput sgr0)"
# }}}
print_progress() { #{{{
	# Console width number
	T_COLS="$(tput cols)"
	echo -e " ${GREEN}> $1${RESET}\n" | fold -sw $(($T_COLS - 2))
}
# }}}
print_warning() { #{{{
	T_COLS="$(tput cols)"
	echo -e "  ${YELLOW}$1${RESET}\n" | fold -sw $(($T_COLS - 2))
}
# }}}

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

OS="$(get_os)"
VIM_PATH="$(get_vimpath)"
NVIM_PATH="$(get_nvimpath)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

move_repo() { # {{{
	print_progress "move vim-config to $VIM_PATH"
	if [[ "$SCRIPT_DIR" != "$VIM_PATH" ]]; then
		print_progress "copy $SCRIPT_DIR to $VIM_PATH"
		mv -r "$SCRIPT_DIR" "$VIM_PATH"
	fi
}
# }}}
create_required_dirs() { # {{{
	local dirs='plugged session swapfiles undo'
	# Make necessary directories if not exists
	for dir in $dirs; do
		if [[ ! -d "$VIM_PATH/$dir" ]]; then
			print_progress "creating $VIM_PATH/$dir"
			mkdir -p "$VIM_PATH/$dir"
		fi
	done
}
# }}}
download_plug() { # {{{
	# Download plug.vim if not exists
	if [[ ! -s "$VIM_PATH/autoload/plug.vim" ]]; then
		print_progress 'Downloading plug.vim'
		curl -o "$VIM_PATH/autoload/plug.vim" 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
}
# }}}
setup_fzf() { # {{{
	# fzf setup
	if [[ ! -s "$VIM_PATH/plugged/fzf/plugin/fzf.vim" ]]; then
		print_progress 'Download fzf.vim from https://github.com/junegunn/fzf/blob/master/plugin/fzf.vim'
		mkdir -p "$VIM_PATH/plugged/fzf/plugin"
		curl -o "$VIM_PATH/plugged/fzf/plugin/fzf.vim" 'https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim'
	fi
}
# }}}
download_neovim_init() { # {{{
	if [[ ! -s "$NVIM_PATH/init.vim" ]]; then
		mkdir -p "$NVIM_PATH"
		print_progress 'Downloading init.vim for neovim'
		curl -o "$NVIM_PATH/init.vim" 'https://raw.githubusercontent.com/NearHuscarl/dotfiles/master/.config/nvim/init.vim'
	fi
}
# }}}
install_neovim_module_for_python() { # {{{
	# Install neovim for python and javascript if unavailable
	if ! python -c 'import neovim' 2> /dev/null; then
		print_progress 'Install neovim for python'
		pip install --user neovim
	else
		print_warning 'pip not installed. Skipping install neovim module for python'
	fi
}
# }}}
install_neovim_module_for_javascript() { # {{{
	if ! npm list --depth 0 --global neovim &> /dev/null; then
		print_progress 'Install neovim for javascript'
		npm install --global neovim
	else
		print_warning 'npm not installed. Skipping install neovim module for javascript'
	fi
}
# }}}
setup_neovim() { # {{{
	download_neovim_init
	install_neovim_module_for_python
	install_neovim_module_for_javascript
}
# }}}
download_plugins() { # {{{
	print_progress "Install plugins..."
	nvim +PlugInstall +qa
} # }}}
setup_vim() { # {{{
	move_repo
	create_required_dirs
	download_plug
	setup_fzf
	setup_neovim
	download_plugins
}
# }}}

setup_vim
