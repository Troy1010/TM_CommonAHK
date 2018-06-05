#-------Settings
bDebug := false
#-------Imports
#include <TM_CommonAHK>
;-------Globals
iXB2Count := 0
bCloseMode := false
DiscordHWND := 0
;-------
return
;-------Helper Functions, Labels
WaiterXB2:
	iXB2Count := 0
	SoundPlay, C:\TMinus1010\Media\Sounds\26777__junggle__btn402.wav
	return
;-------Keyset
MButton::WinTab()
XButton2::
	if (bCloseMode)
	{
		iXB2Count := 0
		bCloseMode := false
	}
	else
	{
		iXB2Count += 1
	}
	SetTimer, WaiterXB2, 1000
	return
XButton2 Up::
	SetTimer, WaiterXB2, off
	return
XButton1::F18
	;ControlSend,, {b down} , ahk_exe Discord.exe
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
	iXB2Count := 0
	return
RButton::
	if (iXB2Count == 1)
	{
		SnapWindowRight()
	}
	iXB2Count := 0
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
	iXB2Count := 0
	return
WheelUp::iXB2Count := 0, SnapWindowFullscreen()
WheelDown::CloseMouseoverWindow(), bCloseMode := true
#if (bDebug = true)
z::
	WinGet, sTitle, ProcessName, A
	sTempGlobal := sTitle
	MsgBox2(sTitle)
	return
x::
	;sString := "Discord.exe"
	sString := "Discord.exe"
	SetTitleMatchMode, 2
	WinGet, DiscordHWND, ID, ahk_exe Discord.exe
	sString := DiscordHWND
	MsgBox2(sString)
	return
c::
	WinGet, sTitle, ProcessName, A
	return
v::
	Run, cmd.exe, C:\TMinus1010\Projects
	return
b::
	OpenCmdAtActiveWindow()
	return
n::
	WinGetText, sText, A
	if (IsDir(sText))
		Tooltip2(sText)
	else
		Tooltip2("no  "+sText)
	return
m::
	SetTitleMatchMode, 2
	WinGetTitle, sTitle, A
	if (IsDir(sTitle))
		Tooltip2("True  address:"+sTitle)
	else
		Tooltip2("False  address:"+sTitle)
	return
a::
	Tooltip2(IsDir("C:\Tminus1010"))
	return
s::
	Tooltip2(IsDir("C:\Tminus10"))
	return
		