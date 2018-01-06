" ============================================================================
" File:        todo.vim
" Description: Vim syntax file: todo
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Jan 07 01:23:06 +07 2018
" Licence:     BSD 3-Clause license
" Note:        todo file used to take note, reminder, and manage daily tasks
" ============================================================================

if exists('b:current_syntax')
	finish
endif

syntax match todoTaskCategory       "^\s*\[\([xsXS _]\]\)\@![a-zA-Z0-9 ]*\]" nextgroup=todoTaskCategoryNumber
syntax match todoTaskCategoryNumber "\(\[\([xsXS _]\]\)\@![a-zA-Z0-9 ]\{2,}\] \+\)\@<=\[\d\]"

" let s:text_pattern = '^\(\(^\s*[#\[]\)\@!.\)*$'
syntax match todoComment            '^\s*#.*$'
" syn match todoDone               "^\s*\[[xX]\].*\(\*\*\)\@<!$"
" syn match todoNotDone            "^\s*\[[ _]\].*\(\*\*\)\@<!$"
" syntax match todoSuspend            "^\s*\[[sS]\].*\(\*\*\)\@<!$"

syntax region todoDoneRegion    start='^\s*\[[xX]\] ' end='^\s*\(#\|\[.*\]\)'me=s-1
syntax region todoNotDoneRegion start='^\s*\[[ _]\] ' end='^\s*\(#\|\[.*\]\)'me=s-1
syntax region todoSuspendRegion start='^\s*\[[sS]\] ' end='^\s*\(#\|\[.*\]\)'me=s-1

syntax region todoDoneHighlightRegion    start='^\s*\[[xX]\]\.' end='^\s*\(#\|\[.*\]\)'me=s-1
syntax region todoNotDoneHighlightRegion start='^\s*\[[ _]\]\.' end='^\s*\(#\|\[.*\]\)'me=s-1
syntax region todoSuspendHighlightRegion start='^\s*\[[sS]\]\.' end='^\s*\(#\|\[.*\]\)'me=s-1

" Custom highlight group
hi TodoDoneHighlight    ctermbg=black ctermfg=green  guibg=black guifg=green  cterm=reverse gui=reverse
hi TodoNotDoneHighlight ctermbg=black ctermfg=red    guibg=black guifg=red    cterm=reverse gui=reverse
hi TodoSuspendHighlight ctermbg=black ctermfg=yellow guibg=black guifg=yellow cterm=reverse gui=reverse

" Tell vim what color to highlight
hi def link todoTaskCategory       Type
hi def link todoTaskCategoryNumber Identifier

hi def link todoComment            Comment
hi def link todoDoneRegion         String
hi def link todoNotDoneRegion      PreProc
hi def link todoSuspendRegion      Statement

hi def link todoDoneHighlightRegion      TodoDoneHighlight
hi def link todoNotDoneHighlightRegion   DiffDelete
hi def link todoSuspendHighlightRegion   DiffChange

let b:current_syntax = 'todo'
