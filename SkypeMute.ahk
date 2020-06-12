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
		WinGetTitle, vOldWinTitle, A
		vSkypeWinTitle:="ahk_exe Skype.exe"
		WinActivate, %vSkypeWinTitle%
		sleep 25
		SendInput, ^m
		sleep 25
		; Log("vOldWinTitle:" %vOldWinTitle%)
		WinActivate, %vOldWinTitle%
	}
	return
