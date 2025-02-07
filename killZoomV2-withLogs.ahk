#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir(A_ScriptDir)


LogEvent(message) {
    timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
    try {
        FileAppend(timestamp " - " message "`n", A_ScriptDir "\killzoom_log.txt")
    } catch Error as e {
        MsgBox("Error writing to log: " e.Message)
    }
}


; Initialize process monitoring
LogEvent("Script initialization started")

; Global variables
global LastCptHostState := 0
global LastCptHostPID := 0

; Initial process check
ProcExists := ProcessExist("CptHost.exe")
if ProcExists {
    LastCptHostState := 1
    LastCptHostPID := ProcExists
    LogEvent("Initial CptHost.exe found with PID: " LastCptHostPID)
} else {
    LogEvent("CptHost.exe not found at startup")
}

; Process monitoring timer
SetTimer(CheckCptHost, 1000)
LogEvent("Process monitor timer started")

CheckCptHost() {
    global LastCptHostState, LastCptHostPID
    CurrentState := ProcessExist("CptHost.exe")
    
    if CurrentState {
        if (!LastCptHostState) {
            LogEvent("CptHost.exe started with PID: " CurrentState)
        }
    } else if LastCptHostState {
        LogEvent("CptHost.exe terminated")
        Run('cmd.exe /c taskkill /F /IM zoom.exe',, "Hide")
    }
    LastCptHostState := CurrentState
}


; Alt + F4 hotkey
!F4::{
    if WinActive("ahk_exe Zoom.exe") {
        if WinExist("Zoom Meeting") {
            return
        } else {
            Run('cmd.exe /c taskkill /F /IM zoom.exe',, "Hide")
        }
    } else {
        Send("!{F4}")
    }
}

; Alt + Ctrl + F4 hotkey
!^F4::{
    if WinActive("ahk_exe Zoom.exe") {
        Run('cmd.exe /c taskkill /F /IM zoom.exe',, "Hide")
    } else {
        Send("!^{F4}")
    }
}
