" Get highlight group of word under the cursor
function! syntax#GetGroup() " {{{
	let synID = synID(line('.'), col('.'), 1)

	echohl String
	echo synIDattr(synID, 'name') . ' => ' . synIDattr(synIDtrans(synID), 'name')
	echohl None
endfunction

" vim: nofoldenable
