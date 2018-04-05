" ============================================================================
" File:        header.vim
" Description: Toggle between *.h and *.cpp file
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Fri Apr 06 03:21:31 +07 2018
" Licence:     BSD 3-Clause license
" Note:        None
" ============================================================================

function! s:get_file_extension(filename) " {{{
	return split(a:filename, '\.')[1]
endfunction
" }}}
function! s:get_filename_without_extension(filename) " {{{
	return split(a:filename, '\.')[0]
endfunction
" }}}
function! s:restore_cursor_pos() " {{{
	if line("'\"") > 1 && line("'\"") <= line('$')
		execute "normal! g`\""
	endif
endfunction
" }}}
function! s:jump_to(extension) " {{{
	let filename = expand('%')
	let name = s:get_filename_without_extension(filename)
	let targetfile = join([name, a:extension], '.')

	if filereadable(targetfile)
		execute 'e ' . targetfile
	else
		call echo#error(join([targetfile, 'doenst exist :(']))
	endif
endfunction
" }}}
function! header#toggle() " {{{
	let filename = expand('%')
	let extension = s:get_file_extension(filename)

	if extension ==# 'cpp'
		call s:jump_to('h')
	elseif extension ==# 'h'
		call s:jump_to('cpp')
	endif

	call s:restore_cursor_pos()
endfunction " }}}
