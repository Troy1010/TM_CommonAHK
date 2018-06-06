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
;Convenience for writing single-line.
CloseChromeWindow() {
	Send {ctrl down}w{ctrl up}
}
;Convenience for writing single-line.
EasyResetMode() {
	global bEasyResetMode
	bEasyResetMode := true
}
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
#if (iXB2Count == 1)
LButton::ResetGlobals(),SnapWindowLeft()
RButton::ResetGlobals(),SnapWindowRight()
XButton1::
	Run, "C:\TMinus1010"
	sleep 100
	SnapWindowBotLeft()
	ResetGlobals()
	return
WheelUp::EasyResetMode(),MinimizeMouseoverWindow()
WheelDown::EasyResetMode(),CloseMouseoverWindow()
#if (iXB2Count == 2)
LButton::ResetGlobals(),SnapWindowBotLeft()
RButton::ResetGlobals(),SnapWindowFullscreen()
XButton1::
	Run, "C:\TMinus1010\Projects\Coding"
	sleep 100
	SnapWindowBotLeft()
	ResetGlobals()
	return
#if (iXB2Count == 3)
XButton1::
	OpenCmdAtActiveWindow()
	sleep 100
	SnapWindowUpLeft()
	ResetGlobals()
	return
LButton::ResetGlobals(),SnapWindowUpLeft()
#if (iXB2Count == 4)
RButton::EasyResetMode(),CloseChromeWindow()
XButton1::ResetGlobals(),ControlSend2(,"{space}","ahk_exe Google Play Music Desktop Player.exe")
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