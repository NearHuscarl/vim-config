#Persistent
#InstallKeybdHook
#InstallMouseHook
#KeyHistory 100

; Turn off caplock key function
SetCapsLockState, AlwaysOff
return

; Make Caplock acts as alt
Capslock::Alt
return

; Make useless PageUp become capslock (capslock shft l below will cover that)
RAlt::Capslock
return