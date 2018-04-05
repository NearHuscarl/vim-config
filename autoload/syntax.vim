function! syntax#GetGroup() " {{{
	" Get highlight group of word under the cursor
	let synID = synID(line('.'), col('.'), 1)
	call echo#success(synIDattr(synID, 'name') . ' => ' . synIDattr(synIDtrans(synID), 'name'))
endfunction
" }}}
function! syntax#YankFgColor() " {{{
	" Only work in GUI (gvim)
	call s:YankColor('fg')
endfunction
" }}}
function! syntax#YankBgColor() " {{{
	" Only work in GUI (gvim)
	call s:YankColor('bg')
endfunction
" }}}
function! s:YankColor(layer) " {{{
	let color_hex = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), a:layer)

	if empty(color_hex)
		call echo#error('No color detected')
		return
	endif

	let @* = color_hex
	let @+ = color_hex

	call echo#success('fg color ' . color_hex . ' has been copied to clipboard')
endfunction
" }}}

" vim: nofoldenable
