" ============================================================================
" File:        todo.vim
" Description: Custom mappings for todo file, see syntax/todo.vim
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sat Jan 13 20:42:48 +07 2018
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

setlocal commentstring=#%s
setlocal foldexpr=todo#GetTodoFoldLevel(v:lnum)
setlocal foldmethod=expr
" let todoIndentLevel = 3

nnoremap <silent><buffer> q :q<CR>
nnoremap <silent><buffer>0 ^4l

nnoremap <silent><buffer> <Tab>   :set opfunc=todo#ToggleDone<CR>g@l
nnoremap <silent><buffer> <S-Tab> :set opfunc=todo#ToggleSuspend<CR>g@l
nnoremap <silent><buffer> gd      :set opfunc=todo#ToggleDone<CR>g@
nnoremap <silent><buffer> gs      :set opfunc=todo#ToggleSuspend<CR>g@
xnoremap <silent><buffer> gd      :<C-u>call todo#ToggleDoneVisual('block')<CR>
xnoremap <silent><buffer> gs      :<C-u>call todo#ToggleSuspendVisual('block')<CR>

nnoremap <silent><buffer> gtd     :set opfunc=todo#TickDone<CR>g@
nnoremap <silent><buffer> gts     :set opfunc=todo#TickSuspend<CR>g@
nnoremap <silent><buffer> gud     :set opfunc=todo#UntickDone<CR>g@
nnoremap <silent><buffer> gus     :set opfunc=todo#UntickSuspend<CR>g@
nnoremap <silent><buffer> gua     :set opfunc=todo#UntickAll<CR>g@

nnoremap <silent><buffer> gH    :call todo#ToggleHighlightTask()<CR>

nnoremap <silent><buffer> gi    :call todo#InsertNewTask(0)<CR>|  " Make new child task
nnoremap <silent><buffer> gI    :call todo#InsertNewTask(1)<CR>|  " Make new parent task
nnoremap <silent><buffer> gct   :call todo#ToggleTaskType()<CR>

nnoremap <silent><buffer> <A-p> :call todo#JumpUpCategory()<CR>zz
nnoremap <silent><buffer> <A-n> :call todo#JumpDownCategory()<CR>zz

onoremap <silent><buffer> it :call todo#SelectChildTasks()<CR>
onoremap <silent><buffer> at :call todo#SelectParentAndChildTasks()<CR>
