## About `killZoomV2.ahk`

This AutoHotkey script is designed to help users fully exit the Zoom Workspace application after leaving a meeting. By default, Zoom keeps its app running in the background even after a meeting ends, which can be disruptive for some users. This script ensures that Zoom is completely terminated, providing a cleaner and more efficient workflow.

### Features:
1. **Alt + F4 Hotkey**:  
   - If Zoom is active and no meeting window is open, the script forcefully terminates Zoom (`taskkill` command).  
   - If a meeting window is detected, it does nothing to avoid accidental termination during a meeting.  
   - For other applications, the Alt + F4 behavior works as expected (closes the active window).  

2. **Alt + Ctrl + F4 Hotkey**:  
   - Always forcefully terminates Zoom if it is active, regardless of whether a meeting is running.  
   - For other applications, it sends the Alt + Ctrl + F4 key combination without interference.  

3. **Process Monitoring**:  
   - The script continuously monitors the Zoom-related process `CptHost.exe`, which is often associated with Zoom's background activity.  
   - If `CptHost.exe` stops running (indicating the end of a meeting), the script automatically terminates Zoom to ensure it doesn't remain active in the background.  

### How It Works:
- The script uses the `taskkill` command to forcefully close Zoom when needed.  
- It leverages AutoHotkey's process and window detection capabilities (`WinActive`, `WinExist`, and `ProcessExist`) to ensure actions are context-sensitive.  
- A timer (`SetTimer`) checks the state of `CptHost.exe` every second to determine if Zoom should be closed automatically.

### Requirements:
- AutoHotkey v2.0 or higher is required to run this script.  

Simply run the script in the background while using Zoom, and it will take care of ensuring that Zoom exits fully when you're done with your meetings.
