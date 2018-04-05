" ============================================================================
" File:        util.vim
" Description: Utility Functions
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Fri Apr 06 01:21:21 +07 2018
" Licence:     BSD 3-Clause license
" Note:        Miscellaneous functions in autoload/ is put here
" ============================================================================

function! util#OpenHelpInTab(word) " {{{
	" silent to disable error tag not found
	" execute "silent! tab h <C-r><C-w>"
	if mode() ==# 'n'
		execute 'silent! tab h ' . expand('<cword>')
		if (&filetype ==# 'nerdtree')
			execute 'wincmd p'
		endif
	elseif mode() ==# 'v'
		execute 'silent! tab h ' . a:aword
		if (&filetype ==# 'nerdtree')
			execute 'wincmd p'
		endif
	endif
endfunction " }}}
function! util#RedirInTab(command) " {{{
	" Display output log in another tab eg. :RedirInTab mes
	redir => s:output
	silent! execute a:command
	redir END
	if empty(s:output)
		echoerr 'No output'
	else
		tabnew
		setlocal filetype=help buftype=nofile noswapfile nobuflisted bufhidden=wipe nomodified
		silent! put=s:output
	endif
endfunction " }}}
function! util#ExistsInTab(...) " {{{
	let a:NumOfWin = winnr('$')
	let a:flag = 0
	while (a:NumOfWin > 0)
		execute 'wincmd p'
		for fileType in a:000
			if (string(&filetype) == fileType)
				let a:flag = 1
			endif
		endfor
		let a:NumOfWin-=1
	endwhile
	if (a:flag)
		return 1
	endif
	return 0
endfunction " }}}
function! util#OpenTagInVSplit() " {{{
	if (winnr('$') > 1 && !ExistsInTab('nerdtree', 'tagbar'))
		let g:tagKey = expand('<cword>')
		execute 'wincmd p'
		execute 'e#'
		execute 'tjump ' g:tagKey
	else
		execute 'vertical split | wincmd p | tjump ' . expand('<cword>')
	endif
endfunction " }}}
function! util#TrimWhitespace() " {{{
	let save = winsaveview()
	%s/\s\+$//e
	call winrestview(save)
endfunction " }}}
function! util#MakeSymlink() " {{{
	if has('win64')
		if !empty(glob('$HOME\vimfiles\autoload\NearFunc.vim'))
			silent !del -F \%UserProfile\%\vimfiles\autoload\NearFunc.vim
		endif
		silent !mklink /H \%UserProfile\%\vimfiles\autoload\NearFunc.vim C:\Users\Near\Desktop\.vimrc\autoload\NearFunc.vim

		if !empty(glob('$HOME\_vimrc'))
			silent !del -F \%UserProfile\%\_vimrc
		endif
		silent !mklink /H \%UserProfile\%\_vimrc \%UserProfile\%\Desktop\.vimrc\_vimrc

		if !empty(glob('$HOME\_vsvimrc'))
			silent !del -F \%UserProfile\%\_vsvimrc
		endif
		silent !mklink /H \%UserProfile\%\_vsvimrc \%UserProfile\%\Desktop\.vimrc\_vsvimrc
	endif
endfunction " }}}
function! util#GundoAutoPreviewToggle() " {{{
	if g:gundo_auto_preview == 1
		let g:gundo_auto_preview = 0
		echo 'Gundo auto preview off'
	else
		let g:gundo_auto_preview = 1
		echo 'Gundo auto preview on'
	endif
endfunction " }}}
