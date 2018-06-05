;-------Pretend Private
__UnsnapIfNecessary() {
	bUnsnap = false
	WinGetPos, xPos, yPos, , , A	;A:ActiveWindow
	;!These checks will fail on a different screen resolution
	if ((xPos = -7) and (yPos = 525)) or ((xPos = -7) and (yPos = 0)) or ((xPos = -8) and (yPos = -8)) or ((xPos = 953) and (yPos = 0)) or ((xPos = 953) and (yPos = 525)) or (!xPos and !yPos)
	{
		Send {LWin Down}
		Send {Up}
		Send {Up}
		Send {Up}
		Send {LWin Up}
	}
}
__GetActiveWinPos() {
	WinGetPos, xPos, yPos, , , A	;A:ActiveWindow
	Tooltip, xPos:%xPos% yPos:%yPos%
}
return
__WaiterTooltip:
	Tooltip
	return
;-------Public

CloseMouseoverWindow() {
	sText := "asdf"
	MouseGetPos,,, vMouseoverWin
	if (vMouseoverWin == 0x1012e) ;Desktop
	{
		return
	}
	WinClose, ahk_id %vMouseoverWin%
}

CloseActiveWindow() {
	WinClose, A
	return
}

SnapWindowBotLeft() {
	__UnsnapIfNecessary()
	Send {LWin Down}
	Send {Left}
	Send {Down}
	Send {LWin Up}
	return
}

SnapWindowLeft() {
	__UnsnapIfNecessary()
	Send {LWin Down}
	Send {Left}
	Send {LWin Up}
	return
}

SnapWindowUpLeft() {
	__UnsnapIfNecessary()
	Send {LWin Down}
	Send {Left}
	Send {Up}
	Send {LWin Up}
	return
}

SnapWindowRight() {
	__UnsnapIfNecessary()
	Send {LWin Down}
	Send {Right}
	Send {LWin Up}
	return
}

SnapWindowFullscreen() {
	__UnsnapIfNecessary()
	Send {LWin Down}
	Send {Up}
	Send {Up}
	Send {Up}
	Send {LWin Up}
	return
}

WinTab() {
	Send {LWin Down}
	Send {Tab}
	Send {LWin Up}
	return
}

BeepIf(bBool) {
	if (bBool)
	{
		SoundPlay, *-1
	}
	return
}

Tooltip2(s,iTimer=2500) {
	Tooltip, %s%
	SetTimer, __WaiterTooltip, %iTimer%
}

;Convenience function to make it obvious that it is taking an expression
MsgBox2(s,bBool=True) {
	if (bBool)
	{
		MsgBox % s
	}
}

GetActiveWinDir() {
	WinGetText, sText, A
	RegExMatch(sText,"Address: \K\V+",sDir)
	if (!IsDir(sDir))
		sDir = 
	return sDir
}

IsDir(s) {
	return InStr( FileExist(s), "D")
}

OpenCmdAtActiveWindow() {
	address := GetActiveWinDir()

	if (address <> "") 
		Run, cmd.exe, %address%
	else 
		Run, cmd.exe, C:\
}
