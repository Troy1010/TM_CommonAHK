#-------Safety Exit
^Escape::ExitApp
#-------Settings
bDebug := false
#-------Imports
#include <TM_CommonAHK>
;-------Globals
iXB2Count := 0
bEasyResetMode := false
;-------
return
;-------Helper Functions, Labels
ResetGlobals() {
	global bEasyResetMode
	global iXB2Count
	bEasyResetMode := false
	iXB2Count := 0
}
WaiterXB2:
	ResetGlobals()
	SoundPlay, C:\TMinus1010\Media\Sounds\26777__junggle__btn402.wav
	return
;-------Keyset
MButton::WinTab()
XButton2::
	if (bEasyResetMode)
	{
		ResetGlobals()
	}
	else
	{
		iXB2Count += 1
	}
	SetTimer, WaiterXB2, 500
	return
XButton2 Up::
	SetTimer, WaiterXB2, off
	return
XButton1::F18
#if (iXB2Count != 0)
LButton::
	if (iXB2Count == 1)
	{
		SnapWindowLeft()
	}
	else if (iXB2Count == 2)
	{
		SnapWindowBotLeft()
	}
	else if (iXB2Count == 3)
	{
		SnapWindowUpLeft()
	}
	else if (iXB2Count == 4)
	{
		Send {LButton Down}
		return
	}
	ResetGlobals()
	return
LButton Up::
	if (iXB2Count == 4)
	{
		Send {LButton Up}
		return
	}
	ResetGlobals()
	return
RButton::
	if (iXB2Count == 1)
	{
		SnapWindowRight()
	}
	if (iXB2Count == 2)
	{
		SnapWindowFullscreen()
	}
	ResetGlobals()
	return
XButton1::
	if (iXB2Count ==1)
	{
		Run, "C:\TMinus1010"
		sleep 100
		SnapWindowBotLeft()
	}
	else if (iXB2Count ==2)
	{
		Run, "C:\TMinus1010\Projects\Coding"
		sleep 100
		SnapWindowBotLeft()
	}
	else if (iXB2Count ==3)
	{
		OpenCmdAtActiveWindow()
		sleep 100
		SnapWindowUpLeft()
	}
	else if (iXB2Count ==4)
	{
		ControlSend2(,"{space}","ahk_exe Google Play Music Desktop Player.exe")
	}
	ResetGlobals()
	return
WheelUp::
	if (iXB2Count ==1)
	{
		CloseMouseoverWindow()
		bEasyResetMode := true
		return
	}
	ResetGlobals()
	return
WheelDown::
	if (iXB2Count ==1)
	{
		CloseMouseoverWindow()
		bEasyResetMode := true
		return
	}
	else if (iXB2Count ==4)
	{
		Send {ctrl down}w{ctrl up}
		bEasyResetMode := true
		return
	}
	ResetGlobals()
	return
#if (bDebug = true)
F1::
	MsgBox2(NarrateActiveWindow(),true)
	return
F2::
	ControlSend2("Chrome_RenderWidgetHostHWND1","{z down}","ahk_exe Discord.exe")
	return
F3::
	ControlSend2("Intermediate D3D Window1","{z down}","ahk_exe Discord.exe")
	return
F4::
	ControlSend2(,"b","ahk_exe Discord.exe")
	return
F5::
    SetTitleMatchMode, 2
    ControlSend, ahk_exe Discord.exe, yo{enter}