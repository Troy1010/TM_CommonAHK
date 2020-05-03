;-------Dependencies
#include <CopyPasta>
;-------Pretend Private
__UnsnapIfNecessary() {
    bUnsnap = false
    WinGetPos, xPos, yPos, , , A	;A:ActiveWindow
    ;!These checks will fail on a different screen resolution
    ;if ((xPos = -7) and (yPos = 525)) or ((xPos = -7) and (yPos = 0)) or ((xPos = -8) and (yPos = -8)) or ((xPos = 953) and (yPos = 0)) or ((xPos = 953) and (yPos = 525)) or (!xPos and !yPos)
    if (true)
    {
        Send {LWin Down}
        Send {Up}
        Send {Up}
        Send {Up}
        Send {Up} ;4th one should be unnecessary
        Send {Down}
        Send {LWin Up}
        sleep, 100 ;This wasn't always necessary
    }
}
__GetActiveWinPos() {
    WinGetPos, xPos, yPos, , , A	;A:ActiveWindow
    Tooltip, xPos:%xPos% yPos:%yPos%
}

;---Label
__WaiterTooltip:
    Tooltip
return
;-------Public

;1000ms to 1sec
GetTimePassed(ByRef fTimestamp) {
    if (fTimestamp == 0) {
        fReturning := 0
    }
    else {
        fReturning := A_TickCount - fTimestamp
    }
    fTimestamp := A_TickCount
return fReturning
}

CloseMouseoverWindow() {
    MouseGetPos,,, vMouseoverWin
    if (vMouseoverWin == 0x1012e) ;Desktop
    {
        return
    }
    WinClose, ahk_id %vMouseoverWin%
}

MinimizeMouseoverWindow() {
    MouseGetPos,,, vMouseoverWin
    if (vMouseoverWin == 0x1012e) ;Desktop
    {
        return
    }
    WinMinimize, ahk_id %vMouseoverWin%
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

ExpandWindowLeft() {
    BlockInput MouseMove
    WinGetPos,X,Y,W,H,A
    fXAdjustment := W*0.5
    W += fXAdjustment
    WinMove A,,X-fXAdjustment,Y,W,H
    BlockInput MouseMoveOff
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

;Concatenation operator is .
;Buggy if using multiple desktops
NarrateActiveWindow() {
sReturning := ""
WinGet, sProcessName, ProcessName, A
sReturning .= "ProcessName:" sProcessName
WinGet, vID, ID, A
sReturning .= "`nID:" vID
WinGet, cControlList, ControlList, A
sReturning .= "`nControlList:" Narrate(cControlList)
WinGetTitle,sTitle,A
sReturning .= "`nTitle:" Narrate(sTitle)
return sReturning
}

Narrate(vVar) {
sReturning := ""
if IsObject(vVar) {
sReturning := "Object.."
for vKey, vValue in vVar {
sReturning .= "`n  " vKey ":" vValue
}
}
else if (InStr(vVar,"`n")) {
sReturning := "MultilineString.."
cCollection := StrSplit(vVar,"`n")
for vKey, vValue in cCollection {
sReturning .= "`n  " vValue
}
}
else {
sReturning := "" . vVar ;Probably unnecessary
}
return sReturning
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

;bCopyable: Set to true if you want to be able to copy from the MsgBox
MsgBox2(s,bCopyable:=false) {
if (!bCopyable)
{
    MsgBox % s
}
else
{
    Gui, Add,Edit,ReadOnly,%s%
    Gui, Show
}
}

GetActiveExplorerWinDir() {
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
    address := GetActiveExplorerWinDir()
    
    if (address <> "") 
        Run, cmd.exe, %address%
    else 
        Run, cmd.exe, C:\
}

ControlSend2(vControl:="",vKeys:="",vWinTitle:="",vWinText:="",vExcludeTitle:="",vExcludeText:="") {
    ControlFocus, %vControl%, %vWinTitle%, %vWinText%, %vExcludeTitle%, %vExcludeText%
    ControlSend, %vControl%, %vKeys%, %vWinTitle%, %vWinText%, %vExcludeTitle%, %vExcludeText%
}