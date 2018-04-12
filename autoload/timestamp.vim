" ============================================================================
" File:        license.vim
" Description: A function to auto update Last Change time, use with autocmd
"              BufWrite
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Wed Dec 27 20:42:23 +07 2017
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

let s:DATE_PATTERN = 'Last Change: '

function! timestamp#update() " {{{
	call s:update_timestamp('%a %b %d %H:%M:%S %Z %Y')
endfunction
" }}}
function! s:update_timestamp(timefstring) " {{{
	" Find the match between line 5 to 15 and replace it with current date
	let view_info = winsaveview()
	silent! execute '5,15g/' . s:DATE_PATTERN
				\ . '/s/' . s:DATE_PATTERN . '.*$/' . s:DATE_PATTERN . strftime(a:timefstring)
	nohlsearch
	call winrestview(view_info)
	silent noautocmd update " update timestamp now wont trigger update ctags autocmd again
endfunction
" }}}
