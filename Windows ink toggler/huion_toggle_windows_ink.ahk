;
; AutoHotkey script to enable/disable Windows Ink -- for Huion pen tablets/displays
;

SetWorkingDir %A_ScriptDir% ; Use this script's location as working directory
SetKeyDelay, 15 ; Wait a couple ms between each key press, for consistent results
SetMouseDelay, 15 ; Wait a couple ms between each click
CoordMode, Mouse, Relative ; All given mouse coordinates are relative to the active window

Menu, Tray, Icon, ink_toggler.ico
Hotkey, #+I , ToggleWindowsInk ; Win+Shift+I

ToggleWindowsInk()
{
  BlockInput, On
  Send, ^!h ; Ctrl+Alt+H opens the Huion application
  WinWaitActive, Huion Tablet,,1
  Click, 261 41 ; "Digital pen" button
  Click, 81 103 ; "Press key" button
  Click, 67 737 ; "Enable Windows Ink" checkbox
  Send, !{f4} ; Close the Hiuon application
  BlockInput, Off
}