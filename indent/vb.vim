" Vim indent file
" Language   : VisualBasic.NET
" Maintainers: OGURA Daiki
" Last Change: 2013-01-25

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal noexpandtab

setlocal indentexpr=VbNetGetIndent(v:lnum)
setlocal indentkeys=!^F,o,O,0=~?catch,0=~?else,0=~?elseif,0=~?end,0=~?next,0=~?end,<:>

" Only define the function once.
if exists("*VbNetGetIndent")
	finish
endif
let s:keepcpo = &cpo
set cpo&vim

function VbNetGetIndent(lnum)
	let previous_line = prevnonblank(v:lnum)
	let indent = indent(previous_line)

	let access_modifier = '\<\(Public\|Protected\|Private\|Friend\)\>'

	if previous_line =~ '\s_$' || previous_line =~ ',$' || previous_line =~ '^\s*\.'
		return indent
	elseif previous_line =~ '{$' || previous_line =~ '($' || previous_line =~ '=$'
		return indent + &shiftwidth
	elseif previous_line =~? '^'.access_modifier || previous_line =~? '^Namespace'
		return indent + &shiftwidth
	elseif previous_line =~? '^\s*'.access_modifier.'\s\(\Class\|Module\|Enum\|Interface\|Operator\)'
		return indent + &shiftwidth
	elseif previous_line =~? '\<\(Overrides\|Overridable\|Overloads\|NotOverridable\|MustOverride\|Shadows\|Shared\|ReadOnly\|WriteOnly\)\>'
		return indent + &shiftwidth
	endif

	if previous_line =~? 'Then$'
		return indent + &shiftwidth
	elseif previous_line =~? '^\s*\<\(Select Case\|Else\|ElseIf\|For\|While\|Using\|Try\|Catch\|Finally\)\>'
		return indent + &shiftwidth
	elseif previous_line =~? '^\s\+}$'
		return &shiftwidth + &shiftwidth
	endif

	if previous_line =~? 'End \(If\|Case\|Try\|Sub\|Function\|Class\|Operator\)$'
		return indent
	endif

	" labels and preprocessor get zero indent immediately
	let this_line = getline(a:lnum)
	let LABELS_OR_PREPROC = '^\s*\(\<\k\+\>:\s*$\|#.*\)'
	if this_line =~? LABELS_OR_PREPROC
		return 0
	endif

	" Find a non-blank line above the current line.
	" Skip over labels and preprocessor directives.
	let lnum = a:lnum
	while lnum > 0
		let lnum = prevnonblank(lnum - 1)
		let previous_line = getline(lnum)
		if previous_line !~? LABELS_OR_PREPROC
			let pp_line = getline(lnum - 1)
			break
		endif
	endwhile

	return indent
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

let b:undo_indent = 'setlocal '.join([
			\   'autoindent<',
			\   'expandtab<',
			\   'indentexpr<',
			\   'indentkeys<',
			\   'shiftwidth<',
			\   'softtabstop<',
			\ ])
