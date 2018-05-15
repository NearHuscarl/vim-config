#Persistent
#InstallKeybdHook
#InstallMouseHook
#KeyHistory 100


; 1: A window's title must start with the specified WinTitle to be a match
; 2: A window's title can contain WinTitle anywhere inside it to be a match
; 3: A window's title must exactly match WinTitle to be a match
SetTitleMatchMode, 2

GroupAdd DONT_TOUCH, ahk_exe devenv.exe
GroupAdd DONT_TOUCH, ahk_class Chrome_WidgetWin_1
GroupAdd DONT_TOUCH, ahk_class Vim
GroupAdd DONT_TOUCH, ahk_class Qt5QWindowIcon
GroupAdd DONT_TOUCH, ahk_class ConsoleWindowClass
GroupAdd DONT_TOUCH, ahk_class VirtualConsoleClass
GroupAdd DONT_TOUCH, ahk_class classFoxitReader 

GroupAdd EXTRA, ahk_class WorkerW         ; sdflj
GroupAdd EXTRA, ahk_class CabinetWClass   ; Explorer
GroupAdd EXTRA, ahk_class RegEdit_RegEdit ; Regedit

; Turn off caplock key function
SetCapsLockState, AlwaysOff
return

; Make Caplock acts as alt
Capslock::Alt
return

; Make useless PageUp become capslock (capslock shft l below will cover that)
RAlt::Capslock
return

IsModifierKey(key) { ; {{{
	modifierKeys = Ctrl,LCtrl,RCtrl
		,Alt,LAlt,RAlt
		,Shift,LShift,RShift
		,Win,LWin,RWin

	if key in %modifierKeys%
		return True

	return False
}
; }}}
IsSpecialKey(key) { ; {{{
	specialKeys = F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24
		,!,#,+,^,{,}
		,Enter,Esc,Space,Tab,BS,Del,Ins,Up,Down,Left,Right,Home,End,PgUp,PgDn
		,Capslock,ScrollLock,NumLock,AppsKey,Sleep
		,Numpad0,Numpad1,Numpad2,Numpad3,Numpad4,Numpad5,Numpad6,Numpad7,Numpad8,Numpad9
		,NumpadDot,NumpadEnter,NumpadMult,NumpadDiv,NumpadAdd,NumpadSub
		,NumpadDel,NumpadIns,NumpadClear,NumpadUp,NumpadDown,NumpadLeft,NumpadRight,NumpadHome,NumpadEnd,NumpadPgUp,NumpadPgDn
		,Browser_Back,Browser_Forward,Browser_Refresh,Browser_Stop,Browser_Search,Browser_Favorites,Browser_Home
		,Volume_Mute,Volume_Down,Volume_Up
		,Media_Next,Media_Prev,Media_Stop,Media_Play_Pause
		,Launch_Mail,Launch_Media,Launch_App1,Launch_App2
		,PrintScreen,CtrlBreak,Pause
		,WheelDown,WheelUp
		,WheelLeft,WheelRight
		,LButton,RButton,MButton,XButton1,XButton2

	if key in %specialKeys%
		return True

	if IsModifierKey(key)
		return True

	return False
}
; }}}
GetModifiedKeySymbol(key) { ; {{{
	if (key == "Ctrl")
		return "^"
	else if (key == "Alt")
		return "!"
	else if (key == "Shift")
		return "+"
	else if (key == "Win")
		return "#"
}
; }}}
Press(keys*) { ; {{{
	; Wrapper function to make a neat interface for sending keys
	; Usage:
	;  Press("Ctrl", "c")
	;  Press("Ctrl", "Shift", "Left")
	;  Press("Win", "F1")
	;  Press("Home")
	keystrokes := ""
	for i, key in keys {
		if IsModifierKey(key) {
			keystrokes := keystrokes . GetModifiedKeySymbol(key)
		}
		else {
			if IsSpecialKey(key)
				keystrokes := keystrokes . "{" . key . "}"
			else
				keystrokes := keystrokes . key
		}
	}
	Send %keystrokes%
}
; }}}
ToggleUnikey() { ; {{{
	Press("Alt", "z")
}
; }}}
InspectWindow() { ; {{{
	; Print info of current focused window
	WinGetTitle, title, A
	WinGetClass, class, A
	WinGetText,  text,  A
	MsgBox,
		(
title: %title%
class: %class%
text: %text%
		)
}
; }}}
WindowBackwardForward() { ; {{{
	Press("Alt", "Tab")
}
; }}}
Copy() { ; {{{
	; Copy something
	Press("Ctrl", "c")
}
; }}}
YankPath() { ; {{{
	; Yank current path address
	; NOTE: this will work only when select "Display full path in title bar
	Clipboard =
	Copy()
	ClipWait
	Clipboard = %Clipboard%
}
; }}}
nvim_exe := "E:\Program Files\Neovim\bin\nvim-qt.exe"
OpenWith(executable) { ; {{{
	exe := "E:\Program Files\Neovim\bin\nvim-qt.exe"
	YankPath()
	; msgBox, nvim_exe %nvim_exe%
	IfExist, %exe%
		run, %exe% `"%Clipboard%`" --maximized
	Return
}
; }}}

^o::OpenWith(nvim_exe)

; Ctrl+Shift+s to Suspend ahk
^+s::Suspend

; Ctrl+Shift+h to display keystroke history
^+h::KeyHistory

F1::run cmd.exe

; Open nvim
F2::run nvim-qt.exe --maximized
; Open vim
RCtrl & F2::run gvim.exe

; Open chrome
F3::run chrome.exe

; Open everything
F4::run Everything.exe

; Do something
$F5::
   if GetKeyState("Capslock")
      send, {F5}
   else
      send, {F5} ; temp
return

; Open visual studio
$F6::
   if GetKeyState("Capslock")
      send, {F6}
   else
      run, devenv.exe
   return

; Unikey Toggle
Capslock & F9::ToggleUnikey()

; Open Firefox
; RCtrl & 1::run firefox.exe

; F12::InspectWindow()

; Open Foxit Reader
RCtrl & 4::run FoxitReader.exe

; Switch between app/desktop (ctrl + d)
Ctrl & /::sendinput {LWin Down}d{LWin Up}


; Mimic my i3wm shortcuts setup on linux
; Winactive [, title]
RCtrl & 1::WinActivate, MINGW
RCtrl & 2::WinActivate, Neovim
RCtrl & 3::WinActivate, Google Chrome
LCtrl & n::WindowBackwardForward()

; Japanese Emoijs
:::angry::(＃`Д´)
:::awesome::°˖✧◝(⁰▿⁰)◜✧˖°
:::cry::(μ_μ)
:::fear::〣( ºΔº )〣
:::dcare::┐(￣ヘ￣)┌
:::confuse::(￣ω￣;)
:::surprise::Σ(O_O)
:::greet::(°▽°)/
:::hug::(づ￣ ³￣)づ
:::apologize::(シ_ _)シ
:::run::ヽ(￣д￣;)ノ=3=3=3
:::sleep::(－ω－) zzZ
:::cat::(=`ω´=)
:::bear::ʕ •̀ ω •́ ʔ
:::highfive::(*＾ω＾)人(＾ω＾*)


#If Winactive("ahk_exe nvim-qt.exe")

settimer, active, 500
return

active:
ifwinActive, ahk_exe nvim-qt.exe
WinMaximize A
Return

return ; #If Winactive("ahk_class Qt5QWindowIcon")


#If Winactive("ahk_class Vim") or Winactive("ahk_exe nvim-qt.exe")

; Ctrl+Shift+r to reload (source) new setting from AutoHoKey.ahk
^+r::reload

return ; #If Winactive("ahk_class Vim")

#If Winactive("ahk_exe ConEmu64.exe") and !Winactive("VIM")

; Go between command in command history
~Capslock & p::send {Up}
~Capslock & n::send {Down}

; Move to word
~Capslock & `;::Sendinput ^{Left}
~Capslock & '::Sendinput ^{Right}

; Go to two ends of a line
~Capslock & ,::Send {Home}
~Capslock & .::Send {End}

; Navigate 1 character left or right
~Capslock & h::Send {Left}
~Capslock & l::Send {Right}

; Delete word
~Capslock & 9::Sendinput {Ctrl Down}{BackSpace}{Ctrl Up}
~Capslock & 0::Sendinput {Ctrl Down}{Right}{BackSpace}{Ctrl Up}

; Delete current line
~Capslock & /::send {Esc}

; Cancel current cummand
~Capslock & [::send {Ctrl Down}c{Ctrl Up}

; Autocomplete
~Capslock & e::send {Tab}

; Paste shit
~Capslock & r::send {Ctrl Down}v{Ctrl Up}

; Yank line content
~Capslock & y::sendinput {Home}{Alt Down} {Alt Up}ek{Shift Down}{End}{Shift Up}{Ctrl Down}c{Ctrl Up}{Esc}

return ; #If Winactive("ahk_exe ConEmu64.exe")

#If Winactive("ahk_exe devenv.exe")

~Capslock & k::send {Up}
~Capslock & j::send {Down}
~Capslock & h::sendinput {Up 4}
~Capslock & l::sendinput {Down 4}
~Capslock & [::send {Esc}

return ; #If Winactive("ahk_exe devenv.exe")

#If Winactive("ahk_class Chrome_WidgetWin_1")

; Mimic ctrl [ to got to normal mode in vim
~Capslock & [::send {Ctrl Down}[{Ctrl Up}

; Change element (F6)
~Capslock & i::send {F6}

; Hard reload
~Capslock & r::send {F5}

; Move in text box
; ~Capslock & l::sendinput {Right}
; ~Capslock & h::sendinput {Left}
~Capslock & j::send {Down}
~Capslock & k::send {Up}
~Capslock & h::send {Left}
~Capslock & l::send {Right}

~Capslock & 9::sendinput {Ctrl Down}{BS}{Ctrl Up}
~Capslock & 0::sendinput {Ctrl Down}{Shift Down}{Right}{Shift Up}{Ctrl Up}{Space}{BS}
; ~Capslock & /::sendinput {End}{Ctrl Down}u{Ctrl Up}

; Completion navigation
Capslock & n::sendinput {Tab}
Capslock & p::sendinput {Shift Down}{Tab}{Shift Up}

; force move between tabs
^h::sendinput {Ctrl Down}{Shift Down}{Tab}{Ctrl Up}{Shift Up}
^l::sendinput {Ctrl Down}{Tab}{Ctrl Up}

; Move between words
Capslock & `;::sendinput {Ctrl Down}{Left}{Ctrl Up}
Capslock & ':: sendinput {Ctrl Down}{Right}{Ctrl Up}

; Move to 2 ends
Capslock & ,::sendinput {Home}
Capslock & .:: sendinput {End}

; Capslock & [::sendinput {Ctrl Down}[{Ctrl Up}

; Close tab
Capslock & x::sendinput {Ctrl Down}w{Ctrl Up}

return ; #If Winactive("ahk_class Chrome_WidgetWin_1")

#If Winactive("ahk_class classFoxitReader")

; Navigate between tab
Capslock & `;::Sendinput {Capslock}{Ctrl down}{Shift down}{Tab}{Ctrl up}{Shift up}{Capslock}
Capslock & ':: Sendinput {Capslock}{Ctrl down}{Tab}{Ctrl up}{Capslock}

; Go up or down (soft)
Capslock & k::Send {Up}
Capslock & j::Send {Down}

; Go up or down (harder)
Capslock & h::Send {PgUp}
Capslock & l::Send {PgDn}

; Zoom
Capslock & =::Sendinput {Ctrl Down}={Ctrl Up}
Capslock & -::Sendinput {Ctrl Down}-{Ctrl Up}

; Go to page
Capslock & g::Send {Capslock}{Ctrl Down}g{Ctrl Up}{Capslock}

; Esc
Capslock & [::Send {Esc}

; Toggle Read Mode
Capslock & r::Sendinput {Capslock}{Ctrl Down}h{Ctrl Up}{Capslock}

; Close current tab
Capslock & x::Sendinput {Capslock}{Ctrl Down}w{Ctrl Up}{Capslock}

; Close all
Capslock & /::Sendinput {Alt Down}{F4}{Alt Up}

; Find | Find Next | Find Previous
/::Sendinput {Ctrl Down}f{Ctrl Up}
; Ctrl Shift n and Ctrl Shift p (Custom key in pdf because F3 will open gvim.exe)
Capslock & n::Sendinput {Alt Down}n{Alt Up}
Capslock & p::Sendinput {Alt Down}p{Alt Up}

return ; #If Winactive("ahk_class classFoxitReader")

#If WinActive("ahk_class EVERYTHING")

Capslock & h::sendinput {Up 4}
Capslock & l::sendinput {Down 4}

return ; #If WinActive("ahk_class EVERYTHING")

; Explorer shortcut
#If !Winactive("ahk_group DONT_TOUCH")

; Delete word
Capslock & 9::Sendinput ^+{Left}{Del}
Capslock & 0::Sendinput ^+{Right}{Del}

; Delete one line
Capslock & BS::Sendinput {Home}+{End}{Del}

; Go to two ends of a line
Capslock & ,::Send {Home}
Capslock & .::Send {End}

; Move to word
Capslock & `;::Sendinput ^{Left}
Capslock & '::Sendinput ^{Right}

; Ctrl + jkhl to navigate through files
Capslock & j::
   if GetKeyState("Shift")
      sendinput {Down 4}
   else
      send {Down}
   return
Capslock & k::
   if GetKeyState("Shift")
      sendinput {Up 4}
   else
      send {Up}
   return
Capslock & h::
   if GetKeyState("Shift")
      sendinput {Left 4}
   else
      send {Left}
   return
Capslock & l::
   if GetKeyState("Shift")
      sendinput {Right 4}
   else
      send {Right}
   return

; Minimize/Maximize window
Capslock & 7::WinMinimize, A
Capslock & 8::WinMaximize, A

; Mimic ctrl [ to got to normal mode in vim
^[::send {Esc}

; Scroll (Space to PgDn by default)
Capslock & Space::send {PgUp}

; Volume Up/Down
Capslock & 5::send {Volume_Down}
Capslock & 6::send {Volume_Up}

; Rename/Refresh
Capslock & r::
   if GetKeyState("Shift")
      send, {F2}
   else
      send, {F5}
   return

; Next element in a tab (Equal to tab)
Capslock & [::send {Tab}
Capslock & ]::sendinput {Shift down}{Tab}{Shift up}

; Use tab instead of ctrl tab to go to next tab
Tab::sendinput {Ctrl down}{Tab}{Ctrl up}

; Use shift tab instead of ctrl shift tab to go to previous tab
+Tab::sendinput {Ctrl down}{Shift down}{Tab}{Ctrl up}{Shift up}

; Change element (F6)
Capslock & i::send {F6}

; Right Click (menu)
Capslock & m::sendinput {Shift down}{F10}{Shift up}

; Extract using 7zip
Capslock & e::sendinput {Shift down}{F10}{Shift up}7eee{Enter}

; New Folder
Capslock & n::sendinput {Ctrl Down}{Shift Down}n{Shift Up}{Ctrl Up}

Capslock & c::
    ; Get full path from open Explorer window
    WinGetText, FullPath, A

    ; Clean up result
    StringReplace, FullPath, FullPath, `r, , all
    FullPath := RegExReplace(FullPath, "^.*`nAddress: ([^`n]+)`n.*$", "$1")

    ; Change working directory
    SetWorkingDir, %FullPath%

    ; An error occurred with the SetWorkingDir directive
    If ErrorLevel
        Return

    ; Display input box for filename
    InputBox, UserInput, New File (example: foo.txt), , , 400, 100

    ; User pressed cancel
    If ErrorLevel
        Return

    ; Create file
    FileAppend, , %UserInput%

    ; Open the file in the appropriate editor
    Run %UserInput%

    Return

; Up to parent directory
capslock & u::sendinput {Alt down}{Up}{Alt up}

; Close window
Capslock & /::sendinput {Alt down}{F4}{Alt up}

; Yank selected file/folder
Capslock & y::sendinput {Ctrl down}c{Ctrl up}

^+y::YankPath()

; Paste
^p::send {Ctrl down}v{Ctrl up}

; Delete
^d::send {Del}

; Open cmd in git folder
^\::
   run, Cmder.exe
   winwaitactive, Cmder,,2
return

; Take a screenshot
^]::send {PrintScreen}

; Open EDM album and turn on mini mode
^e::
   run, C:\Users\Near\Desktop\EDM.m3u
   winwaitactive, ,- MusicBee,2
   send, {Numpad5}
return

Capslock & s::run E:\Program Files\AutoHotkey\AU3_Spy.exe

return ; #If !Winactive("ahk_group DONT_TOUCH")
