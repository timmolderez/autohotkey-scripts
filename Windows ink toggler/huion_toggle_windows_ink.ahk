;
; AutoHotkey script to enable/disable Windows Ink -- for Huion pen tablets/displays
;

SetKeyDelay, 10 ; Wait a couple ms between each key press, for consistent results
SetMouseDelay, 10 ; Wait a couple ms between each click
CoordMode, Mouse, Relative ; All given mouse coordinates are relative to the active window

Hotkey, #+I , ToggleWindowsInk ; Win+Shift+I

ToggleWindowsInk()
{
  Send, ^!h ; Ctrl+Alt+H opens the Huion application
  Click, 261 41 ; "Digital pen" button
  Click, 81 103 ; "Press key" button
  Click, 67 737 ; "Enable Windows Ink" checkbox
  Send, !{f4} ; Close the Hiuon application
}