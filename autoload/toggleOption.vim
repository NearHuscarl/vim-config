function! s:EchoHL(msg, hl_group) " {{{
	execute 'echohl ' . a:hl_group
	echo a:msg
	echohl None
endfunction
" }}}
function! toggleOption#Wrap() " {{{
   if &wrap
      set nowrap
      nnoremap 0 ^
      onoremap 0 ^
      nnoremap ^ 0
      onoremap ^ 0
      nnoremap $ $
      call s:EchoHL('[wrap off]', 'DiffText')
   else
      set wrap
      nnoremap 0 g^
      onoremap 0 g^
      nnoremap ^ g0
      onoremap ^ g0
      nnoremap $ g$
      call s:EchoHL('[wrap on]', 'DiffText')
   endif
endfunction
" }}}
function! toggleOption#MenuBar() " {{{
   if &guioptions =~# 'm'
      set guioptions-=m
   else
      set guioptions+=m
   endif
endfunction
" }}}
function! toggleOption#Verbose() " {{{
   if !&verbose
      set verbosefile=~/Desktop/verbose.log
      set verbose=15
      call s:EchoHL('set verbose=15', 'DiffText')
   else
      set verbose=0
      set verbosefile=
      call s:EchoHL('set verbose=0', 'DiffText')
   endif
endfunction
" }}}

" vim: nofoldenable
