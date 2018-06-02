#include <TM_CommonAHK>
;-------Declaring Globals
bModifierActive := false
iXB1TempCount := 0
iXB1Count := 0
fXB1Timer := 0
iLBCount := 0
fLBTimer := 0
;-------Constant Loop
Loop
{
	if (bModifierActive = true)
	{
		if (iXB1Count > 0)
		{
			fXB1Timer := fXB1Timer - 10
			if (fXB1Timer < 0)
			{
				bModifierActive := false
				iXB1TempCount := iXB1Count	;iXB1TempCount b/c if the command goes on for a while, the next iXB1Count can still be registered.
				iXB1Count := 0
				if (iXB1TempCount = 1)
				{
					Run, "C:\TMinus1010\Projects\Coding"
					sleep 100
					SnapWindowBotLeft()
				}
				else if (iXB1TempCount = 2)
				{
					WinClose, A		;A:ActiveWindow
				}
				else
				{
					Msgbox, No command at iXB1Count:%iXB1Count%
				}
			}
		}
		if (iLBCount > 0)
		{
			fLBTimer := fLBTimer - 10
			if (fLBTimer < 0)
			{
				bModifierActive := false
				iTempLBCount := iLBCount	;iTempLBCount b/c if the command goes on for a while, the next iLBCount can still be registered.
				iLBCount := 0
				if (iTempLBCount = 1)
				{
					SnapWindowBotLeft()
				}
				else if (iTempLBCount = 2)
				{
					SnapWindowLeft()
				}
				else
				{
					Msgbox, No command at iLBCount:%iLBCount%
				}
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
LButton::iLBCount := iLBCount + 1, fLBTimer := 250
RButton::bModifierActive := false, SnapWindowRight()
XButton1::iXB1Count := iXB1Count + 1, fXB1Timer := 250
WheelUp::bModifierActive := false, SnapWindowFullscreen()
WheelDown::CloseMouseoverWindow()