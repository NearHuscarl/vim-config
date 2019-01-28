#Persistent
#InstallKeybdHook
#InstallMouseHook
#SingleInstance, force
#KeyHistory 100

; For a quick overview:
; http://xahlee.info/mswin/autohotkey_examples.html

; Turn off caplock key function
SetCapsLockState, AlwaysOff
return

; Make Caplock acts as alt
Capslock::Alt
return

; Make Right alt become capslock
RAlt::Capslock
return

; Global keybindings (Apply to all windows)

; Hotkey: num lock (NumPad)
; Action: Temporarily Disable AutoHotkey script
$Numlock::Suspend

; Hotkey: Ctrl + Shift + R
; Action: Replaces the currently running instance of the script with a new one.
^+R::Reload

; Local keybindings (Specific to window)

; VS Code
#IfWinActive, ahk_class Chrome_WidgetWin_1
{
    ; Hotkey: F4
    ; Action: Copy content from VSCode to SFD script editor then compile it
    $F4::
    ; If Map Editor window exists
    IfWinExist, ahk_class WindowsForms10.Window.8.app.0.141b42a_r34_ad1
    {
        Send {CtrlDown}a{CtrlUp} ; Select all
        Sleep 20 ; Wait 30 ms.
        Send {CtrlDown}c{CtrlUp} ; Copy selected text to clipBoard
        Send {Esc} ; Unselect all text
        Send {AltDown}{Left}{AltDown}{Left} ; Move the cursor to the last position (after unselecting text, it will jump to the end of the file)
        ClipWait ; Wait for clipboard to fill

        WinActivate, Script Editor
        Send {CtrlDown}a{CtrlUp} ; Select all in SFD script editor
        Sleep 20 ; Wait 30 ms.
        Send {CtrlDown}v{CtrlUp} ; Paste clipboard content
        Send {F5} ; Compile newly pasted code
    }
    Else
        MsgBox, "SFD Script Editor is not opened"
    return
}

; SFD Script Editor error message box
#IfWinActive, ahk_class #32770
; Hotkey: F4
; Action: Close the error message and switch back to VSCode
{
    $F4::
    IfWinExist, ahk_class WindowsForms10.Window.8.app.0.141b42a_r34_ad1
    {
        WinClose, ahk_class #32770
        ; Switch back to VSCode (last window)
        Send {AltDown}{Tab}{AltUp}
    }
    return
}