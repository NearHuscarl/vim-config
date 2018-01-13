" ============================================================================
" File:        todo.vim
" Description: functions for local mappings in todo files
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sat Jan 13 21:11:04 +07 2018
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

let s:child_ticked_pattern = '^\s*\[[sx]\]\C'
let s:parent_ticked_pattern = '^\s*\[[SX]\]\C'
let s:child_unticked_pattern = '^\s*\[ \]'
let s:parent_unticked_pattern = '^\s*\[_\]'
let s:child_all_pattern = '^\s*\[[sx ]\]\C'
let s:parent_all_pattern = '^\s*\[[SX_]\]\C'
let s:highlight_pattern = '^\s*\[.\]\.'
let s:unhighlight_pattern = '^\s*\[.\].*\(\*\*\)\@<!$'
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
		execute range . 'call todo#TickCheckbox(a:char)'
	elseif a:action ==# 'untick'
		execute range . 'call todo#UntickCheckbox(a:char)'
	elseif a:action ==# 'toggle'
		execute range . 'call todo#ToggleCheckbox(a:char)'
	endif

	call winrestview(viewInfo)
endfunction " }}}
function! todo#UntickCheckbox(char) " {{{
	let currentLine = getline('.')

	" Untick all
	if a:char ==# 'a'
		if match(currentLine, s:child_ticked_pattern) != -1
			execute 'normal! ^lr '
		elseif match(currentLine, s:parent_all_pattern) != -1
			execute 'normal! ^lr_'
		endif
	endif

	if match(currentLine, s:child_ticked_pattern) != -1
		execute 'normal! ^lr '
	elseif match(currentLine, s:parent_ticked_pattern) != -1
		execute 'normal! ^lr_'
	endif 
endfunction " }}}
function! todo#TickCheckbox(char) " {{{
	let currentLine = getline('.')

	if match(currentLine, '^\s*\[[^' . a:char . ']\]') != -1
		if match(currentLine, s:child_all_pattern) != -1
			execute 'normal! ^lr' . a:char
		elseif match(currentLine, s:parent_all_pattern) != -1
			execute 'normal! ^lr' . toupper(a:char)
		endif
	endif
endfunction " }}}
function! todo#ToggleCheckbox(char) " {{{
	let currentLine = getline('.')

	if match(currentLine, s:child_unticked_pattern) != -1
		execute 'normal! ^lr' . a:char
	elseif match(currentLine, s:parent_unticked_pattern) != -1
		execute 'normal! ^lr' . toupper(a:char)
	elseif match(currentLine, s:child_ticked_pattern) != -1
		execute 'normal! ^lr '
	elseif match(currentLine, s:parent_ticked_pattern) != -1
		execute 'normal! ^lr_'
	endif
endfunction " }}}
function! todo#InsertNewTask(char) " {{{
	let old_autoindent = &autoindent
	set autoindent
	if a:char ==# 'c'
		let text = '[ ] '
	elseif a:char ==# 'p'
		let text = '[_] '
		let end = '# END'
		execute "normal! o\<Tab>" . end . "\<Esc>k"
	endif

	" match empty line
	if match(getline('.'), '^\s*$') != -1
		execute 'normal! cc' . text
		" not empty line, open newline and insert task
	else
		execute 'normal! o' . text
	endif

	normal! ==
	" go to insert mode
	call feedkeys('A', 'n')
	let &autoindent = old_autoindent
endfunction " }}}
function! s:GetIndent(arg) "{{{
	let indent = ''
	let level = a:arg
	while level > 0
		let indent = indent . ' '
		let level -= 1
	endwhile
	return indent
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
function! todo#Delete() " {{{
	let currentLine  = getline('.')

	if match(currentLine, s:parent_all_pattern) != -1
		execute 'normal! jzcdd'
	else
		execute 'normal! dd'
	endif
endfunction " }}}
function! todo#ToggleHighlightTask() " {{{
	let cursorInfo = [line('.'), col('.')]

	if match(getline('.'), s:highlight_pattern) != -1
		execute 'normal! ^3lr '
	elseif match(getline('.'), s:unhighlight_pattern) != -1
		execute 'normal! ^3lr.'
	endif
	call cursor(cursorInfo[0], cursorInfo[1])
endfunction " }}}
function! s:SearchParentCheckbox(...) " {{{
	" return line of parent checkbox that content the checkbox of current line
	let lnum = a:0 == 1 ? a:1 : line('.')
	if getline(lnum) =~# s:parent_all_pattern
		return lnum
	endif

	let parent_indent_lvl = indent(lnum) - &shiftwidth
	while lnum != 0
		let lnum = search(s:parent_all_pattern, 'bW')
		if getline(lnum) =~# s:parent_all_pattern && indent(lnum) == parent_indent_lvl
			return lnum
		endif
	endwhile
	return -1
endfunction
" }}}
function! s:SearchParentCheckboxEnd(...) " {{{
	let lnum = a:0 == 1 ? a:1 : line('.')
	if getline(lnum) =~# s:parent_all_pattern
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
function! todo#SelectChildTasks()
	let start_line = s:SearchParentCheckbox() " {{{
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
		let lnum = search(s:category_pattern, 'bW')
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

	if current_line =~# '\(' . s:parent_all_pattern . '\|' . s:category_pattern . '\)'
		return 'a1'
	elseif current_line =~# s:checkbox_end_pattern
		return 's1'
	else
		return '='
	endif
endfunction
" }}}
