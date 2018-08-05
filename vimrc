" ============================================================================
" File:        .vimrc
" Description: Vim settings
" Author:      Near Huscarl <near.huscarl@gmail.com>
" Last Change: Fri Apr 13 00:42:41 +07 2018
" Licence:     BSD 3-Clause license
" Note:        This is a personal vim config. therefore most likely not work 
"              on your machine
" ============================================================================

" {{{ Variables

" echo split(&rtp, ',')[0]
" echo globpath(fnamemodify($MYVIMRC, ':p:h'), 'autoload/license.vim')
if !exists('os')
	if has('win32') || has('win64')
		let g:os = 'win'
	else
		let g:os = substitute(system('uname'), '\n', '', '')
	endif
endif

let is_nvim = has('nvim') ? 1 : 0

let $VIMHOME = expand('<sfile>:p:h')
if g:os ==# 'win'
	let s:autoload  = $VIMHOME.'\autoload\'
	let s:plugged   = $VIMHOME.'\plugged\'
	let s:session   = $VIMHOME.'\session\'
	let s:snippet   = $VIMHOME.'\snippet\'
	let s:swapfile  = $VIMHOME.'\swapfiles//'
	let s:templates = $VIMHOME.'\templates\'
	let s:undo      = $VIMHOME.'\undo\'
else
	let s:autoload  = $VIMHOME.'/autoload/'
	let s:plugged   = $VIMHOME.'/plugged/'
	let s:session   = $VIMHOME.'/session/'
	let s:snippet   = $VIMHOME.'/snippet/'
	let s:swapfile  = $VIMHOME.'/swapfiles//'
	let s:templates = $VIMHOME.'/templates/'
	let s:undo      = $VIMHOME.'/undo/'
endif

let mapleader = "\<Space>"

" }}}
" {{{ Function
function! ExistsFile(path) " {{{
	return !empty(glob(a:path))
endfunction
" }}}
function! s:BufferIsEmpty() " {{{
	 if (line('$') == 1 && getline(1) ==# '') && (filereadable(@%) == 0)
		  return 1
	 endif
	 return 0
endfunction
" }}}
function! s:CloseEmptyBuffer() " {{{
	let t:NumOfWin = winnr('$')
	while t:NumOfWin >= 1
		execute 'wincmd p'
		if s:BufferIsEmpty()
			while s:BufferIsEmpty() && t:NumOfWin >= 1
				execute 'bdelete'
				let t:NumOfWin -= 1
			endwhile
		endif
		let t:NumOfWin -= 1
	endwhile
endfunction
" }}}
" }}}
"{{{ Basic Setup

autocmd!

if g:os ==# 'Linux' && !has('gui_running') && !is_nvim
	" Fix alt key not working in gnome-terminal
	" if \e not work, replace with  (<C-v><C-[>)
	let charList = [
				\ 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
				\ 'p','q','r','s','t','u','v','w','x','y','z','1','2','3','4',
				\ '5','6','7','8','9','0', ',', '.', '/', ';',"'",'\','-','=']
	for char in charList
		execute 'set <A-' .char. ">=\e" .char
		execute "imap \e" .char. ' <A-' .char. '>'
	endfor
	" execute "set <A-]>=\e]"
	" execute "inoremap \e] <A-]>"

	execute 'set <A-[>=<C-[>'
	execute "inoremap \e[ <c-[>"
endif

set fileformat=unix
set t_Co=256                                       "More color
set encoding=utf-8                                 "Enable the use of icon or special char
scriptencoding utf-8                               "Need this for nerdtree to work properly

filetype on
filetype plugin on
filetype indent on
syntax on                                          "Color my code

if !exists('g:colors_name')
	try
		colorscheme flat
	catch /Cannot find color scheme/
		colorscheme evening
	endtry
endif

set hidden                                         "Make buffer hidden once modified

set ignorecase                                     "Ignore case when searching words
set smartcase                                      "Overwrite ignorecase if query contains uppercase
set incsearch                                      "Vim start searching while typing characters
set hlsearch                                       "Highlight all search matchs
set gdefault                                       "Substitute with flag g by default

set cursorline                                     "Highlight current line
set selection=inclusive                            "Last character is included in an operation
set scrolloff=4                                    "Min lines at 2 ends where cursor start to scroll

set wildmenu                                       "Visual Autocomplete in cmd menu
set wildmode=list,full                             "List all matches and complete each full match
set completeopt=menu,longest
set complete-=i                                    "An attempt to make YCM faster

" :put =&guifont
if has('GUI_running')
	if g:os ==# 'win'
		set guifont=Consolas:h9:b:cANSI:qDRAFT
	else
		set guifont=DejaVu\ Sans\ Mono\ Bold\ 8
	endif
	set guioptions-=m                               "Remove menu bar
	set guioptions-=T                               "Remove toolbar
	set guioptions-=r                               "Remove right-hand scroll bar
	set guioptions-=L                               "Remove left-hand scroll bar
endif

set selectmode=mouse                               "Trigger select mode when using mouse
set nomousefocus                                   "Hover mouse wont trigger other pane
set backspace=indent,eol,start                     "Backspace behave like in other app
set confirm                                        "Confirm to quit when quit without save

set laststatus=2
if has('persistent_undo')                          "check if your vim version supports it
	set undofile                                    "turn on the feature
	let &undodir = s:undo                           "Location to store undo files
	set undolevels=2000                             "Number of changes that can be undo
	set undoreload=5000                             "Number of max lines to be saved for undo
endif
let &directory = s:swapfile
"Set directory for swap files
set autoindent                                     "Copy indent from current line when insert newline
set clipboard^=unnamed                             "Use * register (use Ctrl+C, Ctrl+X or Ctrl+V)
set clipboard^=unnamedplus                         "Use + register (use Mouse selection or Middlemouse)

set number                                         "Set line number on startup
set relativenumber                                 "Choose relave number to make moving between line easier
set numberwidth=2                                  "Number Column width

set nobackup                                       "No fucking backup
set noshowmode                                     "Dont show --INSERT-- or --VISUAL--
set showmatch                                      "Highlight matching parenthesis when make the other one
set showcmd                                        "Show command as you type

set textwidth=0                                    "No insert newline when max width reached
set wrapmargin=0                                   "Number of chars outside the width limit before wrapping (disable)
set formatoptions-=t                               "Keep textwidth setting in existing files
set formatoptions+=j                               "Remove a comment leader when joining lines 
set wrap                                           "Turn off auto wrap
set showbreak=⤷\                                  "Characters at the start of wrapped lines
if has('linebreak')
	set linebreak                                   "Wrap long lines at last words instead of the last characters
	set breakindent                                 "Keep the indent level after wrapping
endif

set synmaxcol=228                                  "Maximum column for syntax highlighting
set lazyredraw                                     "Dont redraw when executing macro

set list                                           "Enable listchars option
set listchars=tab:\│\ ,extends:»,precedes:«,trail:·,nbsp:·
set backspace=2                                    "Backspace normal behaviour

set smarttab                                       "Insert tab using shiftwidth rather than softtabstop
if !exists('is_sourced')
	set tabstop=3                                   "Number of spaces for a tab character to show visually
	set shiftwidth=3                                "Number of spaces inserted when indenting
endif

set diffopt+=vertical                              "Open diff window in vertical split
set diffopt+=context:1000                          "No fold in diff mode

set noerrorbells                                   "Disable error beep
set novisualbell                                   "Disable flashing error
set t_vb=                                          "Disable error beep in terminal
set belloff=all                                    "Just shut the fuck up

if has('mksession')
	set sessionoptions-=options                     "Do not store settings and mappings in session
endif

set tags=./tags;/                                  "Search for tags file in current dir up to root
set history=10000                                  "Set number of commands and search to be remembered
set grepprg=rg\ --vimgrep
set keywordprg=:tab\ help                          "Open help file in new tab

set wildignore+=*.7z,*.bin,*.doc,*.docx,*.exe,*.ico,*.gif,*.jpg,*.jpeg,*.mp3,*.otf,*.pak,*.pdf
set wildignore+=*.png,*.ppt,*.pptx,*.rar,*.swp,*.sfdm,*.xls,*.xlsx,*.xnb,*.zip

if has('folding')
	set foldenable
	set foldmethod=marker
	" set foldopen=all
endif

if has('GUI_running')
	set guitablabel=\[%N\]\ %t\ %M                  "Tabs name: [Tab number] tabname [modified?]
else
	function! MyTabLine()
		let s = ''
		for i in range(tabpagenr('$'))
			let tabnr = i + 1 " range() starts at 0
			let winnr = tabpagewinnr(tabnr)
			let buflist = tabpagebuflist(tabnr)
			let bufnr = buflist[winnr - 1]
			let bufname = fnamemodify(bufname(bufnr), ':t')

			let s .= '%' . tabnr . 'T'  " set the tab page number (for mouse clicks)
			let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " set highlight
			let s .= ' ' . tabnr

			let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
			if &modified | let s .= '+ ' | endif
		endfor
		let s .= '%#TabLineFill#'
		return s
	endfunction
	set tabline=%!MyTabLine()
endif

let @n = "0f>a\<CR>\<Esc>$F<i\<CR>\<Esc>j"         "Newline per tag if not
"}}}
" {{{ Mappings

" {{{ Open / Source file
nnoremap <Leader>tv :edit $MYVIMRC<Bar>CloseEmptyBuffer<CR>
nnoremap <silent>,v :call source#vimrc()<CR>
nnoremap <silent>,, :call source#vimfile()<CR>
" }}}
" {{{ Movement
nnoremap ;   :|                                    "No need to hold shift to enter command mode
nnoremap gh  h|                                    "Move 1 character to the right
nnoremap gl  l|                                    "Move 1 character to the left
nnoremap :   =|                                    "Indent + motion
nnoremap :: ==|                                    "Indent

xnoremap l  ;
xnoremap h  ,
xnoremap gh h
xnoremap gl l
xnoremap :  =
xnoremap :: ==
" }}}
" {{{ Buffer
nnoremap <silent><A-'> :silent bnext<CR>|          "Go to the next buffer
nnoremap <silent><A-;> :silent bprevious<CR>|      "Go to the previous buffer
nnoremap <silent><A-e> :enew<CR>|                  "Edit new buffer
nnoremap <silent><A-b> :buffer#<CR>|               "Switch between last buffers
nnoremap <silent><Leader>q :bprevious<Bar>
			\ :bdelete #<CR>|                         "Delete current buffer
nnoremap <silent><Leader>x :e#<CR>|                "Open last closed buffer (not really)
" }}}
" {{{ Pane
nnoremap <A-m>     <C-w>w|                         "Cycle through panes
nnoremap <A-n>     <C-w>W|                         "Cycle through panes (backward)
nnoremap <A-r>     <C-w>r|                         "Rotate pane down/right
nnoremap <A-R>     <C-w>R|                         "Rotate pane up/left
" nnoremap <Leader>L <C-w>L|                         "Move current pane to the far left
" nnoremap <Leader>H <C-w>H|                         "Move current pane to the far right
" nnoremap <Leader>K <C-w>K|                         "Move current pane to the very top
" nnoremap <Leader>J <C-w>J|                         "Move current pane to the very bottom
" }}}
" {{{ Tab
nnoremap <silent><Leader><Tab> :tabnew<CR>|        "Make a new tab
nnoremap <silent><A-,> :tabprevious<CR>|           "Go to next tab
nnoremap <silent><A-.> :tabnext<CR>|               "Go to previous tab
" }}}
" {{{ Resize window
nnoremap <silent><A--> :vert res -5<CR>|           "Decrease window width by 5
nnoremap <silent><A-=> :vert res +5<CR>|           "Increase window width by 5
nnoremap <silent><A-_> :resize -5<CR>|             "Decrease window height by 5
nnoremap <silent><A-+> :resize +5<CR>|             "Increase window height by 5
" }}}
" {{{ Jump
nnoremap gy g<C-]>zz|                              "Jump to definition (Open tag list if there are more than 1 tag)
nnoremap gk <C-t>zz|                               "Jump back between tag
nnoremap gj :tag<CR>zz|                            "Jump forward between tag
nnoremap <A-\> :OpenTagInVSplit<CR>zz|             "Open tag in vertical split
nnoremap ' `|                                      "' to jump to mark (line and column)
nnoremap ` '|                                      "` to jump to mark (line)
nnoremap j gj|                                     "j version that treat wrapped line as another line
nnoremap k gk|                                     "k version that treat wrapped line as another line

if has('jumplist')
	nnoremap <A-o> <C-o>|                           "Jump back (include non-tag jump)
	nnoremap <S-o> <C-i>|                           "Jump forward (include non-tag jump)
	nnoremap <A-9> g;|                              "Jump backward
	nnoremap <A-0> g,|                              "Jump forward
endif

if &wrap
	nnoremap 0 g^|    "Go to the first non-blank character of the line, treat wrapped line as another line
	onoremap 0 g^
	nnoremap ^ g0|    "Go to the first character of the line, treat wrapped line as another line
	onoremap ^ g0
	nnoremap $ g$|    "$ version that treat wrapped line as another line
else
	nnoremap 0 ^|     "Go to the first non-blank character of the line
	onoremap 0 ^
	nnoremap ^ 0|     "Go to the first character of the line
	onoremap ^ 0
endif


nnoremap { {zz|                                    "Jump between paragraph (backward) and zz
nnoremap } }zz|                                    "Jump between paragraph (forward) and zz
" nnoremap n nzzzo
" nnoremap N Nzzzo
" }}}
" {{{ Fold
" nnoremap <A-j> zjzz
" nnoremap <A-k> zk[zzz
nnoremap z[ zo[z|                                  "Open fold, jump at the start and zz
nnoremap z] zo]z|                                  "Open fold, jump at the end and zz
nnoremap ]z ]zzz|                                  "jump at the end and zz
nnoremap [z [zzz|                                  "jump at the start and zz
nnoremap <Leader>z zMzv|                           "Open current fold and close all other fold outside
" }}}
" {{{ Diff
nnoremap <silent><expr> L  &diff ? "]czz"             : "L" | "Go to next change in diff
nnoremap <silent><expr> H  &diff ? "[czz"             : "H" | "Go to previous change in diff
nnoremap <silent><expr> du &diff ? ":diffupdate<CR>"  : ""  | "Update out-of-sync diff
nnoremap <silent><expr> dh &diff ? ":diffget //2<CR>" : ""  | "Merge change from master branch
nnoremap <silent><expr> dl &diff ? ":diffget //3<CR>" : ""  | "Merge change from merge branch
nnoremap <silent><expr> q  &diff ? ":quit<CR>"        : "q" | "Quit diff
nnoremap <silent><expr> o  &diff ? ":only<CR>"        : "o" | "Quit all except this buffer
" }}}
" {{{ Help
nnoremap Kc K|                                     "Help for word under cursor
nnoremap <silent> Ke :call help#GetHelpOxfordDictionary('cursor')<CR>
nnoremap Kd :GetHelp<Space>|                       "Search for help on (d)evdoc
nnoremap Kh :OpenHelpInTab<CR>|                    "Open help about the word under cursor
nnoremap Ka
			\ :grep! "<C-R><C-W>"<CR><Bar>
			\ :copen 20<CR>|                          "Find word under cursor in current working directory
" }}}
" {{{ Pair
nnoremap <silent>]t :tnext<CR>|                    "Go to next tag in the tag list
nnoremap <silent>[t :tprevious<CR>|                "Go to next tag in the tag list
nnoremap <silent>]c ]czz|                          "Jump forward change and zz
nnoremap <silent>[c [czz|                          "Jump backward change and zz
nnoremap <silent>]q :cnext<CR>|                    "Jump to the next quickfix item
nnoremap <silent>[q :cprev<CR>|                    "Jump to the previous quickfix item
nnoremap <silent>]Q :clast<CR>|                    "Jump to the previous quickfix item
nnoremap <silent>[Q :cfirst<CR>|                   "Jump to the previous quickfix item
" }}}
" {{{ Number
nnoremap <Up>   <C-a>|                             "Increment number under cursor
nnoremap <Down> <C-x>|                             "Decrement number under cursor
xnoremap <Up>   g<C-a>|                            "Make an increment sequence using visual block
xnoremap <Down> g<C-x>|                            "Make a decrement sequence using visual block
" }}}
" {{{ Insert Mode
inoremap <A-9> <C-w>|                              "Delete previous word
inoremap <A-0> <Esc>lmaed`axi|                     "Delete next word
inoremap <A-Space> <BS>|                           "Delete 1 character
inoremap <A-;> <C-Left>|                           "Go to the previous word
inoremap <A-'> <C-Right>|                          "Go to the next word
inoremap <A-r> <C-r>|                              "Insert register ...
inoremap <A-m> <Esc>zzli|                          "Make current line the center of window
inoremap <S-Tab> <C-p>|                            "Go to previous selection in comepletion menu
inoremap <A-v> <C-v>|                              "Insert special character
inoremap <A-d> <C-k>|                              "Insert character based on (d)iagraph
inoremap <A-o> <C-o>|                              "Execute one command and return to Insert mode
" }}}
" {{{ Operator-pending Mode
" Has been used: (a) b B (e) (f) (m) (q) (u)
" (F) (s)
" Also n,l in {in'} -> select the inner content inside the next '', works for multiline
onoremap <silent> iF  :call operator#function_name_head('i')<CR>
onoremap <silent> aF  :call operator#function_name_head('a')<CR>
onoremap <silent> if  :call operator#function_name('i', 'forward')<CR>|  "Function name object
onoremap <silent> inf :call operator#function_name('i', 'forward')<CR>|  "Search next
onoremap <silent> ilf :call operator#function_name('i', 'backward')<CR>| "Search backward
onoremap <silent> af  :call operator#function_name('a', 'forward')<CR>|  "Include (.*)
onoremap <silent> anf :call operator#function_name('a', 'forward')<CR>
onoremap <silent> alf :call operator#function_name('a', 'backward')<CR>
onoremap <silent> A  :<C-u>execute "normal! f[bvf]"<CR>|   "Array variable object
onoremap <silent> F  :<C-u>execute "normal! ggVG"<CR>|     "Whole file object
" }}}
" {{{ Popup
inoremap <expr><A-n>   pumvisible() ? "\<Down>"        : "\<C-n>"
inoremap <expr><A-p>   pumvisible() ? "\<Up>"          : ""
inoremap <expr><A-j>   pumvisible() ? "\<C-x>\<Down>"  : "\<Down>"
inoremap <expr><A-k>   pumvisible() ? "\<C-x>\<Up>"    : "\<Up>"
inoremap <expr><A-h>   pumvisible() ? "\<C-x>\<Left>"  : "\<Left>"
inoremap <expr><A-l>   pumvisible() ? "\<C-x>\<Right>" : "\<Right>"
inoremap <expr><A-,>   pumvisible() ? "\<PageUp>"      : "\<Home>"
inoremap <expr><A-.>   pumvisible() ? "\<PageDown>"    : "\<End>"
inoremap <expr><A-e>   pumvisible() ? "\<C-y>"         : ""
inoremap <expr><A-u>   pumvisible() ? "\<C-x>"         : "\<Esc>0Di"

" |-------+-----------------------------------------------------+---------------------------------|
" |       |                               Pop up visible                                          |
" |-------+-----------------------------------------------------+---------------------------------|
" |  key  |                       on                            |              off                |
" |-------+-----------------------------------------------------+---------------------------------|
" | <A-n> | Select next match in completion menu                | Open completion menu            |
" | <A-p> | Select previous match in completion menu            |                                 |
" | <A-j> | Turn off completion menu and go down one line       | Go down one line                |
" | <A-k> | Turn off completion menu and go up one line         | Go up one line                  |
" | <A-h> | Turn off completion menu and go 1 char to the left  | Go 1 char to the left           |
" | <A-l> | Turn off completion menu and go 1 char to the right | Go 1 char to the right          |
" | <A-,> | Go up 1 page in completion menu                     | Go to the beginning of the line |
" | <A-.> | Go down 1 page in completion menu                   | Go to the end of the line       |
" | <A-e> | Choose match                                        |                                 |
" | <A-u> | Turn off completion menu                            | Delete current line             |
" |-------+-----------------------------------------------------+---------------------------------|
" }}}
" {{{ Change mode
inoremap <A-i> <Esc><Esc>|                         "Switch to normal mode from insert mode
xnoremap <A-i> <Esc>|                              "Switch to normal mode from visual mode
snoremap <A-i> <Esc>|                              "Switch to normal mode from select mode
cnoremap <silent> <A-i> <C-c>:nohlsearch<CR>|      "Switch to normal mode from command mode
" }}}
" {{{ Visual mode
nnoremap gV `[v`]|                                 "Visual select the last inserted text

xnoremap $ $h
xnoremap <silent><A-k> 6<C-y>6k|                  "Scroll 6 lines above
xnoremap <silent><A-j> 6<C-e>6j|                  "Scroll 6 lines below
xnoremap <silent><A-l> 12<C-e>12j|                "Scroll 12 lines above
xnoremap <silent><A-h> 12<C-y>12k|                "Scroll 12 lines below

xnoremap Kh y:OpenHelpInTab <C-r>"<CR>|           "Open help about the word under cursor
xnoremap Ka
			\ y:grep! "<C-R>""<CR><Bar>
			\ :copen 20<CR>|                          "Find word under cursor in current working directory
xnoremap ; <Esc>:'<,'>|                            "Execute command in visual range

nnoremap <A-v> <C-q>|                              "Visual block
xnoremap <A-v> <C-q>|                              "Visual block (Use to switch to VBlock from Visual)
" }}}
" {{{ Command mode
cnoremap <A-c> <C-r><C-w>|                         "Insert word under cursor
cnoremap <A-a> <C-r><C-a>|                         "Insert WORD under cursor
cnoremap <A-9> <C-w>|                              "Delete previous word
cnoremap <A-0> <C-Right><C-w><BS>|                 "Delete forward word (Work for 1 whitespace only)
cnoremap <A-Space> <BS>|                           "Delete 1 character
cnoremap <A-u> <End><C-u>|                         "Delete current line
cnoremap <A-;> <C-Left>|                           "Backward one word
cnoremap <A-'> <C-Right>|                          "Forward one nail word
cnoremap <A-j> <Down>|                             "Go to the next command in history
cnoremap <A-k> <Up>|                               "Go to the previous command in history
cnoremap <A-n> <C-g>|                              "Next search in command mode
cnoremap <A-p> <C-t>|                              "Previous search in command mode
cnoremap <A-h> <Left>|                             "Go to the left one character
cnoremap <A-l> <Right>|                            "Go to the right one character
cnoremap <A-,> <Home>|                             "Move to the beginning of the line
cnoremap <A-.> <End>|                              "Move to the end of the line
cnoremap <silent><A-y> <C-f>yy:q<CR>|              "Copy command content
cnoremap <A-r> <C-r>*|                             "Paste yanked text in command line

" command line window
nnoremap <silent> <A-q>    q::execute "nnoremap <buffer> q :q\r"<CR>
nnoremap <silent> <A-/>    q/:execute "nnoremap <buffer> q :q\r"<CR>
cnoremap <silent> <A-q> <C-f>:execute "nnoremap <buffer> q :q\r"<CR>
" }}}
" {{{ Replace
xnoremap <Leader>rf y:%s/\<<C-r>"\>/|           "Replace selected word in this file
xnoremap <Leader>rb y:bufdo %s/\<<C-r>"\>/|     "Replace selected word across buffers
nnoremap <Leader>rk  :%s/\<<C-r><C-w>\>/|       "Replace current word in this file
nnoremap <Leader>rK  :bufdo %s/\<<C-r><C-w>\>/| "Replace current word across buffers
nnoremap <Leader>rf  :%s/|                      "Replace in this file
nnoremap <Leader>rb  :bufdo %s/|                "Replace across buffers
nnoremap R gR| "Replace mode that play nice with tab
nnoremap gR R| "Old one
nnoremap r gr| "One character version
nnoremap gr r| "Old one
" }}}
" {{{ Search match
xnoremap / :<C-u>call gn#search_selected_word()<CR>
nnoremap <A-8> :call gn#search_current_word()<CR>| "Search word under cursor. use with gn
" }}}
" {{{ Misc
nnoremap U :later 1f<CR>|                          "Go to the latest change
inoremap < <|                                      "Pathetic attempt to fixing < map
cnoremap < <
nnoremap << <_|                                    " << not working
nnoremap <F8> mzggg?G`z|                           "Encrypted with ROT13, just for fun
nnoremap Q @q|                                     "Execute macro
xnoremap > >gv|                                    "Make indent easier
xnoremap < <gv|                                    "Make indent easier
nnoremap yp :call yank#Path()<CR>|                 "Yank and show current path
nnoremap <silent><A-u> <C-r>
nnoremap gD gD:nohlsearch<CR>
nnoremap gd gd:nohlsearch<CR>
nnoremap <A-p> "_ciw<C-r>*<esc>|                          "Paste over a word
nnoremap <silent><A-F1> :ToggleMenuBar<CR>|               "Toggle menu bar
nnoremap <A-Space> a<Space><Left><esc>|                   "Insert a whitespace
nnoremap <Enter> o<Esc>|                                  "Make new line
nnoremap Y y$|                                            "Make Y yank to endline (same behaviours as D or R)
nnoremap <C-w> :ToggleWrap<CR>|                           "Toggle wrap option
nnoremap <silent>- :update<CR>|                           "Write if file content changed
nnoremap <silent><Leader>- :call timestamp#update()<CR>|  "Write changes with sudo
nnoremap <silent><Leader><Leader>- :SudoWrite<CR>|        "Write changes with sudo
nnoremap <silent><Leader>tV :ToggleVerbose<CR>
nnoremap <silent><Leader><CR> :ExecuteFile<CR>|           "Run executable file (python, ruby, bash..)
nnoremap <Leader><Leader><CR> :ExecuteFile<Space>|        "Same with argument
nnoremap <silent><Leader>R :redraw!<CR>
nnoremap <silent><Leader>cg :call syntax#GetGroup()<CR>
nnoremap <silent><Leader>cf :call syntax#YankFgColor()<CR>
nnoremap <silent><Leader>cb :call syntax#YankBgColor()<CR>
" }}}
" {{{ Abbreviation
cabbrev vbnm verbose<Space>nmap
cabbrev vbim verbose<Space>imap
cabbrev vbvm verbose<Space>vmap
cabbrev vbom verbose<Space>omap
cabbrev vbcm verbose<Space>cmap
" }}}
" {{{ Command difinition
command! -complete=shellcmd -nargs=+ Shell call shell#exe(<q-args>)
command! -nargs=* GetHelp silent! call help#GetHelp(<f-args>)
command! ToggleMenuBar call toggle#menubar()
command! ToggleVerbose call toggle#verbose()
command! ToggleWrap    call toggle#wrap()
command! ToggleHeader                           call header#toggle()
command! -nargs=? -complete=help OpenHelpInTab  call util#OpenHelpInTab(<q-args>)
command! CloseEmptyBuffer                       call <SID>CloseEmptyBuffer()
command! -nargs=+ -complete=command RedirInTab  call util#RedirInTab(<q-args>)
command! -nargs=+ ExistsInTab                   echo util#ExistsInTab(<f-args>)
command! OpenTagInVSplit                        call util#OpenTagInVSplit()
command! TrimWhitespace                         call util#TrimWhitespace()
command! MakeSymlink                            call util#MakeSymlink()
command! -range=% Space2Tab      <line1>,<line2>call retab#Space2Tab()
command! -range=% Space2TabAll   <line1>,<line2>call retab#Space2TabAll()
command! -range=% Tab2SpaceAll   <line1>,<line2>call retab#Tab2SpaceAll()
command! SudoWrite                              w !sudo tee > /dev/null %
command! -nargs=* -bar ExecuteFile              call execute#File(<q-args>)
command! -nargs=0 ClearUndo                     call undo#forget()
" }}}

" }}}
"{{{ Vim-plug
call plug#begin(s:plugged)

" Essential
"{{{ Bufferline
Plug 'bling/vim-bufferline'

let g:bufferline_rotate              = 2
let g:bufferline_solo_highlight      = 1
"}}}
"{{{ Fzf
Plug 'junegunn/fzf.vim'
if g:os ==# 'win'
	Plug '~\vimfiles\plugged\fzf'
else
	Plug '~/.vim/plugged/fzf'
endif

let g:fzf_colors = {
			\ 'fg':      ['fg', 'Fzf_Foreground'],
			\ 'bg':      ['bg', 'Fzf_Background'],
			\ 'hl':      ['fg', 'Fzf_Highlight'],
			\ 'fg+':     ['fg', 'Fzf_ForegroundPlus'],
			\ 'bg+':     ['bg', 'Fzf_BackgroundPlus'],
			\ 'hl+':     ['fg', 'Fzf_HighlightPlus'],
			\ 'info':    ['fg', 'Fzf_Info'],
			\ 'border':  ['fg', 'Fzf_Border'],
			\ 'prompt':  ['fg', 'Fzf_Prompt'],
			\ 'pointer': ['fg', 'Fzf_Pointer'],
			\ 'marker':  ['fg', 'Fzf_Marker'],
			\ 'spinner': ['fg', 'Fzf_Spinnner'],
			\ 'header':  ['fg', 'Fzf_Header'],
			\ }

let g:fzf_option='
			\ --no-reverse
			\ --bind=alt-k:up,alt-j:down
			\ --bind=alt-h:backward-char,alt-l:forward-char
			\ --bind=alt-n:backward-word,alt-m:forward-word
			\ --bind=alt-i:abort,alt-d:kill-line,alt-e:jump,alt-t:toggle
			\ --prompt=\>\ 
			\ --multi'

let g:grep_cmd = 'rg
			\ --column --line-number --no-heading
			\ --hidden --ignore-case --follow --color "always" '

command! -nargs=+ Grep
			\ call fzf#vim#grep(g:grep_cmd . shellescape(<q-args>) . ' '. project#GetRoot()
			\ , 0, {'options': g:fzf_option}, 0)
command! -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, {
			\   'options': g:fzf_option,
			\   'source': 'rg --files --hidden --follow --no-messages'
			\ }, 0)
command! -nargs=1 FilesAbsolute
			\ call fzf#run({
			\   'source': 'rg ' . <args> . ' --files --hidden --follow --no-messages',
			\   'sink': 'edit',
			\   'options': g:fzf_option
			\ })

command! Commands call fzf#vim#commands({'options': g:fzf_option}, 0)
command! Colors   call fzf#vim#colors({'options': g:fzf_option}, 0)
command! MRU      call fzf#vim#history({'options': g:fzf_option}, 0)
command! Help     call fzf#help({'options': g:fzf_option}, 0) " open help in tab
command! Tags     call fzf#vim#tags(<q-args>, {'options': g:fzf_option}, 0)
command! Maps     call fzf#vim#maps(<q-args>, {'options': g:fzf_option}, 0)
command! Lines    call fzf#vim#lines({'options': g:fzf_option}, 0)
command! BLines   call fzf#vim#buffer_lines({'options': g:fzf_option}, 0)
command! Buffers  call fzf#vim#buffers({'options': g:fzf_option}, 0)
command! Commit   call fzf#vim#commits({'options': g:fzf_option}, 0)
command! BCommit  call fzf#vim#buffer_commits({'options': g:fzf_option}, 0)

nnoremap gr :Grep<Space>
" Respect .gitignore. Full path and can open multiple file
nnoremap <silent> <Leader>eP :FilesAbsolute project#GetRoot()<CR>
" Respect .gitignore. Shorter path but cant open multiple files in subdirectory
nnoremap <silent> <Leader>ep :execute 'Files ' . project#GetRoot()<CR>
nnoremap <silent> <Leader>ew :Grep <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent> <Leader>eW :Grep <C-r>=expand('<cWORD>')<CR><CR>
nnoremap <silent> <Leader>fc :Commands<CR>
nnoremap <silent> <Leader>ec :Files<CR>|       "Fzf files from cwd ([WIP] set autochdir?)
nnoremap <silent> <Leader>eh :Files $HOME<CR>
nnoremap <silent> <Leader>ev :Files $HOME/.vim/<CR>
nnoremap <silent> <Leader>em :MRU<CR>
nnoremap <silent> <Leader>h  :Help<CR>
nnoremap <silent> <Leader>j  :Tags<CR>
nnoremap <silent> <Leader>m  :Maps<CR>
nnoremap <silent> <Leader>l  :BLines<CR>
nnoremap <silent> <Leader>L  :Lines<CR>
nnoremap <silent> <Leader>b  :Buffers<CR>
" }}}

" {{{ Repeat
Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>(ale_previous_wrap)zz", v:count)
" }}}
"{{{ Target
Plug 'wellle/targets.vim'

let g:targets_pairs = '()b {}B [] <>e'
let g:targets_quotes = '"q '' `'
let g:targets_separators = ', . ; : + - = ~ _u * # / | \ & $'
"}}}
"{{{ Incsearch
Plug 'haya14busa/incsearch.vim', {'on': [
			\ '<Plug>(incsearch-forward)',
			\ '<Plug>(incsearch-backward)',
			\ '<Plug>(incsearch-stay)',
			\ '<Plug>(incsearch-nohl-n)',
			\ '<Plug>(incsearch-nohl-N)',
			\ '<Plug>(incsearch-nohl-*)',
			\ '<Plug>(incsearch-nohl-#)',
			\ '<Plug>(incsearch-nohl-g*)',
			\ '<Plug>(incsearch-nohl-g#)',
			\ ]}

let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n  <Plug>(incsearch-nohl-n)zzzo
map N  <Plug>(incsearch-nohl-N)zzzo
map *  <Plug>(incsearch-nohl-*)zzzo
map #  <Plug>(incsearch-nohl-#)zzzo
map g* <Plug>(incsearch-nohl-g*)zzzo
map g# <Plug>(incsearch-nohl-g#)zzzo
"}}}
"{{{ Vim-man
Plug 'vim-utils/vim-man', {'on': []}

" ../vim-man/plugin/man.vim
command! -nargs=* -bar -complete=customlist,man#completion#run Man
			\ call plug#load('vim-man')
			\|call man#get_page('horizontal', <f-args>)
"}}}
" vim-rhubarb {{{
" :Gbrowse to view current file on github
Plug 'tpope/vim-rhubarb'
" }}}
"{{{ Fugitive
Plug 'tpope/vim-fugitive'

nnoremap <silent> <Leader>gs  :Gstatus<CR>|                              "Git status in vim!
nnoremap <silent> <Leader>ga  :silent Git add %:p <Bar> redraw!<CR>|     "Git add in vim!
nnoremap <silent> <Leader>gbl :Gblame<CR>|                               "Git blame in vim!
nnoremap <silent> <Leader>gw  :Gwrite<CR>|                               "Git write in vim!
nnoremap <silent> <Leader>gr  :Gread<CR>|                                "Git read in vim!
nnoremap <silent> <Leader>gd  :Gdiff<CR>|                                "Git diff in vim!
nnoremap <silent> <Leader>gP  :Gpull<CR>|                                "Git pull in vim!
nnoremap <silent> <Leader>gp  :Gpush<CR>|                                "Git push in vim!
nnoremap <silent> <Leader>gm  :Gmove<CR>|                                "Git move in vim!
nnoremap <silent> <Leader>gc  :Gcommit<CR>|                              "Git commmit in vim!
nnoremap <silent> <Leader>gbr :Gbrowse<CR>|                              "Open current file on github
nnoremap <silent> <Leader>gk  :Ggrep! <C-r><C-w><CR><CR>|                "Find word under (k)ursor in repo
nnoremap <silent> <Leader>gl  :Glog!<CR><Bar>:bot copen<CR>|             "Load all version before
nnoremap <silent> <Leader>ggc :Glog! --grep= -- %<C-Left><C-Left><Left>| "Search for commit message
nnoremap <silent> <Leader>ggd :Glog! -S -- %<C-Left><C-Left><Left>|      "Search content in diffs history
"}}}
" {{{ AsyncRun
Plug 'skywind3000/asyncrun.vim'
" Async with Fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" }}}
" {{{ Ale
Plug 'w0rp/ale'

let g:ale_fixers            = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.python     = ['pylint']
let g:ale_fixers.scss       = ['scsslint']
let g:ale_fixers.vim        = ['vint']
let g:ale_sign_error        = ''
let g:ale_sign_warning      = ''
let g:ale_sign_info         = ''
let g:ale_lint_on_text_changed = 0

nmap [a <Plug>(ale_previous_wrap)zz
nmap ]a <Plug>(ale_next_wrap)zz
" }}}

" vim-misc {{{
Plug 'xolox/vim-misc', {'on': []}
" }}}
" vim-shell {{{
Plug 'xolox/vim-shell', {'on': []}
" }}}
"{{{ Session
Plug 'xolox/vim-session', {'on': []}

let g:session_directory    = s:session
let g:session_autoload     = 'no'
let g:session_autosave     = 'yes'
let g:session_default_name = 'Default'

"OpenSession -> SessionOpen 
"ViewSession -> SessionView 
let g:session_command_aliases = 1
let g:session_map_list = [
			\ '<Leader>so',
			\ '<Leader>sO',
			\ '<Leader>ss',
			\ '<Leader>sS',
			\ '<Leader>sv',
			\ '<Leader>sV',
			\ '<Leader>sc',
			\ '<Leader>sd',
			\ ]

nnoremap <silent><Leader>so :call lazyload#session#Open(session_map_list)<CR>
nnoremap <silent><Leader>sO :call lazyload#session#OPEN(session_map_list)<CR>
nnoremap <silent><Leader>ss :call lazyload#session#Save(session_map_list)<CR>
nnoremap <silent><Leader>sS :call lazyload#session#SAVE(session_map_list)<CR>
nnoremap <silent><Leader>sv :call lazyload#session#View(session_map_list)<CR>
nnoremap <silent><Leader>sV :call lazyload#session#VIEW(session_map_list)<CR>
nnoremap <silent><Leader>sc :call lazyload#session#Close(session_map_list)<CR>
nnoremap <silent><Leader>sd :call lazyload#session#Delete(session_map_list)<CR>
" }}}

" {{{ Color Config
Plug 'NearHuscarl/vim-color-config', {'on': [
			\ 'ColorConfigGenerate',
			\ 'ColorConfigGenerateVerbose',
			\ 'ColorConfigInfo',
			\ 'ColorConfigResetDefault',
			\ ]}

let g:color_config_output_path = '$HOME/.vim/colors/'
augroup ColorConfig
	autocmd!
	autocmd BufWritePost *colors/config/*.yaml ColorConfigGenerate
augroup END
" }}}

"{{{ Sneak
Plug 'justinmk/vim-sneak', {'on': [
			\ '<Plug>Sneak_f',
			\ '<Plug>Sneak_F',
			\ '<Plug>Sneak_t',
			\ '<Plug>Sneak_T'
			\ ]}

let g:sneak#use_ic_scs = 1          " Case determined by 'ignorecase' and 'smartcase'
let g:sneak#absolute_dir = 1        " Movement in sneak not based on sneak search direction

if ExistsFile(s:plugged . 'vim-sneak')
	nmap <silent> l <Plug>Sneak_;
	nmap <silent> h <Plug>Sneak_,
	vmap <silent> l <Plug>Sneak_;
	vmap <silent> h <Plug>Sneak_,
else
	nnoremap l ;| "Repeat latest f, F, t or T command (forward)
	nnoremap h ,| "Repeat latest f, F, t or T command (backward)
endif

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
vmap f <Plug>Sneak_f
vmap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
vmap t <Plug>Sneak_t
vmap T <Plug>Sneak_T

" 3 characters search instead
let g:sneak_map_list = ['s', 'S']
nnoremap <silent>s :call lazyload#sneak#ForwardNormal(sneak_map_list)<CR>
nnoremap <silent>S :call lazyload#sneak#BackwardNormal(sneak_map_list)<CR>
"}}}
" vim-instant-markdown {{{
" Plug 'suan/vim-instant-markdown'
" }}}
" vim-markdown-composer {{{
Plug 'euclio/vim-markdown-composer'
" }}}
" {{{ InstantRst
Plug 'Rykka/InstantRst'
let g:instant_rst_forever = 1 " keep opening rst in browser
" }}}
"{{{ Smooth Scroll
Plug 'terryma/vim-smooth-scroll'

nnoremap <silent> <A-j> :call smooth_scroll#down(6, 0, 2)<CR>
nnoremap <silent> <A-k> :call smooth_scroll#up(6, 0, 2)<CR>
nnoremap <silent> <A-l> :call smooth_scroll#down(15, 0, 3)<CR>
nnoremap <silent> <A-h> :call smooth_scroll#up(15, 0, 3)<CR>
" nnoremap <silent> H     :call smooth_scroll#up(40, 0, 10)<CR>
" nnoremap <silent> L     :call smooth_scroll#down(40, 0, 10)<CR>
if g:os ==# 'win'
	let s:smoothScrollPath = '~\vimfiles\plugged\vim-smooth-scroll\autoload\smooth_scroll.vim'
else
	let s:smoothScrollPath = '~/.vim/plugged/vim-smooth-scroll/autoload/smooth_scroll.vim'
endif
if !ExistsFile(s:smoothScrollPath)
	nnoremap <silent><A-l> 10<C-e>10j
	nnoremap <silent><A-h> 10<C-y>10k
endif
"}}}

" Filetype
" vim-javascript {{{
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" }}}
" vim-jsx {{{
Plug 'https://github.com/mxw/vim-jsx' " {'for': 'javascript.jsx'} will not work. Use g:jsx_ext_required instead
let g:jsx_ext_required = 1
" }}}
" {{{ Python Syntax
Plug 'hdima/python-syntax', {'for': 'python'}
let python_highlight_all = 1
" }}}
" {{{ Haskell
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = &tabstop
let g:haskell_indent_case = &tabstop
let g:haskell_indent_let = &tabstop
let g:haskell_indent_where = &tabstop
let g:haskell_indent_before_where = &tabstop
let g:haskell_indent_after_bare_where = &tabstop
let g:haskell_indent_do = &tabstop
let g:haskell_indent_in = &tabstop
let g:haskell_indent_guard = &tabstop
let g:haskell_indent_case_alternative = &tabstop
let g:cabal_indent_section = &tabstop
" }}}
" vim-css3-syntax {{{
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
" }}}
" vim-csharp {{{
Plug 'OrangeT/vim-csharp', {'for': 'cs'}
" }}}
" vim-prettier {{{
Plug 'prettier/vim-prettier', {
			\ 'do': 'npm install',
			\ 'for': ['javascript', 'jsx', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'true'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
" }}}
"{{{ Emmet
Plug 'mattn/emmet-vim', {'on': ['EmmetInstall']}

let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
			\   'html' : {
			\      'indentation' : '	',
			\   },
			\   'javascript.jsx' : {
			\      'extends' : 'jsx',
			\   },
			\}

autocmd BufWrite,CursorHold,CursorHoldI *.html,*.jsx EmmetInstall
let g:user_emmet_mode='i'
let g:user_emmet_leader_key    = '<A-o>'
let g:user_emmet_next_key      = '<A-o>n'
let g:user_emmet_prev_key      = '<A-o>p'
let g:user_emmet_removetag_key = '<A-o>r'
"}}}

"{{{ SimpylFold
Plug 'tmhedberg/SimpylFold'

let g:SimpylFold_fold_docstring = 0
let b:SimpylFold_fold_docstring = 0
"}}}
" vim-css-color {{{
Plug 'ap/vim-css-color'
" }}}

"{{{ Easy Align
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}

xnoremap ga <Esc>:'<,'>EasyAlign // dl<Left><Left><Left><Left>| " Align with delimiter aligned left
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups = []       " Vim Align ignore comment by default
"}}}

"{{{ Commentary
Plug 'tpope/vim-commentary', {'on': [
		 \ '<Plug>Commentary',
		 \ '<Plug>CommentaryLine'
		 \ ]}

map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap gCC gggcG
"}}}
"{{{ Ultisnips
Plug 'sirver/ultisnips', {'on': [
			\ 'UltiSnipsEdit',
			\ 'UltiSnipsEdit!'
			\ ]}

nnoremap <Leader>U :UltiSnipsEdit<CR>|                            " Open new file to define snippets
nnoremap <Leader><Leader>U :UltiSnipsEdit!<CR>|                   " Open all available files to select
inoremap <silent><Tab> <C-r>=lazyload#ultisnips#Load()<CR>

let g:UltiSnipsSnippetsDir = s:snippet                             " Custom snippets stored here
let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'snippet']        " Directories list for ultisnips to search
let g:UltiSnipsEditSplit           = 'normal'
" let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsListSnippets        = '<C-e>'
let g:UltiSnipsJumpForwardTrigger  = '<A-j>'
let g:UltiSnipsJumpBackwardTrigger = '<A-k>'
"}}}
"{{{ Auto Pairs
autocmd CursorHold,CursorHoldI * :silent! all autopairs#AutoPairsTryInit()
Plug 'jiangmiao/auto-pairs' ", {'on': []}

let g:AutoPairsMoveCharacter      = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsShortcutBackInsert = ''
"}}}
"{{{ Surround
Plug 'tpope/vim-surround', {'on': [
			\ '<Plug>Ysurround',
			\ '<Plug>Dsurround',
			\ '<Plug>Csurround',
			\ '<Plug>CSurround',
			\ '<Plug>Ysurround',
			\ '<Plug>YSurround',
			\ '<Plug>Yssurround',
			\ '<Plug>YSsurround',
			\ '<Plug>YSsurround',
			\ '<Plug>VSurround',
			\ '<Plug>VgSurround'
			\ ]}

nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
xmap s   <Plug>VSurround
xmap gs  <Plug>VgSurround
"}}}

" {{{ Youcompleteme
" Plug 'Valloric/YouCompleteMe'
"
let g:ycm_semantic_triggers = {
			\   'css':  [ 're!^\s{3,}', 're!^\t{1,}', 're!:\s'],
			\   'scss': [ 're!^\s{3,}', 're!^\t{1,}', 're!:\s'],
			\ }
let g:ycm_key_list_select_completion = []
" }}}
" deoplete {{{
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-jedi', {'for': 'python'}
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'jsx']}
else
	" Dont have plan to work with vim for long...
endif
" }}}

" vim-autoswap {{{
Plug 'gioele/vim-autoswap'
" }}}
"{{{ FastFold
" Plug 'Konfekt/FastFold'
let g:fastfold_fold_command_suffixes  = []
let g:fastfold_fold_movement_commands = []
let g:fastfold_skip_filetypes         = ['vim', 'py']
"}}}
"{{{ Gundo
Plug 'NearHuscarl/gundo.vim', {'on': 'GundoToggle'}

if has('python3') && !has('python')
	let g:gundo_prefer_python3 = 1
endif

nnoremap <Leader>u :GundoToggle<CR>
let gundo_map_move_older = ''
let gundo_map_move_newer = ''
let g:gundo_preview_height   = 11
let g:gundo_preview_bottom   = 1
let g:gundo_right            = 0
let g:gundo_help             = 0
let g:gundo_return_on_revert = 0
let g:gundo_auto_preview     = 1
"}}}
call plug#end()

let g:plug_window = 'vertical botright new'

nnoremap <Leader>pc :PlugClean<CR>|                    "Clean directory
nnoremap <Leader>pC :PlugClean!<CR>|                   "Clean directory
nnoremap <Leader>ps :PlugStatus<CR>|                   "Check plugin status
nnoremap <Leader>pd :PlugDiff<CR>|                     "Show changes between update
nnoremap <Leader>pi :PlugInstall<Space><C-d>|          "Install new plugin
nnoremap <Leader>pv :PlugUpgrade<CR>|                  "Update vim-plug
nnoremap <Leader>pu :PlugUpdate<Space><C-d>|           "Update other plugins
nnoremap <Leader>pU :PlugUpdate<CR>|                   "Update all plugins
"}}}
"{{{ Autocmd

function! InitPyTemplate()
	if line('$') == 1 && getline(1) ==# ''
		if match(expand('%'), 'test_') != -1
			execute '0read ' . s:templates . 'skeleton.test.py'
		else
			execute '0read ' . s:templates . 'skeleton.py'
		endif
	endif
endfunction
" :help template.
augroup TemplateFile
	autocmd!
	for ft in ['css', 'html', 'js', 'scss', 'sh']
		execute 'autocmd BufNewFile *.' . ft . ' 0read ' . s:templates . 'skeleton.' . ft
		execute 'autocmd BufRead *.' . ft .
					\ ' if line("$") == 1 && getline(1) ==# "" | 0read ' . s:templates . '/skeleton.' . ft . '| endif'
		autocmd BufNewFile,BufRead *.py call InitPyTemplate()
	endfor
augroup END

augroup Statusline
	autocmd!
	autocmd VimEnter * call statusline#SetStatusline()
	autocmd BufEnter * silent! call statusline#UpdateStatuslineInfo()
	autocmd CursorHold * let g:statuslineFileSize = statusline#SetFileSize()
augroup END

augroup VimPlugLazyloadSyntax
	autocmd!
	autocmd User python-syntax syntax on
	autocmd User haskell-vim syntax on
	autocmd User vim-javascript syntax on
	autocmd User vim-css3-syntax syntax on
augroup END

augroup SaveView
	autocmd!
	" Save view when switch buffer
	autocmd BufEnter * if exists('b:winView') | call winrestview(b:winView) | endif
	autocmd BufLeave * let b:winView = winsaveview()
	" Save cursor position when open new file
	autocmd BufReadPost *
				\ if line("'\"") >= 1 && line("'\"") <= line("$")
				\|  execute "normal! g`\""
				\|endif
augroup END

augroup SwitchBuffer
	autocmd!
	" autocmd BufEnter * set cursorline | silent! lcd %:p:h
	autocmd BufEnter * set cursorline
	autocmd BufEnter * set number relativenumber
	autocmd BufLeave * set nocursorline
	autocmd BufLeave * set norelativenumber
augroup END

augroup AutoPairHTML
	autocmd!
	autocmd BufEnter *.html let g:AutoPairs["<"] = '>'
	autocmd BufLeave *.html unlet g:AutoPairs["<"]
augroup END

" always save to AutoSave session on exit if current instance not belong to
" any session before
augroup SessionAutoSave
	autocmd!
	autocmd VimLeavePre *
				\ if v:this_session == ''
				\|  execute 'mksession!' . g:session_directory . 'AutoSave.vim'
				\|endif
augroup END

augroup InstantRstAutoOpen
	autocmd!
	autocmd BufRead *.rst InstantRst
augroup END

autocmd QuickFixCmdPost * cwindow
autocmd CursorHold * nohlsearch
autocmd BufNewFile,BufRead *.xaml set filetype=xml
" autocmd FocusLost * if &modified && filereadable(expand("%:p")) | update | endif

autocmd BufWritePost *.py,*.js,*.vim,*vimrc call ctags#update()

" Auto resize panes when window is resized
autocmd VimResized * wincmd =
" Auto update buffer changes outside of vim in real time
autocmd FocusGained * checktime

if has('gui_running')
	if g:os ==# 'Linux'
		autocmd VimEnter *
					\ if executable('wmctrl')
					\|   call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
					\|endif
	elseif g:os ==# 'win'
		autocmd GUIEnter * simalt ~x            "Open vim in maximum winow size
	endif
endif
"}}}
"{{{ Highlight Group
call statusline#SetHighlight()
if !exists(g:colors_name)
	highlight link Sneak None
endif
"}}}

if !exists('is_sourced')
	let g:is_sourced = 1
endif

" flink eh --hide-pointer --geometry 1000x600 --zoom fill
" feh --hide-pointer --thumbnails --thumb-height 60 --thumb-width 100 --index-info "" --geometry 1000x600 --image-bg black
