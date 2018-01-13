" ============================================================================
" File:        todo.vim
" Description: functions for local mappings in todo files
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Jan 14 00:56:34 +07 2018
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

let s:checkbox_ticked_pattern = '^\s*\[[sx]\]\C'
let s:parent_checkbox_ticked_pattern = '^\s*\[[SX]\]\C'
let s:checkbox_unticked_pattern = '^\s*\[ \]'
let s:parent_checkbox_unticked_pattern = '^\s*\[_\]'
let s:all_checkbox_pattern = '^\s*\[[sxSX _]\]\C'
let s:checkbox_pattern = '^\s*\[[sx ]\]\C'
let s:parent_checkbox_pattern = '^\s*\[[SX_]\]\C'
let s:highlight_checkbox_pattern = '^\s*\[.\]\.'
let s:unhighlight_checkbox_pattern = '^\s*\[.\].*\(\*\*\)\@<!$'
let s:category_pattern = '^\s*\[\([xsXS _]\]\)\@![a-zA-Z0-9 ]*\]'
let s:checkbox_end_pattern = '^\s*# END'

try
	call plug#load('vim-easy-align')
endtry
" {{{ Wrapper Functions
function! todo#ToggleDoneVisual(type)
	call s:ModifyCheckbox('toggle', 'x', '<', '>')
endfunction
function! todo#ToggleSuspendVisual(type)
	call s:ModifyCheckbox('toggle', 's', '<', '>')
endfunction
function! todo#ToggleDone(type)
	call s:ModifyCheckbox('toggle', 'x', '[', ']')
endfunction
function! todo#ToggleSuspend(type)
	call s:ModifyCheckbox('toggle', 's', '[', ']')
endfunction
function! todo#TickDone(type)
	call s:ModifyCheckbox('tick', 'x', '[', ']')
endfunction
function! todo#TickSuspend(type)
	call s:ModifyCheckbox('tick', 's', '[', ']')
endfunction
function! todo#UntickDone(type)
	call s:ModifyCheckbox('untick', 'x', '[', ']')
endfunction
function! todo#UntickSuspend(type)
	call s:ModifyCheckbox('untick', 's', '[', ']')
endfunction
function! todo#UntickAll(type)
	call s:ModifyCheckbox('untick', 'a', '[', ']')
endfunction
" }}}
function! s:ModifyCheckbox(action, char, markBegin, markEnd) " {{{
	let viewInfo  = winsaveview()
	let lineBegin = line("'" . a:markBegin)
	let lineEnd   = line("'" . a:markEnd)
	let range = lineBegin . ',' . lineEnd

	if a:action ==# 'tick'
		execute range . 'call s:TickCheckbox("' . a:char . '")'
	elseif a:action ==# 'untick'
		execute range . 'call s:UntickCheckbox("' . a:char . '")'
	elseif a:action ==# 'toggle'
		execute range . 'call s:ToggleCheckbox("' . a:char . '")'
	endif

	call winrestview(viewInfo)
endfunction " }}}
function! s:CheckboxPattern(char, ...) " {{{
	let inverted = (a:0 == 0 ? '' : (a:1 == 0 ? '^' : ''))
	return '^\s*\[[' . inverted . a:char . ']\]'
endfunction
" }}}
function! s:Tick(char) " {{{
	let tick = (getline('.') =~# s:parent_checkbox_pattern ? toupper(a:char) : a:char)
	execute 'normal! ^lr' . tick
endfunction
" }}}
function! s:Untick() " {{{
	let untick = (getline('.') =~# s:parent_checkbox_pattern ? '_' : ' ')
	execute 'normal! ^lr' . untick
endfunction
" }}}
function! s:UntickCheckbox(char) " {{{
	let line = getline('.')

	" Untick all
	if a:char ==# 'a'
		call s:Untick()
	else
		if line =~? s:CheckboxPattern(a:char, 1)
			call s:Untick()
		endif
	endif
endfunction " }}}
function! s:TickCheckbox(char) " {{{
	let line = getline('.')

	if line =~? s:CheckboxPattern(a:char, 0)
		call s:Tick(a:char)
	endif
endfunction " }}}
function! s:ToggleCheckbox(char) " {{{
	let line = getline('.')

	if line =~# s:all_checkbox_pattern
		if line =~? s:CheckboxPattern(a:char)
			call s:Untick()
		else
			call s:Tick(a:char)
		endif
	endif
endfunction " }}}
function! todo#InsertNewTask(char) " {{{
	let old_autoindent = &autoindent
	set autoindent
	if a:char ==# 'c'
		let checkbox = '[ ] '
	elseif a:char ==# 'p'
		let checkbox = '[_] '
		let end = '# END'
		execute "normal! o\<Tab>" . end . "\<Esc>k"
	endif

	" match empty line
	if match(getline('.'), '^\s*$') >= 0
		execute 'normal! cc' . checkbox
		" not empty line, open newline and insert task
	else
		execute 'normal! o' . checkbox
	endif

	normal! ==
	" go to insert mode
	call feedkeys('A', 'n')
	let &autoindent = old_autoindent
endfunction " }}}
function! todo#JumpUpCategory() " {{{
	let line = search(s:category_pattern, 'nb')
	" Use G and | instead of search() to add to the jumplist
	execute 'normal! ' . line . 'G0'
endfunction " }}}
function! todo#JumpDownCategory() " {{{
	let line = search(s:category_pattern, 'n')
	execute 'normal! ' . line . 'G0'
endfunction " }}}
function! todo#ToggleHighlightTask() " {{{
	let cursorInfo = [line('.'), col('.')]

	if match(getline('.'), s:highlight_checkbox_pattern) >= 0
		execute 'normal! ^3lr '
	elseif match(getline('.'), s:unhighlight_checkbox_pattern) >= 0
		execute 'normal! ^3lr.'
	endif
	call cursor(cursorInfo[0], cursorInfo[1])
endfunction " }}}
function! s:SearchParentCheckbox(...) " {{{
	" return line of parent checkbox that content the checkbox of current line
	let lnum = a:0 == 1 ? a:1 : line('.')
	if getline(lnum) =~# s:parent_checkbox_pattern
		return lnum
	endif

	let parent_indent_lvl = indent(lnum) - &shiftwidth
	while lnum != 0
		let lnum = search(s:parent_checkbox_pattern, 'bW')
		if getline(lnum) =~# s:parent_checkbox_pattern && indent(lnum) == parent_indent_lvl
			return lnum
		endif
	endwhile
	return -1
endfunction
" }}}
function! s:SearchParentCheckboxEnd(...) " {{{
	let lnum = a:0 == 1 ? a:1 : line('.')
	if getline(lnum) =~# s:parent_checkbox_pattern
		let end_indent_lvl = indent(lnum) + &shiftwidth
	else
		let end_indent_lvl = indent(lnum)
	endif
	while lnum != 0
		let lnum = search(s:checkbox_end_pattern, 'W')
		if getline(lnum) =~# s:checkbox_end_pattern && indent(lnum) == end_indent_lvl
			return lnum
		endif
	endwhile
	return -1
endfunction
" }}}
function! todo#SelectChildTasks() " {{{
	let start_line = s:SearchParentCheckbox()
	let end_line = s:SearchParentCheckboxEnd(start_line)
	execute 'normal! ' . start_line . 'GjV' . end_line . 'Gk'
endfunction
" }}}
function! todo#SelectParentAndChildTasks() " {{{
	let start_line = s:SearchParentCheckbox()
	let end_line = s:SearchParentCheckboxEnd(start_line)
	execute 'normal! ' . start_line . 'GV' . end_line . 'G'
endfunction
" }}}
function! s:TrimWhitespace(line) " {{{
   return substitute(a:line, '\(^\s\+\|\s\+$\)', '', 'g')
endfunction " }}}
function! s:GetCategoryNum(line) " {{{
	let line = s:TrimWhitespace(a:line)
	return line[strlen(line) - 2]
endfunction
" }}}
function! s:GetCurrentCategoryNum(lnum) " {{{
	let line = getline(a:lnum)
	if line =~# s:category_pattern
		return s:GetCategoryNum(line)
	else
		let lnum = search(s:category_pattern, 'nbW')
		if lnum != 0
			return s:GetCategoryNum(getline(lnum))
		endif
	endif
	return 0
endfunction
" }}}
function! todo#GetTodoFoldLevel(lnum) " {{{
	let current_line = getline(a:lnum)
	let next_line = getline(a:lnum + 1)

	if next_line =~# s:category_pattern
		let current_category_num = s:GetCurrentCategoryNum(a:lnum)
		let next_category_num = s:GetCurrentCategoryNum(a:lnum + 1)
		if current_category_num > next_category_num
			let offset = current_category_num - next_category_num
		elseif current_category_num == next_category_num
			let offset = 1
		else
			return '='
		endif
		let offset += (current_line =~# s:checkbox_end_pattern ? 1 : 0)
		return 's' . string(offset + 1)
	endif

	if current_line =~# '\(' . s:parent_checkbox_pattern . '\|' . s:category_pattern . '\)'
		return 'a1'
	elseif current_line =~# s:checkbox_end_pattern
		return 's1'
	else
		return '='
	endif
endfunction
" }}}
