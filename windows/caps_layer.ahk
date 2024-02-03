#Requires AutoHotkey v2.0
SetCapsLockState "AlwaysOff"

; Map caps+hjkl to arrow keys
#HotIf GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
f::PgDn
b::PgUp
i::Home
o::End
#HotIf

; Send {Esc} if caps pressed and lifted 
; without other hotkey run
*CapsLock::
{
	KeyWait "CapsLock"
	If (A_ThisHotkey = "*CapsLock") {
		Send "{Escape}"
	}
}