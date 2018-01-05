function! s:echo_hl(msg, hl_group) " {{{
	execute 'echohl ' . a:hl_group
	echo a:msg
	echohl None
endfunction
" }}}
function! s:get_visual_selection()
	" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection ==# 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction
function! gn#search_selected_word() " {{{
	" Search for current selected words in visual mode, but dont move cursor, use with gn
	let @/ = s:get_visual_selection()
	nohlsearch
	call s:echo_hl(s:get_visual_selection(), 'String')
endfunction
" }}}
function! gn#search_current_word() " {{{
	" Search current word (normal *), but dont move cursor, use with gn
	let word_boundary_pattern = '\(\\<\|\\>\)'
	let @/ = expand('<cword>')
	nohlsearch
	call s:echo_hl(substitute(@/, word_boundary_pattern, '', 'g'), 'String')
endfunction
" }}}
