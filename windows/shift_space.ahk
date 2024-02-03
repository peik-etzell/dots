#Requires AutoHotkey v2.0

; Tick when Space was pressed down
; Zero if Space not pressed
DownTick := 0

$Space::
	{
		global DownTick ; Use DownTick in local scope
		if (DownTick == 0)
		{
			Send "{Shift down}"
		}

		; Don't override if already pressed
		DownTick := DownTick > 0 ? DownTick : A_TickCount
		return
	}

$+Space up::
	{
		global DownTick
		Send "{Shift up}"
		; If space tapped without other keys pressed simultaneously
		if (A_TickCount - DownTick < 200 and A_PriorKey = "Space")
		{
			Send "{Space}"
		}
		; Reset
		DownTick := 0
		return
	}