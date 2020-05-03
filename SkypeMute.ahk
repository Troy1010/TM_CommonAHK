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
		vWinTitle:="ahk_exe Skype.exe"
		ControlFocus,, %vWinTitle%
		ControlSend,, ^m, %vWinTitle%
	}
	return