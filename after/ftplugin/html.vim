if exists(":GetHelp") == 2
   setlocal keywordprg=:GetHelp
endif

" add newline to tag
nnoremap <A-CR> ^f>lcit<CR><Up><End><CR><C-r>"<Esc>
