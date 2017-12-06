" ============================================================================
" File:        license.vim
" Description: A function to auto update Last Change time, use with autocmd 
"              BufWrite, and a function for undo/redo mappings to skip
"              jumping to auto updated timestamp
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Wed Dec 06 11:06:59 +07 2017
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

let s:last_change_regex = 'Last Change:'

function! license#SetLastChangeBeforeBufWrite() " {{{
	" Find the match between line 5 to 15 and replace it with current date
	let cmt = substitute(&commentstring, '%s', '', '')
	for line in range(5, 15)
		if match(getline(line), s:last_change_regex) != -1
			let view_info = winsaveview()
			let time = strftime('%a %b %d %H:%M:%S %Z %Y')
			silent! call cursor(line, len(cmt) + len('Last Change:') + 3)
			execute 'normal! "_Da' . time
			call winrestview(view_info)
			return
		endif
	endfor
endfunction " }}}

function! license#SkipLicenseDate(action) " {{{
	" Skip seeing changes in license date when doing an undo/redo
	let bang = ''
	let viewInfo  = winsaveview()

	if a:action ==# 'undo'
		let key = 'u'
	elseif a:action ==# 'redo'
		let key = "\<C-r>"
	endif

	execute 'normal! ' . key
	let viewInfo.lnum = line('.')
	let viewInfo.col = col('.')

	if match(getline('.'), s:last_change_regex) != -1
		execute 'normal! ' . key
		let viewInfo.lnum = line('.')
		let viewInfo.col = col('.')
	endif
	call winrestview(viewInfo)
endfunction " }}}

" vim: nofoldenable
