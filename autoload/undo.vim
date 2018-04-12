" https://superuser.com/a/264067/891930
" A function to clear the undo history
function! undo#forget()
	let old_undolevels = &undolevels
	set undolevels=-1
	edit!
	let &undolevels = old_undolevels
	unlet old_undolevels
endfunction
