" ============================================================================
" File:        source.vim
" Description: Source vimrc + current file if it's in autoload/
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Jan 14 18:06:23 +07 2018
" Licence:     BSD 3-Clause license
" Note:        Note
" ============================================================================

if has('win32') || has('win64')
	let s:sep = '\\'
else
	let s:sep = '\/'
endif

function! source#vimrc() " {{{
	source $MYVIMRC
	if exists(':YcmRestartServer')
		execute 'YcmRestartServer'
	endif
	nohlsearch
endfunction
" }}}
function! source#vimfile() " {{{
	" Note: This function cannot source the file contain itself (autoload/source.vim)
	" Because it cannot be redefined while still executing.
	if expand('%:p') =~# 'autoload' . s:sep . 'source\.vim'
		return
	endif

	for dirname in ['after', 'autoload', 'ftdetect', 'ftplugin', 'indent', 'plugin']
		" dirname = 'autoload' => match ../autoload/.. or ../autoload
		if expand('%:p:h') =~# s:sep . dirname . '\(' . s:sep . '\|$\)'
			" /home/near/.vim/autoload/a/b/f.vim => autoload/a/b/f.vim
			let file_path = matchlist(expand('%:p'), '.*\(' . dirname . '.*$\)')[1]

			execute 'runtime ' . file_path
			redraw
			call echo#success(file_path . ' has been sourced!')
			return
		endif
	endfor

	redraw
	call echo#error('current file cannot be sourced!')
endfunction
" }}}
function! source#Xresources() " {{{
	let cmd = 'xrdb $HOME/.Xresources'

	if has('win32') || has('win64')
		let s:plugged = $HOME.'\vimfiles\plugged\'
	else
		let s:plugged = $HOME.'/.vim/plugged/'
	endif

	if expand('%:p') =~# '\.Xresources'
		if !empty(glob(s:plugged . 'asyncrun.vim'))
			execute 'AsyncRun ' . cmd
		else
			execute '!' . cmd
		endif

		redraw
		call echo#success('~/.Xresources has been sourced!')
	endif
endfunction
" }}}

" vim: nofoldenable
