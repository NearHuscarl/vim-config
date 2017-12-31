" ============================================================================
" File:        todo.vim
" Description: Custom mappings for todo file, see syntax/todo.vim
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Sun Dec 31 18:40:08 +07 2017
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

setlocal commentstring=#%s
setlocal foldmethod=indent

" let todoIndentLevel = 3

nnoremap <silent><buffer> q :q<CR>

nnoremap <silent><buffer> <Tab>   :set opfunc=todo#ToggleDone<CR>g@l
nnoremap <silent><buffer> <S-Tab> :set opfunc=todo#ToggleSuspend<CR>g@l
nnoremap <silent><buffer> gd      :set opfunc=todo#ToggleDone<CR>g@
nnoremap <silent><buffer> gs      :set opfunc=todo#ToggleSuspend<CR>g@
xnoremap <silent><buffer> gd      :<C-u>call todo#ToggleDoneVisual('block')<CR>
xnoremap <silent><buffer> gs      :<C-u>call todo#ToggleSuspendVisual('block')<CR>

" nnoremap <silent><buffer> gtd     :set opfunc=todo#TickDone<CR>g@
" nnoremap <silent><buffer> gts     :set opfunc=todo#TickSuspend<CR>g@
" nnoremap <silent><buffer> gud     :set opfunc=todo#UntickDone<CR>g@
" nnoremap <silent><buffer> gus     :set opfunc=todo#UntickSuspend<CR>g@
" nnoremap <silent><buffer> gta     :set opfunc=todo#UntickAll<CR>g@

nnoremap <silent><buffer> gH    :call todo#ToggleHighlightTask()<CR>

nnoremap <silent><buffer> gi    :call todo#InsertNewTask('c')<CR>|  " Make new child task
nnoremap <silent><buffer> gI    :call todo#InsertNewTask('p')<CR>|  " Make new parent task

nnoremap <silent><buffer> <A-p> :call todo#JumpUpCategory()<CR>zz
nnoremap <silent><buffer> <A-n> :call todo#JumpDownCategory()<CR>zz

" nnoremap <silent><buffer> dd    :call todo#Delete()<CR>
" dd to delete task and subtask
