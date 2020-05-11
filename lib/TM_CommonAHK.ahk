;-------Init
;*Child scripts should use this callback
init_TM_CommonAHK() {
	global enum_ScreenSection := Object("Left", 0, "Right", 1, "BotLeft", 2, "BotRight", 3, "TopRight", 4, "TopLeft", 5, "Fullscreen", 6, "BigRight", 7)
    FileDelete, %A_WorkingDir%\TMLog.txt
	FormatTime, tempTime,, hh:mm:ss tt
    Log("#TMLog " tempTime)
}
;-------Dependencies
#include <CopyPasta>
;-------Private Methods
__GetActiveWinPos() {
    WinGetPos, xPos, yPos, , , A	;A:ActiveWindow
    Tooltip, xPos:%xPos% yPos:%yPos%
}
;-------Labels
__WaiterTooltip:
    Tooltip
    return
;-------Public
;1000ms to 1sec
;Timestamp just needs to be an empty variable stored outside this lib
;..would be better if this could be obj oriented
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

WaitUntilWinTextActive(sText, vIgnorablePID:=0, vTimeoutDuration=3000) {
    fTimestamp := A_TickCount
    WinGetText, tempText, A
    WinGet, tempPID, PID, A
	While (((A_TickCount - fTimestamp)<vTimeoutDuration) and (!InStr(tempText, sText) or (vIgnorablePID and (vIgnorablePID == tempPID))) ) {
		sleep, 1
		WinGetText, tempText, A
        WinGet, tempPID, PID, A
	}
}

CloseMouseoverWindow() {
    MouseGetPos,,, vMouseoverWin
    if (!IsDesktop("ahk_id "+vMouseoverWin))
    {
        WinClose, ahk_id %vMouseoverWin%
    }
}

MinimizeMouseoverWindow() {
    MouseGetPos,,, vMouseoverWin
    if (!IsDesktop("ahk_id "+vMouseoverWin))
    {
        WinMinimize, ahk_id %vMouseoverWin%
    }
}

CloseActiveWindow() {
    WinClose, A
}

SnapAWinToSection(eSection) {
    ;Unsnap
    ;For some reason, if window is snapped to fullscreen, it will not unsnap by WinMove
    WinGetPos, xPos, yPos,,, A
    if ((xPos = -8) and (yPos = -8)) {
        Send #{Down}
    }
    ;
    WinMove,A,,100,100
    ; Snap AWin to section
    enum_ScreenSection := Object("Left", 0, "Right", 1, "BotLeft", 2, "BotRight", 3, "TopRight", 4, "TopLeft", 5, "Fullscreen", 6, "BigRight", 7)
    switch eSection {
        case enum_ScreenSection.Left:
            Send {LWin Down}
            Send {Left}
            Send {LWin Up}
        case enum_ScreenSection.Right:
            Send {LWin Down}
            Send {Right}
            Send {LWin Up}
        case enum_ScreenSection.BotLeft:
            Send {LWin Down}
            Send {Left}
            Send {Down}
            Send {LWin Up}
        case enum_ScreenSection.BotRight:
            Send {LWin Down}
            Send {Right}
            Send {Down}
            Send {LWin Up}
        case enum_ScreenSection.TopLeft:
            Send {LWin Down}
            Send {Left}
            Send {Up}
            Send {LWin Up}
        case enum_ScreenSection.TopRight:
            Send {LWin Down}
            Send {Right}
            Send {Up}
            Send {LWin Up}
        case enum_ScreenSection.Fullscreen:
            Send {LWin Down}
            Send {Up}
            Send {Up}
            Send {Up}
            Send {LWin Up}
        case enum_ScreenSection.BigRight:
            Send {LWin Down}
            Send {Right}
            Send {LWin Up}
            MoveAWinToSection(enum_ScreenSection.BigRight)
    }
    return
}

Log(s) {
	FileAppend, `n%s%, %A_WorkingDir%\TMLog.txt
    return
}

MoveAWinToSection(eSection) {
    posXLeft := -7
    posXMid := 953
    posYTop := 0
    posYMid := 525
    WidthHalfway := 974
    WidthFullway := 1926
    HeightHalfway := 532
    HeightFullway := 1056
    posXBigRight := 466
    WidthBigRight := 1461
    ;For some reason, if window is snapped to fullscreen, it will not automatically unsnap
    WinGetPos,posX,posY,,,A
    if ((posX = -8) and (posY = -8)) {
        Send #{Down}
    }
    ; Move AWin to section
    enum_ScreenSection := Object("Left", 0, "Right", 1, "BotLeft", 2, "BotRight", 3, "TopRight", 4, "TopLeft", 5, "Fullscreen", 6, "BigRight", 7)
    switch eSection {
        case enum_ScreenSection.Left:
            WinMove,A,,posXLeft,posYTop,WidthHalfway,HeightFullway
        case enum_ScreenSection.Right:
            WinMove,A,,posXMid,posYTop,WidthHalfway,HeightFullway
        case enum_ScreenSection.BotLeft:
            WinMove,A,,posXLeft,posYMid,WidthHalfway,HeightHalfway
        case enum_ScreenSection.BotRight:
            WinMove,A,,posXMid,posYMid,WidthHalfway,HeightHalfway
        case enum_ScreenSection.TopLeft:
            WinMove,A,,posXLeft,posYTop,WidthHalfway,HeightHalfway
        case enum_ScreenSection.TopRight:
            WinMove,A,,posXMid,posYTop,WidthHalfway,HeightHalfway
        case enum_ScreenSection.Fullscreen:
            WinMove,A,,posXLeft,posYTop,WidthFullway,HeightFullway
        case enum_ScreenSection.BigRight:
            WinMove,A,,posXBigRight,posYTop,WidthBigRight,HeightFullway
    }
    return
}

ResizeWindowLeft(multiplier) {
    BlockInput MouseMove
    WinGetPos,X,Y,W,H,A
    fXAdjustment := W*multiplier
    WinMove A,,(X-fXAdjustment),Y,(W+fXAdjustment),H
    BlockInput MouseMoveOff
}

ResizeWindowRight(multiplier) {
    BlockInput MouseMove
    WinGetPos,X,Y,W,H,A
    WinMove A,,X,Y,W*multiplier,H
    BlockInput MouseMoveOff
    return
}

WinTab() {
    Send {LWin Down}
    Send {Tab}
    Send {LWin Up}
    return
}

IsDesktop(vWinTitle) {
    WinGet, sProcessName, ProcessName, %vWinTitle%
    StringUpper, sProcessName, sProcessName
    WinGetTitle, sTitle, %vWinTitle%
    return "EXPLORER.EXE" == sProcessName and sTitle == ""
}

;Buggy if using multiple desktops
NarrateActiveWindow() {
    return NarrateWindow("A")
}

;Example: NarrateWindow("ahk_id "+vMouseoverWin)
;Concatenation operator is .
NarrateWindow(vWinTitle) {
    sReturning := ""
    WinGet, sProcessName, ProcessName, %vWinTitle%
    sReturning .= "ProcessName:" sProcessName
    WinGet, vID, ID, %vWinTitle%
    sReturning .= "`nID:" vID
    WinGet, cControlList, ControlList, %vWinTitle%
    sReturning .= "`nControlList:" Narrate(cControlList)
    WinGetTitle, sTitle, %vWinTitle%
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
;example: MsgBox2( x "," y "," w "," h)
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