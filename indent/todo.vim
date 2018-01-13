" ============================================================================
" File:        todo.vim
" Description: indent rule for file with todo extension
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Jan 14 03:26:07 +07 2018
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
	finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetTodoIndent()

" indentexpr not working when these are set
setlocal nolisp
setlocal nosmartindent

let s:empty_line_pattern = '^\s*$'
let s:text_pattern = '^\(\(^\s*[#\[]\)\@!.\)*$'
let s:comment_pattern = '^\s*#.*$'
let s:empty_line_pattern = '^\s*$'
let s:checkbox_pattern = '^\s*\[[xs XS_]\]'
let s:child_checkbox_pattern = '^\s*\[[xs ]\]'
let s:parent_checkbox_pattern = '^\s*\[[XS_]\]'
let s:category_pattern = '^\s*\[\([xsXS _]\]\)\@![^\]]*\] \[[0-9]\]'
let s:checkbox_end_pattern = '^\s*# END'

let s:empty = 'none'
let s:info = {
			\ s:parent_checkbox_pattern: {'type': 'pcheckbox'},
			\ s:child_checkbox_pattern: {'type': 'checkbox'},
			\ s:category_pattern: {'type': 'category'},
			\ s:checkbox_end_pattern: {'type': 'checkboxEND'},
			\ 'none': {'type': ''},
			\ }

function! s:TrimWhitespace(line) " {{{
   return substitute(a:line, '\(^\s\+\|\s\+$\)', '', 'g')
endfunction " }}}
function! s:GetCategoryNum(line) " {{{
	if a:line =~# s:category_pattern
		let line = s:TrimWhitespace(a:line)
		return line[strlen(line) - 2]
	endif
	return 0
endfunction
" }}}
function! s:SearchBackward(lnum, ...) " {{{
	let lnum = a:lnum
	let patterns = a:000

	while lnum > 0
		let lnum = prevnonblank(lnum - 1)
		for pattern in patterns
			if getline(lnum) =~# pattern
				let s:info[pattern].lnum = lnum
				return s:info[pattern]
			endif
		endfor
	endwhile
	return s:info[s:empty]
endfunction " }}}
function! s:SearchBackwardCheckbox(lnum) " {{{
	let match = s:SearchBackward(a:lnum, s:parent_checkbox_pattern, s:child_checkbox_pattern, s:category_pattern, s:checkbox_end_pattern)
	return { 'type': match.type, 'indent': indent(match.lnum) }
endfunction
" }}}
function! s:SearchBackwardCategory(lnum) " {{{
	let match = s:SearchBackward(a:lnum, s:category_pattern)
	return { 'type': match.type, 'indent': indent(match.lnum), 'indent_level': s:GetCategoryNum(getline(match.lnum)) }
endfunction
" }}}
function! GetTodoIndent() " {{{
	let current_line = getline(v:lnum)
	let prev_line = getline(v:lnum - 1)
	let prev_indent = indent(v:lnum - 1)

	" if current line is a category search upward for nearest category:
	"     if nearest line is a category with num less than current line, indent right 1
	"     if nearest line is a category with num larger than current line, indent left 1
	"     if nearest line is a category with num equal to current line, keep indent level
	" if current line is a (checkbox|comment|emptyLine), search upward for the nearest checkbox
	"     if nearest line is (pcheckbox|category): indent right 1
	"     if nearest line is child checkbox: keep indent level
	"     if nearest line is "# END" without quote, indent left 1
	" if current line is a (text|emptyLine), search upward for the nearest checkbox
	"     if nearest line is (child|parent) checkbox: indent right 4 char ('[ ] ' is 4 chars)
	"     if nearest line is a category: indent right 1

	if current_line =~# '\(' . s:text_pattern . '\|' . s:empty_line_pattern . '\)'
		let result = s:SearchBackwardCheckbox(v:lnum)

		if result.type ==# 'category'
			return result.indent + &shiftwidth
		elseif result.type ==# 'checkbox' || result.type ==# 'pcheckbox'
			return result.indent + len('[ ] ')
		endif
	endif

	if current_line =~# '\(' . s:checkbox_pattern . '\|' . s:comment_pattern . '\|' . s:empty_line_pattern . '\)'
		let result = s:SearchBackwardCheckbox(v:lnum)

		if result.type ==# 'pcheckbox' || result.type ==# 'category'
			return result.indent + &shiftwidth
		elseif result.type ==# 'checkbox' || result.type ==# 'none'
			return result.indent
		elseif result.type ==# 'checkboxEND'
			return result.indent - &shiftwidth
		endif
	endif

	if current_line =~# s:category_pattern
		let category_indent_lvl = s:GetCategoryNum(current_line)
		let result = s:SearchBackwardCategory(v:lnum)

		if result.type ==# 'category'
			return result.indent + &shiftwidth * (category_indent_lvl - result.indent_level)
		endif
	endif

endfunction
" }}}
