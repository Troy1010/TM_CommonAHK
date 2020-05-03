;-------Settings
bDebug := true
Process, Priority, , H
;
init_TM_CommonAHK()
;-------Globals
iXB2Count := 0
bEasyResetMode := false
fScrollFastTimer := 0
iScrollCount := 0
bScrollingFast := false
fTimestamp := 0
;-------Loop
Loop
{
	if (fScrollFastTimer > 0 and !bScrollingFast) {
		fScrollFastTimer := Max(0,fScrollFastTimer - GetTimePassed(fTimestamp))
	}
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
;-------Helper Functions
CloseChromeWindow() {
	Send {ctrl down}w{ctrl up}
}
EasyResetMode() {
	global bEasyResetMode
	bEasyResetMode := true
}
ResetGlobals() {
	global bEasyResetMode
	global iXB2Count
	global fScrollFastTimer
	global iScrollCount
	global bScrollingFast
	bEasyResetMode := false
	iXB2Count := 0
	fScrollFastTimer := 0
	iScrollCount := 0
	bScrollingFast := false
	SetTimer, WaiterScroll_XB1Context, off
	SetTimer, WaiterXB2, off
}
IsDefaultContext() {
	return !WinActive("Heroes of the Storm") and !WinActive("Vermintide 2") and !WinActive("Path") and !WinActive("Factorio")
}
OpenFolderAndMoveToSection(path, sectionEnumIndex) {
	Run, Explorer %path%
	WinGet, vIgnorablePID, PID, A
	WaitUntilWinTextActive(path, vIgnorablePID)
	MoveAWinToSection(sectionEnumIndex)
}
;-------Labels
WaiterScroll_XB1Context:
	fScrollFastTimer := 0
	bScrollingFast := false
	SetTimer, WaiterScroll_XB1Context, off
	return
WaiterXB2:
	ResetGlobals()
	SoundPlay, C:\TMinus1010\Media\Sounds\26777__junggle__btn402_edited_quiet.wav
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
LButton::ResetGlobals(),MoveAWinToSection(enum_ScreenSection.BotLeft)
RButton::ResetGlobals(),MoveAWinToSection(enum_ScreenSection.BigRight)
XButton1::
	OpenFolderAndMoveToSection("C:\TMinus1010", enum_ScreenSection.BotLeft)
	ResetGlobals()
	return
WheelUp::
	EasyResetMode()
	if (!bScrollingFast) {				
		if (fScrollFastTimer < 525) {	;x = z/r
			fScrollFastTimer += 477		;y = z/((z-1)*r)
		}								;z:scrolls required		2.1scrolls required
		else {							;r:scrolls/sec			4scrolls/s
			iScrollCount += 26
			bScrollingFast := true
		}
	}
	if (bScrollingFast) {
		iScrollCount += 15
	}
	else {
		iScrollCount += 2
	}
	SetTimer, WaiterScroll_XB1Context, 500
	return
WheelDown::
	EasyResetMode()
	if (!bScrollingFast) {
		if (fScrollFastTimer < 525) {
			fScrollFastTimer += 477
		}
		else {
			iScrollCount -= 26
			bScrollingFast := true
		}
	}
	if (bScrollingFast) {
		iScrollCount -= 15
	}
	else {
		iScrollCount -= 2
	}
	SetTimer, WaiterScroll_XB1Context, 500
	return
#if IsDefaultContext() and (iXB2Count == 2)
LButton::
	ResetGlobals()
	if (GetKeyState("XButton2","P") and GetKeyState("XButton1","P")) {
		SetTimer, WaiterXB2, off
		OpenFolderAndMoveToSection("C:\TMinus1010\Projects\Career\Apolis", enum_ScreenSection.BotLeft)
	} else {
		MoveAWinToSection(enum_ScreenSection.Left)
	}
	return
RButton::ResetGlobals(),MoveAWinToSection(enum_ScreenSection.Right)
XButton1 Up::
	ResetGlobals()
	if (!GetKeyState("XButton2","P")) {
		OpenFolderAndMoveToSection("C:\TMinus1010_Local\Coding", enum_ScreenSection.BotLeft)
	} else {
		OpenFolderAndMoveToSection("C:\Users\Troy\AndroidStudioProjects", enum_ScreenSection.BotLeft)
	}
	return
WheelUp::EasyResetMode(),MinimizeMouseoverWindow()
WheelDown::EasyResetMode(),CloseMouseoverWindow()
#if IsDefaultContext() and (iXB2Count == 3)
LButton::ResetGlobals(),MoveAWinToSection(enum_ScreenSection.TopLeft)
RButton::ResetGlobals(),MoveAWinToSection(enum_ScreenSection.Fullscreen)
XButton1 Up::
	ResetGlobals()
	OpenCmdAtActiveWindow()
	WinWaitActive,ahk_exe cmd.exe,,5
	MoveAWinToSection(enum_ScreenSection.TopLeft)
	return
#if IsDefaultContext() and (iXB2Count == 4)
RButton::EasyResetMode(),CloseChromeWindow()
XButton1::ResetGlobals(),ControlSend2(,"{space}","ahk_exe Google Play Music Desktop Player.exe")
#if WinActive("Heroes of the Storm")
#Include HotS.ahk
#if WinActive("Vermintide 2")
#Include Vermintide.ahk
#if WinActive("Path")
#Include PoE.ahk
#if WinActive("Factorio")
#Include Factorio.ahk
#if true
#Include SkypeMute.ahk
#if (bDebug = true)
F1::
	FormatTime, MyTime,, hh:mm:ss tt
	Log(MyTime)
	return
F2::
	MsgBox2(pert)
	return
F3::
	Run, Explorer "C:\Users\Troy\AndroidStudioProjects"
	bFoundIt := false
	While (!bFoundIt) {
		sleep, 1
		WinGetText, vText, A
		bFoundIt := InStr(vText, "C:\Users\Troy\AndroidStudioProjects")
	}
	SoundPlay, C:\TMinus1010\Media\Sounds\26777__junggle__btn402_edited_quiet.wav
	MoveAWinToSection(enum_ScreenSection.BotLeft)
	MsgBox2(vText)
	return
F4::
	SetTitleMatchMode, 2
	Run, Explorer "C:\Users\Troy\AndroidStudioProjects",,,vPID
	; WinWaitActive, ahk_pid vPID,,2
	; sleep 500
	; WinGetText, vText, A
	; bFoundIt := InStr(vText, "C:\Users\Troy\AndroidStudioProjects")
	; MsgBox2(bFoundIt)
	WinWaitActive,,"C:\Users\Troy\AndroidStudioProjects",5
	MsgBox2("z")
	; MoveAWinToSection(enum_ScreenSection.BotLeft)
	return
F5::
	return
F6::
	vWinTitle:="ahk_exe Skype.exe"
    ControlFocus,, %vWinTitle%
    ControlSend,, ^m, %vWinTitle%
	return
F7::
	ControlSend2(,"b","ahk_exe Discord.exe")
	return
F8::
	MsgBox2(NarrateActiveWindow(),true)
	return
	