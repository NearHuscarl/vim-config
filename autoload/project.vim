" ============================================================================
" File:        project.vim
" Description: Get project root path. Use to set searching starting point in
"              fzf
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Thu Apr 05 21:09:11 +07 2018
" Licence:     BSD 3-Clause license
" Note:        Note
" ============================================================================
" default values
if !exists('g:rootfiles')
	let g:rootfiles = ['.git', '*.sln', 'package.json']
endif

function! s:IsRoot(path) " {{{
	" match '/' or 'C:\', 'D:\'...
	if a:path == '/' || a:path =~ '\u:\\$'
		return 1
	endif
	return 0
endfunction
" }}}
function! s:GetFullName(file) " {{{
  let file = len(a:file) ? a:file : expand('%')
  return fnamemodify(file, ':p')
endfunction
" }}}
function! project#GetRoot(...) " {{{
	" get project root
	let path = s:GetFullName(a:0 ? a:1 : '')
	while 1
		let prev = path
		let path = fnamemodify(path, ':h')
		for rootfile in g:rootfiles
			let fn = path.(s:IsRoot(path) ? '' : '/').rootfile
			if !empty(glob(fn))
				return path
			endif
		endfor
		if path == prev
			break
		endif
	endwhile
	return ''
endfunction
" }}}

" vim: nofoldenable
