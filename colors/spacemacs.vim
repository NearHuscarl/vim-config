" ===================================================================
" File:        flat.vim
" Description: flat colorscheme
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Fri Apr 06 01:21:21 +07 2018
" Licence:     BSD 3-Clauses
" Note:        This colorscheme file is generated by colorvim command
" ===================================================================

" Name         Hex      Rgb                 Xterm
" ===============================================
" dark         #292b2e  rgb(31, 45, 58)     0
" darkred      #212026  rgb(192, 57, 43)    1
" green        #5d4d7a  rgb(39, 174, 96)    2
" yellow       #68727c  rgb(243, 156, 18)   3
" blue         #b2b2b2  rgb(41, 128, 185)   4
" purple       #b2b2b2  rgb(142, 68, 173)   5
" cyan         #827591  rgb(22, 160, 133)   6
" gray         #373040  rgb(132, 136, 139)  7
" darkgray     #7590db  rgb(44, 62, 80)     8
" red          #a45bad  rgb(231, 76, 60)    9
" lightgreen   #2aa1ae  rgb(46, 204, 113)   10
" lightyellow  #2d9574  rgb(241, 196, 15)   11
" lightblue    #ce537a  rgb(52, 152, 219)   12
" violet       #bc6ec5  rgb(155, 89, 182)   13
" lightcyan    #4f97d7  rgb(42, 161, 152)   14
" white        #5d4d7a  rgb(236, 240, 241)  15

hi clear

if exists('syntax_on')
	syntax reset
endif

let colors_name = 'spacemacs'
set background=dark

if ($TERM =~ '256' || &t_Co >= 256) || has('gui_running')
	hi Normal             ctermfg=5    ctermbg=NONE guifg=#b2b2b2 guibg=#292b2e cterm=NONE      gui=NONE
	hi LineNr             ctermfg=3    ctermbg=1    guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi FoldColumn         ctermfg=12   ctermbg=0    guifg=#ce537a guibg=#212026 cterm=NONE      gui=NONE
	hi Folded             ctermfg=3    ctermbg=NONE guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi MatchParen         ctermfg=0    ctermbg=3    guifg=#292b2e guibg=#68727c cterm=NONE      gui=NONE
	hi SignColumn         ctermfg=3    ctermbg=1    guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi Comment            ctermfg=6    ctermbg=NONE guifg=#68727c guibg=NONE    cterm=NONE      gui=NONE
	hi Conceal            ctermfg=13   ctermbg=NONE guifg=#bc6ec5 guibg=NONE    cterm=NONE      gui=NONE
	hi Constant           ctermfg=9    ctermbg=NONE guifg=#a45bad guibg=NONE    cterm=NONE      gui=NONE
	hi Error              ctermfg=8    ctermbg=0    guifg=#7590db guibg=#292b2e cterm=reverse   gui=reverse
	hi Identifier         ctermfg=8    ctermbg=NONE guifg=#7590db guibg=NONE    cterm=NONE      gui=NONE
	hi Ignore             ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi PreProc            ctermfg=12   ctermbg=NONE guifg=#ce537a guibg=NONE    cterm=NONE      gui=NONE
	hi Special            ctermfg=12   ctermbg=NONE guifg=#ce537a guibg=NONE    cterm=NONE      gui=NONE
	hi Statement          ctermfg=3    ctermbg=NONE guifg=#68727c guibg=NONE    cterm=NONE      gui=NONE
	hi String             ctermfg=11   ctermbg=NONE guifg=#2d9574 guibg=NONE    cterm=NONE      gui=NONE
	hi Todo               ctermfg=10   ctermbg=1    guifg=#2aa1ae guibg=#212026 cterm=NONE      gui=NONE
	hi Type               ctermfg=10   ctermbg=NONE guifg=#2aa1ae guibg=NONE    cterm=NONE      gui=NONE
	hi Underlined         ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=underline gui=underline
	hi NonText            ctermfg=7    ctermbg=NONE guifg=#373040 guibg=NONE    cterm=NONE      gui=NONE
	hi Pmenu              ctermfg=15   ctermbg=8    guifg=#5d4d7a guibg=#7590db cterm=NONE      gui=NONE
	hi PmenuSbar          ctermfg=NONE ctermbg=8    guifg=NONE    guibg=#7590db cterm=NONE      gui=NONE
	hi PmenuSel           ctermfg=0    ctermbg=6    guifg=#292b2e guibg=#827591 cterm=NONE      gui=NONE
	hi PmenuThumb         ctermfg=6    ctermbg=6    guifg=#827591 guibg=#827591 cterm=NONE      gui=NONE
	hi ErrorMsg           ctermfg=0    ctermbg=12   guifg=#292b2e guibg=#ce537a cterm=NONE      gui=NONE
	hi ModeMsg            ctermfg=0    ctermbg=10   guifg=#292b2e guibg=#2aa1ae cterm=NONE      gui=NONE
	hi MoreMsg            ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=NONE      gui=NONE
	hi Question           ctermfg=10   ctermbg=NONE guifg=#2aa1ae guibg=NONE    cterm=NONE      gui=NONE
	hi WarningMsg         ctermfg=1    ctermbg=NONE guifg=#212026 guibg=NONE    cterm=NONE      gui=NONE
	hi TabLine            ctermfg=3    ctermbg=1    guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi TabLineFill        ctermfg=3    ctermbg=1    guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi TabLineSel         ctermfg=11   ctermbg=1    guifg=#2d9574 guibg=#212026 cterm=NONE      gui=NONE
	hi Cursor             ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=reverse   gui=reverse
	hi CursorColumn       ctermfg=NONE ctermbg=1    guifg=NONE    guibg=#212026 cterm=NONE      gui=NONE
	hi CursorLineNr       ctermfg=3    ctermbg=1    guifg=#68727c guibg=#212026 cterm=NONE      gui=NONE
	hi CursorLine         ctermfg=NONE ctermbg=1    guifg=NONE    guibg=#212026 cterm=NONE      gui=NONE
	hi helpLeadBlank      ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi helpNormal         ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLine         ctermfg=0    ctermbg=13   guifg=#292b2e guibg=#bc6ec5 cterm=NONE      gui=NONE
	hi StatusLineNC       ctermfg=3    ctermbg=8    guifg=#68727c guibg=#7590db cterm=NONE      gui=NONE
	hi Visual             ctermfg=15   ctermbg=4    guifg=#5d4d7a guibg=#b2b2b2 cterm=NONE      gui=NONE
	hi VisualNOS          ctermfg=15   ctermbg=7    guifg=#5d4d7a guibg=#373040 cterm=underline gui=underline
	hi VertSplit          ctermfg=2    ctermbg=2    guifg=#5d4d7a guibg=#5d4d7a cterm=NONE      gui=NONE
	hi WildMenu           ctermfg=15   ctermbg=5    guifg=#5d4d7a guibg=#b2b2b2 cterm=NONE      gui=NONE
	hi Function           ctermfg=12   ctermbg=NONE guifg=#ce537a guibg=NONE    cterm=NONE      gui=NONE
	hi SpecialKey         ctermfg=7    ctermbg=NONE guifg=#373040 guibg=NONE    cterm=NONE      gui=NONE
	hi Title              ctermfg=15   ctermbg=NONE guifg=#5d4d7a guibg=NONE    cterm=NONE      gui=NONE
	hi DiffAdd            ctermfg=0    ctermbg=11   guifg=#292b2e guibg=#2d9574 cterm=NONE      gui=NONE
	hi DiffChange         ctermfg=8    ctermbg=15   guifg=#7590db guibg=#5d4d7a cterm=NONE      gui=NONE
	hi DiffDelete         ctermfg=0    ctermbg=12   guifg=#292b2e guibg=#ce537a cterm=NONE      gui=NONE
	hi DiffText           ctermfg=0    ctermbg=14   guifg=#292b2e guibg=#4f97d7 cterm=NONE      gui=NONE
	hi IncSearch          ctermfg=1    ctermbg=9    guifg=#212026 guibg=#a45bad cterm=NONE      gui=NONE
	hi Search             ctermfg=0    ctermbg=10   guifg=#292b2e guibg=#2aa1ae cterm=NONE      gui=NONE
	hi Directory          ctermfg=14   ctermbg=NONE guifg=#4f97d7 guibg=NONE    cterm=NONE      gui=NONE
	hi SpellBad           ctermfg=1    ctermbg=NONE guifg=#212026 guibg=NONE    cterm=underline gui=underline
	hi SpellCap           ctermfg=14   ctermbg=NONE guifg=#4f97d7 guibg=NONE    cterm=underline gui=underline
	hi SpellLocal         ctermfg=2    ctermbg=NONE guifg=#5d4d7a guibg=NONE    cterm=underline gui=underline
	hi SpellRare          ctermfg=9    ctermbg=NONE guifg=#a45bad guibg=NONE    cterm=underline gui=underline
	hi ColorColumn        ctermfg=NONE ctermbg=0    guifg=NONE    guibg=#292b2e cterm=NONE      gui=NONE
	hi Fzf_Foreground     ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Background     ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Highlight      ctermfg=9    ctermbg=NONE guifg=#a45bad guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_ForegroundPlus ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_BackgroundPlus ctermfg=8    ctermbg=NONE guifg=#7590db guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_HighlightPlus  ctermfg=12   ctermbg=NONE guifg=#ce537a guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Info           ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Border         ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Prompt         ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Pointer        ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Marker         ctermfg=5    ctermbg=NONE guifg=#b2b2b2 guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Spinner        ctermfg=6    ctermbg=NONE guifg=#827591 guibg=NONE    cterm=NONE      gui=NONE
	hi Fzf_Header         ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE    cterm=NONE      gui=NONE
	hi ALEErrorSign       ctermfg=9    ctermbg=NONE guifg=#a45bad guibg=NONE    cterm=NONE      gui=NONE
	hi ALEWarningSign     ctermfg=3    ctermbg=NONE guifg=#68727c guibg=NONE    cterm=NONE      gui=NONE
	hi ALEInfoSign        ctermfg=4    ctermbg=NONE guifg=#b2b2b2 guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineNormal   ctermfg=4    ctermbg=15   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineInsert   ctermfg=7    ctermbg=10   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineVisual   ctermfg=0    ctermbg=13   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineVLine    ctermfg=0    ctermbg=14   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineVBlock   ctermfg=0    ctermbg=15   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLineReplace  ctermfg=0    ctermbg=12   guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
	hi StatusLinePrompt   ctermfg=0    ctermbg=8    guifg=#292b2e guibg=NONE    cterm=NONE      gui=NONE
endif

hi link Boolean                  Constant
hi link Character                Constant
hi link Conditional              Statement
hi link Debug                    Special
hi link Define                   PreProc
hi link Delimiter                Special
hi link Exception                Statement
hi link Float                    Number
hi link HelpCommand              Statement
hi link HelpExample              Statement
hi link Include                  PreProc
hi link Keyword                  Statement
hi link Label                    Statement
hi link Macro                    PreProc
hi link Number                   Constant
hi link Operator                 Statement
hi link PreCondit                PreProc
hi link Repeat                   Statement
hi link SpecialChar              Special
hi link SpecialComment           Special
hi link StorageClass             Type
hi link Structure                Type
hi link Tag                      Special
hi link Typedef                  Type
hi link htmlEndTag               htmlTagName
hi link htmlLink                 Function
hi link htmlSpecialTagName       htmlTagName
hi link htmlTag                  htmlTagName
hi link htmlBold                 Normal
hi link htmlItalic               Normal
hi link xmlTag                   Statement
hi link xmlTagName               Statement
hi link xmlEndTag                Statement
hi link markdownItalic           Preproc
hi link asciidocQuotedEmphasized Preproc
hi link diffBDiffer              WarningMsg
hi link diffCommon               WarningMsg
hi link diffDiffer               WarningMsg
hi link diffIdentical            WarningMsg
hi link diffIsA                  WarningMsg
hi link diffNoEOL                WarningMsg
hi link diffOnly                 WarningMsg
hi link diffRemoved              WarningMsg
hi link diffAdded                String
