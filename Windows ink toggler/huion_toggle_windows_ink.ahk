;
; AutoHotkey script to enable/disable Windows Ink -- for Huion pen tablets/displays
;

SetWorkingDir %A_ScriptDir% ; Use this script's location as working directory
SetKeyDelay, 10 ; Wait a couple ms between each key press, for consistent results
SetMouseDelay, 10 ; Wait a couple ms between each click
CoordMode, Mouse, Relative ; All given mouse coordinates are relative to the active window
SetDefaultMouseSpeed, 0 ; Mouse commands will immediately jump the cursor to the target location

Menu, Tray, Icon, ink_toggler.ico
Hotkey, #+I , ToggleWindowsInk ; Win+Shift+I

ToggleWindowsInk()
{
  HuionWindowTitle := "Huion Tablet"
  BlockInput, On
  Send, ^!h ; Ctrl+Alt+H opens the Huion application
  WinWait, %HuionWindowTitle%,,1
  WinActivate, %HuionWindowTitle%
  Click, 261 41 ; "Digital pen" button
  Click, 81 103 ; "Press key" button
  Click, 67 737 ; "Enable Windows Ink" checkbox
  WinClose, %HuionWindowTitle%
  BlockInput, Off
}