" ============================================================================
" File:        filetype.vim
" Description: custom filetype detect
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Wed Dec 27 15:28:16 +07 2017
" Licence:     BSD 3-Clause license
" Note:        N/A
" ============================================================================

autocmd BufRead,BufNewFile *.todo *.Todo set ft=todo

autocmd BufWritePost *after/*.vim,*autoload/*.vim,*ftdetect/*.vim,*ftplugin/*.vim,*indent/*.vim,*plugin/*.vim
			\ call source#vimfile()
" Note: source#vimfile() cannot source the file contain itself (autoload/source.vim)
" Because it cannot be redefined while still executing.
autocmd BufWritePost *autoload/source.vim
			\ runtime autoload/source.vim
			\|redraw
			\|call echo#success('autoload/source.vim has been source!')

autocmd BufWritePost *.Xresources call source#Xresources()

" Macro to bulkre(n)ame audio file (ranger):
" [EDM] Infectious - Tobu.mp3 -> [EDM] Tobu - Infectious.mp3
autocmd BufRead,BufNewFile *tmp/ let @n='0f vf-d$F.i -Ã©€klp€klxxj'

" Lazyload ultisnips (for syntax)
autocmd BufRead *.snippets silent! call plug#load('ultisnips')
