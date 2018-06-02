#include <TM_CommonAHK>
;-------Declaring Globals
bModifierActive := false
iXB1Count := 0
fTimer := 0
;-------Constant Loop
Loop
{
	if (bModifierActive = true)
	{
		if (iXB1Count > 0)
		{
			fTimer := fTimer - 10
			if (fTimer < 0)
			{
				if (iXB1Count = 1)
				{
					Run, "C:\TMinus1010\Projects\Coding"
				}
				else if (iXB1Count = 2)
				{
					WinClose, A		;A:ActiveWindow
				}
				else
				{
					Msgbox, No command at that iXB1Count
				}
				iXB1Count := 0
				bModifierActive := false
			}
		}
	}
	sleep 10
}
return
;-------Keyset
MButton::WinTab()
XButton2::bModifierActive := !bModifierActive

#if (bModifierActive = true)
LButton::bModifierActive := false, SnapWindowBotLeft()
RButton::bModifierActive := false, SnapWindowRight()
XButton1::iXB1Count := iXB1Count + 1, fTimer := 250