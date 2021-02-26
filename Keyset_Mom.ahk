;-------Settings
bDebug := false
Process, Priority, , H
;
init_TM_CommonAHK()
;-------Globals
iXB2Count := 0
bEasyResetMode := false
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
	bEasyResetMode := false
	iXB2Count := 0
	SetTimer, WaiterXB2, off
}
IsDefaultContext() {
	return true ;!WinActive("Heroes of the Storm") and !WinActive("Vermintide 2") and !WinActive("Path") and !WinActive("Factorio")
}
OpenFolderAndMoveToSection(path, sectionEnumIndex) {
	Run, Explorer %path%
	WinGet, vIgnorablePID, PID, A
	WaitUntilWinTextActive(path, vIgnorablePID)
	MoveAWinToSection(sectionEnumIndex)
}
;-------Labels
WaiterXB2:
	ResetGlobals()
	SoundPlay, C:\Dropbox\Media\Sounds\26777__junggle__btn402_edited_quiet.wav
	SetTimer, WaiterXB2, off
	return
;-------Keyset
#if IsDefaultContext()
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
#if IsDefaultContext() and (iXB2Count == 1)
; XButton1 Up::
; 	ResetGlobals()
; 	OpenFolderAndMoveToSection("C:\Dropbox", enum_ScreenSection.BotLeft)
; 	return
WheelUp::EasyResetMode(),MinimizeMouseoverWindow()
WheelDown::EasyResetMode(),CloseMouseoverWindow()
#if (bDebug = true)
F1::
	SoundPlay, res\26777__junggle__btn402_edited_quiet.wav
	return
	