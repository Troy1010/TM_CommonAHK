;-------Settings
bDebug := false
Process, Priority, , H
;-------Globals
iXB2Count := 0
bEasyResetMode := false
eScrollFast := 0
iScrollCount := 0
;-------Loop
Loop
{
	if (iScrollCount > 0) {
		if (GetKeyState("WheelUp","P") != 0) ;is this necessary with SendInput?
		{
			if (iScrollCount > 30) {
				iScrollCount -= 3
				SendInput {Click WheelUp 3}
			}
			else {
				iScrollCount -= 1
				SendInput {Click WheelUp}
			}
		}
	}
	else if (iScrollCount < 0) {
		if (GetKeyState("WheelDown","P") != 0)
		{
			if (iScrollCount < -30) {
				iScrollCount += 3
				SendInput {Click WheelDown 3}
			}
			else {
				iScrollCount += 1
				SendInput {Click WheelDown}
			}
		}
	}
	sleep 2
}
;-------End Init
return
;-------Safety Exit
^Escape::ExitApp
;-------Imports
#include <TM_CommonAHK>
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
	global eScrollFast
	global iScrollCount
	bEasyResetMode := false
	iXB2Count := 0
	eScrollFast := 0
	iScrollCount := 0
	SetTimer, WaiterScroll_XB1Context, off
	SetTimer, WaiterXB2, off
}
IsDefaultContext() {
	return !WinActive("Heroes of the Storm") and !WinActive("Vermintide 2")
}
WaiterScroll_XB1Context:
	eScrollFast := 0
	SetTimer, WaiterScroll_XB1Context, off
	return
WaiterXB2:
	ResetGlobals()
	SoundPlay, C:\TMinus1010\Media\Sounds\26777__junggle__btn402.wav
	SetTimer, WaiterXB2, off
	return
;-------Keyset
#if IsDefaultContext()
MButton::WinTab()
XButton1::F18
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
#if IsDefaultContext() and (iXB2Count == 1)
LButton::ResetGlobals(),SnapWindowLeft()
RButton::ResetGlobals(),SnapWindowRight()
XButton1::
	Run, "C:\TMinus1010"
	sleep 200
	SnapWindowBotLeft()
	ResetGlobals()
	return
WheelUp::
	EasyResetMode()
	if (eScrollFast < 3) {		;here, SendInput {Click WheelUp} is not reliable
		eScrollFast += 1
		iScrollCount += 2
		if (eScrollFast == 3) {
			iScrollCount += 26
		}
	}
	else {
		iScrollCount += 15
	}
	SetTimer, WaiterScroll_XB1Context, 500
	return
WheelDown::
	EasyResetMode()
	if (eScrollFast < 3) {
		eScrollFast += 1
		iScrollCount -= 2
		if (eScrollFast == 3) {
			iScrollCount -= 26
		}
	}
	else {
		iScrollCount -= 15
	}
	SetTimer, WaiterScroll_XB1Context, 500
	return
#if IsDefaultContext() and (iXB2Count == 2)
LButton::ResetGlobals(),SnapWindowBotLeft()
RButton::ResetGlobals(),SnapWindowFullscreen()
XButton1::
	Run, "C:\TMinus1010_Local\Coding"
	sleep 200
	SnapWindowBotLeft()
	ResetGlobals()
	return
WheelUp::EasyResetMode(),MinimizeMouseoverWindow()
WheelDown::EasyResetMode(),CloseMouseoverWindow()
#if IsDefaultContext() and (iXB2Count == 3)
XButton1::
	OpenCmdAtActiveWindow()
	sleep 100
	SnapWindowUpLeft()
	ResetGlobals()
	return
LButton::ResetGlobals(),SnapWindowUpLeft()
#if IsDefaultContext() and (iXB2Count == 4)
RButton::EasyResetMode(),CloseChromeWindow()
XButton1::ResetGlobals(),ControlSend2(,"{space}","ahk_exe Google Play Music Desktop Player.exe")
#if WinActive("Heroes of the Storm")
#Include HotS.ahk
#if WinActive("Vermintide 2")
#Include Vermintide.ahk
#if (bDebug = true)
F1::
	MsgBox2(NarrateActiveWindow(),true)
	return
F2::
	MsgBox2(IsDefaultContext())
	return
F3::
	MsgBox2(A_WorkingDir)
	return
F4::
	ControlSend2(,"b","ahk_exe Discord.exe")
	return
F5::
    SetTitleMatchMode, 2
    ControlSend, ahk_exe Discord.exe, yo{enter}
F6::
	MsgBox2(NarrateActiveWindow(),true)
	