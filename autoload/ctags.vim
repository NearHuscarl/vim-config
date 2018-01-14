" ============================================================================
" File:        ctags.vim
" Description: Update ctags file. Use with autocmd BufWritePost
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Jan 14 18:03:05 +07 2018
" Licence:     BSD 3-Clause license
" Note:        None
" ============================================================================

function! s:echo_hl(msg, hl_group) " {{{
	execute 'echohl ' . a:hl_group
	echomsg a:msg
	echohl None
endfunction
" }}}
function! s:has_asyncrun() " {{{
	let is_win = has('win32') || has('win64')
	let s:plugged = is_win ? $HOME.'\vimfiles\plugged\' : $HOME.'/.vim/plugged/'
	return !empty(glob(s:plugged . 'asyncrun.vim'))
endfunction
" }}}
function! s:execute(cmd) " {{{
	execute s:has_asyncrun() ? 'AsyncRun ' . a:cmd : 'call system( ' . a:cmd . ')'
endfunction
" }}}
function! ctags#create(...) " {{{
	let path = a:0 == 1 ? a:1 : '.'
	call s:execute('cd ' . shellescape(expand(path)) . ' && ctags -R -f newtags && mv newtags tags')
endfunction
" }}}
function! s:get_tag_path() " {{{
	" Get the closest parent directory that contains tags file, if no tags file
	" is found or only find tags up in $HOME return current dir return empty string
	try
		let tag_path = fnamemodify(tagfiles()[0], ':~:h')
	catch /list index out of range/
		return ''
	endtry
	return tag_path
endfunction
" }}}
" Note: tags file must be created first (manually or by other script)
" before it can get updated by this function or it will creates new tags
" in parent directory of this file if no tags found up to $HOME
function! ctags#update() " {{{
	if !&diff
		let s:tag_path = s:get_tag_path()
		if empty(s:tag_path) || s:tag_path ==# '~'
			return
		endif
		call ctags#create(s:tag_path)
		redraw
		call s:echo_hl(s:tag_path . '/tags has been updated!', 'String')
	endif
endfunction
" }}}

" vim: nofoldenable
