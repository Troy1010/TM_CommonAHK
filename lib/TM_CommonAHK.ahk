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
;-------Public

CloseMouseoverWindow() {
	MouseGetPos,,, vMouseoverWin
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