;-------KeySet
^Escape::ExitApp
#if WinExist("Skype")
XButton1::
XButton1 Up:: ;If you want to change the push-to-talk keybind, replace ` (here and above) with whatever you like. I personally use XButton1.
	if WinActive("ahk_exe Skype.exe")
	{
		SendInput, ^m
	}
	Else
	{
		if !WinExist("ahk_exe Discord.exe") {
			WinGetTitle, vOldWinTitle
			vSkypeWinTitle:="ahk_exe Skype.exe"
			WinActivate, %vSkypeWinTitle%
			sleep 50
			SendInput, ^m
			WinActivate, %vOldWinTitle%
		}
	}
	return