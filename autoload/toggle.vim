function! toggle#wrap() " {{{
   if &wrap
      set nowrap
      nnoremap 0 ^
      onoremap 0 ^
      nnoremap ^ 0
      onoremap ^ 0
      nnoremap $ $
      call echo#status('[wrap off]')
   else
      set wrap
      nnoremap 0 g^
      onoremap 0 g^
      nnoremap ^ g0
      onoremap ^ g0
      nnoremap $ g$
      call echo#status('[wrap on]')
   endif
endfunction
" }}}
function! toggle#menubar() " {{{
   if &guioptions =~# 'm'
      set guioptions-=m
   else
      set guioptions+=m
   endif
endfunction
" }}}
function! toggle#verbose() " {{{
   if !&verbose
      set verbosefile=/tmp/vim-verbose.log
      set verbose=15
      call echo#status('set verbose=15')
   else
      set verbose=0
      set verbosefile=
      call echo#status('set verbose=0')
   endif
endfunction
" }}}

" vim: nofoldenable
