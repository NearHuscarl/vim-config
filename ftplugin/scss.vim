" Automatically insert the current comment leader after hitting <Enter>
" in Insert mode respectively after hitting 'o' or 'O' in Normal mode
setlocal formatoptions+=ro

" SCSS comments are either /* */ or //
setlocal comments=s1:/*,mb:*,ex:*/,://

nnoremap <silent><buffer> <Leader>B :call CSSBeautify()<CR>
nnoremap <silent><buffer> <Leader>i :call css#ToggleInsertImportant()<CR>
nnoremap <silent><buffer> <Leader>I :set opfunc=css#ToggleInsertImportantRange<CR>g@
nnoremap <silent><buffer> p :call css#Paste()<CR>
nnoremap <silent><buffer> yw :call css#CopyOrCut('y', 'yw')<CR>
nnoremap <silent><buffer> dw :call css#CopyOrCut('d', 'dw')<CR>
nnoremap <silent><buffer> <Leader><Leader>c :call css#ToggleHexOrRgb()<CR>
