init_TM_CommonAHK()
;-------End Init
return
;-------Safety Exit
^Escape::ExitApp
;-------Includes
#include <TM_CommonAHK>
;-------KeySet
#if WinExist("Skype") and ((!WinExist("ahk_exe Discord.exe")) or IsWinMinimized("ahk_exe Discord.exe"))
XButton1::
XButton1 Up::
	if WinActive("ahk_exe Skype.exe")
	{
		SendInput, ^m
	}
	Else
	{
		if (A_TickCount - timestampSkypeMute > 500) {
			WinGetTitle, vOldWinTitle, A
			vSkypeWinTitle:="ahk_exe Skype.exe"
			WinActivate, %vSkypeWinTitle%
			WinWait, %vSkypeWinTitle%,,1000
			SendInput, ^m
			sleep 10
			; Log("vOldWinTitle:" %vOldWinTitle%)
			WinActivate, %vOldWinTitle%
		}
	}
	return
