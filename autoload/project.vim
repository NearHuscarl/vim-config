" default values
if !exists('g:rootfiles')
	let g:rootfiles = ['.git', '*.sln', '.projectroot', '.hg', '.svn', '.bzr', '_darcs', 'build.xml']
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
  let file = a:file
  let file = len(file) ? file : expand('%')
  return fnamemodify(file, ':p')
endfunction
" }}}
function! project#GetRoot(...) " {{{
	" get project root
	for marker in g:rootfiles
		let path = s:GetFullName(a:0 ? a:1 : '')
		while 1
			let prev = path
			let path = fnamemodify(path, ':h')
			let fn = path.(s:IsRoot(path) ? '' : '/').marker
			if !empty(glob(fn))
				return path
			endif
			if path == prev
				break
			endif
		endwhile
	endfor
	return ''
endfunction
" }}}

" vim: nofoldenable
