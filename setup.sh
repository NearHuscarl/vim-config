#!/bin/bash

# script to setup vim and neovim config files

# Run this script as admin
# On window: Hold CTRL+SHIFT while clicking git bash icon

# This script is part of vim-config
# Run to setup vim-config for vim and neovim on windows

# Requirement:
# git bash (Window)
# chocolatey (Window)
# pip
# npm

# COLORS {{{
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
RESET="$(tput sgr0)"
# }}}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
IS_WINDOW=''
OS=$(uname -s)

if [[ "$OS" =~ 'CYGWIN' ]] || [[ "$OS" =~ 'MINGW' ]]; then
	IS_WINDOW=true
else
	IS_WINDOW=false
fi

if [[ "$IS_WINDOW" == true ]]; then
	VIM_PATH="$HOME/vimfiles"
else
	VIM_PATH="$HOME/.vim"
fi

if [[ "$IS_WINDOW" == true ]]; then
	NVIM_PATH="$LOCALAPPDATA/nvim"
else
	NVIM_PATH="$HOME/.config/nvim"
fi


print_progress() { #{{{
	# Console width number
	T_COLS="$(tput cols)"
	echo -e " ${GREEN}> $1${RESET}\n" | fold -sw $(($T_COLS - 2))
}
# }}}
print_warning() { #{{{
	T_COLS="$(tput cols)"
	echo -e " ${YELLOW}$1${RESET}\n" | fold -sw $(($T_COLS - 2))
}
# }}}
has_command() { # {{{
	command -v $1 > /dev/null
}
# }}}


install_vim() { # {{{
	if [[ "$IS_WINDOW" == true ]]; then
		if has_command choco; then
			choco install neovim -y
			choco install vim-tux -y
		else
			print_warning 'chocolatey is not installed. Skip installing vim and neovim...'
		fi
	fi
}
#}}}
move_repo() { # {{{
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
	if ! has_command pip; then
		print_warning 'pip not installed. Skipping install neovim module for python'
		return
	fi

	if ! python -c 'import neovim' 2> /dev/null; then
		print_progress 'Install neovim for python'
		pip install --user neovim
	else
		print_warning 'neovim module for python is already installed'
	fi
}
# }}}
install_neovim_module_for_javascript() { # {{{
	if ! has_command npm; then
		print_warning 'npm not installed. Skipping install neovim module for javascript'
		return
	fi

	if ! npm list --depth 0 --global neovim &> /dev/null; then
		print_progress 'Install neovim for javascript'
		npm install --global neovim
	else
		print_warning 'neovim package for javascript is already installed'
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

	if [[ "$IS_WINDOW" == true ]]; then
		nvim-qt.exe +PlugInstall +qa
	else
		vim +PlugInstall +qa
	fi
} # }}}
setup_vim() { # {{{
	move_repo
	install_vim
	create_required_dirs
	download_plug
	setup_fzf
	setup_neovim
	download_plugins
}
# }}}

setup_vim
