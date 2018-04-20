" Vim indent file
" Language   : VisualBasic.NET
" Maintainers: OGURA Daiki
" Last Change: 2013-01-25

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal autoindent

setlocal indentexpr=VbNetGetIndent(v:lnum)
setlocal indentkeys=!^F,o,O,0=~?catch,0=~?else,0=~?elseif,0=~?end,0=~?next,0=~?end,<:>

" Only define the function once.
if exists("*VbNetGetIndent")
	finish
endif
let s:keepcpo = &cpo
set cpo&vim

function VbNetGetIndent(lnum)
	let previous_linenum = prevnonblank(v:lnum - 1)
	let indent = indent(previous_linenum)

	let previous_line = getline(previous_linenum)
	let current_line = getline(v:lnum)

	let access_modifier = '\<\(Public\|Protected\|Private\|Friend\)\>'

	if previous_line =~ '{$' || previous_line =~ '($' || previous_line =~ '=$'
		let indent += &shiftwidth
	elseif previous_line =~? '^'.access_modifier || previous_line =~? '^Namespace'
		let indent += &shiftwidth
	elseif previous_line =~? '^\s*'.access_modifier.'\s\(\Class\|Sub\|Module\|Enum\|Interface\|Operator\)'
		let indent += &shiftwidth
	elseif previous_line =~? '\<\(Overrides\|Overridable\|Overloads\|NotOverridable\|MustOverride\|Shadows\|Shared\|ReadOnly\|WriteOnly\)\>'
		let indent += &shiftwidth
	elseif previous_line =~? 'Then$'
		let indent += &shiftwidth
	elseif previous_line =~? '^\s*\<\(Select Case\|Else\|ElseIf\|For\|While\|Property\|Using\|Try\|Catch\|Finally\)\>'
		let indent += &shiftwidth
	elseif previous_line =~? '^\s\+}$'
		let indent += &shiftwidth
	endif

	if current_line =~? 'End \(If\|Case\|Try\|Sub\|Function\|Class\|Property\|Operator\)$'
		let indent -= &shiftwidth
	endif

	" labels and preprocessor get zero indent immediately
	let LABELS_OR_PREPROC = '^\s*\(\<\k\+\>:\s*$\|#.*\)'
	if current_line =~? LABELS_OR_PREPROC
		return 0
	endif

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
