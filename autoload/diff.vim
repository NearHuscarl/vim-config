function! diff#jump_forward(default_mapping) " {{{
	if &diff
		execute 'normal! ]czz'
	else
		execute strlen(a:default_mapping) != 0 ? 'normal! ' . a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#jump_backward(default_mapping) " {{{
	if &diff
		execute 'normal! [czz'
	else
		execute strlen(a:default_mapping) != 0 ? 'normal! ' . a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#update(default_mapping) " {{{
	if &diff
		execute 'diffupdate'
	else
		execute strlen(a:default_mapping) != 0 ? 'normal! ' . a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#quit(default_mapping) " {{{
	if &diff
		execute 'quit'
	else
		execute strlen(a:default_mapping) != 0 ? 'normal! ' . a:default_mapping : ''
	endif
endfunction
" }}}
