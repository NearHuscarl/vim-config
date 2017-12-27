" ============================================================================
" File:        ctags.vim
" Description: Update ctags file. Use with autocmd BufWritePost
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Wed Dec 27 20:47:38 +07 2017
" Licence:     BSD 3-Clause license
" Note:        None
" ============================================================================

function! s:echo_hl(msg, hl_group) " {{{
	execute 'echohl ' . a:hl_group
	echomsg a:msg
	echohl None
endfunction
" }}}
function! s:execute(cmd) " {{{
	let is_win = has('win32') || has('win64')
	let s:plugged = is_win ? $HOME.'\vimfiles\plugged\' : $HOME.'/.vim/plugged/'

	let has_asyncrun = !empty(glob(s:plugged . 'asyncrun.vim'))
	execute has_asyncrun ? 'AsyncRun ' . a:cmd : 'call system( ' . a:cmd . ')'
	redraw
	call s:echo_hl(s:tag_path . '/tags has been updated!', 'String')
endfunction
" }}}
function! s:get_tag_path() " {{{
	" Get the closest parent directory that contains tags file, if no tags file
	" is found or only find tags up to $HOME return current dir to create new
	" tags in it
	try
		let tag_path = fnamemodify(tagfiles()[0], ':~:h')
	catch /list index out of range/
		return expand('%:p:h')
	endtry

	if tag_path ==# '~'
		return expand('%:p:h')
	endif
	return tag_path
endfunction
" }}}
" Note: tags file must be created first (manually or by other script)
" before it can get updated by this function or it will creates new tags
" in parent directory of this file if no tags found up to $HOME
function! ctags#update() " {{{
	if !&diff
		let s:tag_path = s:get_tag_path()
		let cmd = 'cd ' . shellescape(expand(s:tag_path)) . ' && ctags -R -f newtags && mv newtags tags'
		call s:execute(cmd)
	endif
endfunction
" }}}

" vim: nofoldenable
