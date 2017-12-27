" ============================================================================
" File:        license.vim
" Description: A function to auto update Last Change time, use with autocmd 
"              BufWrite, and a function for undo/redo mappings to skip
"              jumping to auto updated timestamp
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Wed Dec 27 20:42:23 +07 2017
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

let s:date_prefix = 'Last Change: '

function! license#save_and_update_timestamp() " {{{
	" only save and update timestamp if buffered is modified. Dont use update
	" command + call update_timestamp() on BufWritePost because what if I dont
	" want to update timestamp when saving on some occasion? I have to disable
	" all other BufWritePost autocmd :(
	let comment = substitute(&commentstring, '%s', '', '')
	let s:date_pattern = comment . ' ' . s:date_prefix
	if &modified
		update
		" only updating timestamp when saving if cursor is not on 'Last Change:'
		" line.  When you go through editing history using undo/redo command the
		" cursor move to the edited line in the history, so when it moves to the
		" 'Last Change' line, it means that the current change is the timestamp
		" updating so no need to write the file which will update the timestamp
		" again. This hack is made to avoid cluttering the save history [WIP]
		if match(getline('.'), s:date_pattern) == -1 && !&diff
			call s:update_timestamp('%a %b %d %H:%M:%S %Z %Y')
		endif
	endif
endfunction
" }}}
function! s:update_timestamp(timefstring) " {{{
	" Find the match between line 5 to 15 and replace it with current date
	let view_info = winsaveview()
	silent! execute '5,15g/' . s:date_pattern
				\ . '/s/' . s:date_prefix . '.*$/' . s:date_prefix . strftime(a:timefstring)
	nohlsearch
	call winrestview(view_info)
	silent noautocmd update " update timestamp now wont trigger update ctags autocmd again
endfunction
" }}}
function! license#skip_license_date(action) " {{{
	" Skip seeing changes in license date when doing an undo/redo
	let view_info  = winsaveview()

	if a:action ==# 'undo'
		let key = 'u'
	elseif a:action ==# 'redo'
		let key = "\<C-r>"
	endif

	execute 'normal! ' . key
	let view_info.lnum = line('.')
	let view_info.col = col('.')

	if match(getline('.'), s:date_prefix) != -1
		execute 'normal! ' . key
		let view_info.lnum = line('.')
		let view_info.col = col('.')
	endif
	call winrestview(view_info)
endfunction
" }}}

" vim: nofoldenable
