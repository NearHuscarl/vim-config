function! yank#Path() " {{{
	let full_path = expand('%:p')
	let @* = full_path
	let @+ = full_path
	call echo#success(full_path . ' has been yanked!')
endfunction
" }}}

" vim: nofoldenable
