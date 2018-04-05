" ============================================================================
" File:        echo.vim
" Description: echo + color on different message type: error, warning, info...
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Fri Apr 06 03:43:45 +07 2018
" Licence:     BSD 3-Clause license
" Note:        None
" ============================================================================

function! s:echo_hl(msg, hlGroup) " {{{
	execute 'echohl ' . a:hlGroup
	echomsg a:msg
	echohl None
endfunction
" }}}
function! echo#error(msg) " {{{
	call s:echo_hl(a:msg, 'PreProc')
endfunction
" }}}
function! echo#warning(msg) " {{{
	call s:echo_hl(a:msg, 'Statement')
endfunction
" }}}
function! echo#info(msg) " {{{
	call s:echo_hl(a:msg, 'Identifier')
endfunction
" }}}
function! echo#status(msg) " {{{
	call s:echo_hl(a:msg, 'DiffText')
endfunction
" }}}
