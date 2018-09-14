function! statusline#spacemacs#isAvailable()
endfunction

let s:base0   = { 'gui': '#1f2d3a', 'cterm':  0 }
let s:base1   = { 'gui': '#1f2d3a', 'cterm':  0 }
let s:base2   = { 'gui': '#2c3e50', 'cterm':  8 }
let s:base3   = { 'gui': '#2c3e50', 'cterm':  8 }
let s:base4   = { 'gui': '#2c3e50', 'cterm':  8 }
let s:base5   = { 'gui': '#84888b', 'cterm':  7 }
let s:base6   = { 'gui': '#ecf0f1', 'cterm': 15 }
let s:base7   = { 'gui': '#ecf0f1', 'cterm': 15 }

let s:red     = { 'gui': '#e74c3c', 'cterm':  9 }
let s:orange  = { 'gui': '#f39c12', 'cterm':  3 }
let s:yellow  = { 'gui': '#f1c40f', 'cterm': 11 }
let s:magenta = { 'gui': '#8e44ad', 'cterm':  5 }
let s:violet  = { 'gui': '#9b59b6', 'cterm': 13 }
let s:blue    = { 'gui': '#2980b9', 'cterm':  4 }
let s:cyan    = { 'gui': '#16a085', 'cterm':  6 }
let s:green   = { 'gui': '#27ae60', 'cterm':  2 }

let g:statusline#spacemacs#normal  = { 'fg': s:base6,  'bg': s:blue    }
let g:statusline#spacemacs#insert  = { 'fg': s:base7,  'bg': s:cyan    }
let g:statusline#spacemacs#visual  = { 'fg': s:base7,  'bg': s:magenta }
let g:statusline#spacemacs#vLine   = { 'fg': s:base7,  'bg': s:violet  }
let g:statusline#spacemacs#vBlock  = { 'fg': s:base7,  'bg': s:orange  }
let g:statusline#spacemacs#replace = { 'fg': s:base7,  'bg': s:red     }
let g:statusline#spacemacs#prompt  = { 'fg': s:yellow, 'bg': s:base2   }

let g:statusline#spacemacs#inactive  = { 'fg': s:base5,  'bg': s:base1  }| " StatusLineNC
let g:statusline#spacemacs#filename  = { 'fg': s:base5,  'bg': s:base2  }| " User1
let g:statusline#spacemacs#modified  = { 'fg': s:base7,  'bg': s:cyan   }| " User1
let g:statusline#spacemacs#main      = { 'fg': s:base5,  'bg': s:base2  }| " User2
let g:statusline#spacemacs#plugin    = { 'fg': s:base2,  'bg': s:yellow }| " User4
let g:statusline#spacemacs#none      = { 'fg': s:base5,  'bg': s:base0  }| " User9 - Transparent
