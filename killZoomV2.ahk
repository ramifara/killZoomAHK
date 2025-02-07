#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir(A_ScriptDir)

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

; Initialize process monitoring
global LastCptHostState := 0
global LastCptHostPID := 0

; Initial process check
ProcExists := ProcessExist("CptHost.exe")
if ProcExists {
    LastCptHostState := 1
    LastCptHostPID := ProcExists
}

; Process monitoring timer
SetTimer(CheckCptHost, 1000)

CheckCptHost() {
    global LastCptHostState, LastCptHostPID
    CurrentState := ProcessExist("CptHost.exe")
    
    if CurrentState {
        if (!LastCptHostState) {
            LastCptHostPID := CurrentState
        }
    } else if LastCptHostState {
        Run('cmd.exe /c taskkill /F /IM zoom.exe',, "Hide")
    }
    LastCptHostState := CurrentState
}