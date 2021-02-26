
#include <TM_CommonAHK>

; Waiters
WaiterClicks:
    if ((GetKeyState("LButton","P") and GetKeyState("CTRL", "P")) == 0)
    {
	    SetTimer, WaiterClicks, off
    }
    Else
    {
        Send ^{LButton}
    }
	return

;  Keyset
~^LButton::
SetTimer, WaiterClicks, 100
return