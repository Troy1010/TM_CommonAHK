SnapWindowBotLeft() {
	Send {LWin Down}
	Send {Up}
	Send {Up}
	Send {Up}
	Send {Left}
	Send {Down}
	Send {LWin Up}
	return
}

SnapWindowRight() {
	Send {LWin Down}
	Send {Up}
	Send {Up}
	Send {Up}
	Send {Right}
	Send {LWin Up}
	return
}


WinTab() {
	Send {LWin Down}
	Send {Tab}
	Send {LWin Up}
	return
}