
#include <TM_CommonAHK>


;  Keyset
MButton::WinTab()
XButton1::F18
XButton2::F10
CapsLock::F9
LWin::
	return
$Q::
	Send {Q down}
	Sleep 100
	Send {Q up}
	KeyWait, Q
	return