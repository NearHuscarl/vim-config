function! diff#jump_forward(default_mapping) " {{{
	if &diff
		return ']czz'
	else
		return strlen(a:default_mapping) != 0 ? a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#jump_backward(default_mapping) " {{{
	if &diff
		return '[czz'
	else
		return strlen(a:default_mapping) != 0 ? a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#update(default_mapping) " {{{
	if &diff
		return ":diffupdate\<CR>"
	else
		return strlen(a:default_mapping) != 0 ? a:default_mapping : ''
	endif
endfunction
" }}}
function! diff#quit(default_mapping) " {{{
	if &diff
		return ":quit\<CR>"
	else
		return strlen(a:default_mapping) != 0 ? a:default_mapping : ''
	endif
endfunction
" }}}
