/**
 * Window groups
 *
 * AutoHotkey script that allows you to create and restore window groups:
 * For example, press Win + Shift + Num0 to store the windows that are 
 * currently opened, together with their positions.
 * If you then press Win + Num0 later on, the script will open these windows 
 *	again and restore their positions. Any other windows will be minimized.
 *
 * @author	Tim Molderez
 */
 
 
/**
	Script initialisation
*/
; No delay after each window activation
SetWinDelay, 0					

; Register hotkeys
#!Numpad0::GoSub, SAVEGROUP
#!Numpad1::GoSub, SAVEGROUP
#!Numpad2::GoSub, SAVEGROUP
#!Numpad3::GoSub, SAVEGROUP
#!Numpad4::GoSub, SAVEGROUP
#!Numpad5::GoSub, SAVEGROUP
#!Numpad6::GoSub, SAVEGROUP
#!Numpad7::GoSub, SAVEGROUP
#!Numpad8::GoSub, SAVEGROUP
#!Numpad9::GoSub, SAVEGROUP
#Numpad0::GoSub, LOADGROUP
#Numpad1::GoSub, LOADGROUP
#Numpad2::GoSub, LOADGROUP
#Numpad3::GoSub, LOADGROUP
#Numpad4::GoSub, LOADGROUP
#Numpad5::GoSub, LOADGROUP
#Numpad6::GoSub, LOADGROUP
#Numpad7::GoSub, LOADGROUP
#Numpad8::GoSub, LOADGROUP
#Numpad9::GoSub, LOADGROUP
#!s::GoSub, SHOWGROUPS

/**
	Saves a window group
	
	All windows that are currently non-minimized are part of this group.
	Their position and size is saved as well.
*/
SAVEGROUP:
	StringRight,groupNo,A_ThisHotkey,1							; Get group number from the hotkey that was pressed
	windowGroup%groupNo%:={}

	WinGet,allWindows,List,,,Program Manager					; Iterate over of all open windows
	Loop,%allWindows% {
		StringTrimRight,curWindow,allWindows%A_Index%,0
		
		WinGet,curWindowStyle,Style,ahk_id %curWindow%			; Skip windows without a minimize button
		If !(curWindowStyle & 0x20000)
			Continue
		WinGet,curWindowState,MinMax,ahk_id %curWindow%,		; Skip minimized windows
		If (curWindowState=-1)
			Continue
		WinGetClass,curWindowClass,ahk_id %curWindow%			; Skip system tray windows
		If (curWindowClass=Shell_TrayWnd)
			Continue
		
		WinGetPos,winX,winY,winW,winH,ahk_id %curWindow%		; Store window position
		winPos:={"x":winX,"y":winY,"width":winW,"height":winH}
		windowGroup%groupNo%[curWindow]:=winPos
	}
	SplashImage,,B,Saved to window group %groupNo%				; Show on-screen-display notification
	Sleep,1500
	SplashImage,Off
Return

/**
	Loads a window group
	
	All windows not part of the group are minimized.
	Windows that are part of the group are restored, including their position and size.
*/
LOADGROUP:
	StringRight,groupNo,A_ThisHotkey,1							; Get group number from the hotkey that was pressed
	WinGet,allWindows,List,,,Program Manager					; Loop over of all open windows
	Loop,%allWindows% {
		StringTrimRight,curWindow,allWindows%A_Index%,0
		
		WinGet,curWindowStyle,Style,ahk_id %curWindow%			; Skip windows without a minimize button
		If !(curWindowStyle & 0x20000)
			Continue
		WinGetClass,curWindowClass,ahk_id %curWindow%			; Skip system tray windows
		If (curWindowClass=Shell_TrayWnd)
			Continue
			
		If (windowGroup%groupNo%.HasKey(curWindow)) {			; If the window is part of the group, restore it and its position
			WinActivate, ahk_id %curWindow%
			winPos:=windowGroup%groupNo%[curWindow]
			WinMove,ahk_id %curWindow%,,winPos["x"],winPos["y"],winPos["width"],winPos["height"]
		} Else {												; If not, minimize it
			WinMinimize, ahk_id %curWindow%
		}
	}
Return

/**
	Shows a window with the contents of all window groups
*/
SHOWGROUPS:
	Gui, Add, TreeView, r16 w400
	i:=0
	While (i<10) {												; Iterate over all groups
		parent := TV_Add("Group " . i,0, "Bold Expand")
		isEmpty:=true
		For key, value in windowGroup%i% {						; Iterate over each window in a group
			IfWinExist,ahk_id %key%
			{
				WinGetTitle,curWindowTitle,ahk_id %key%
				TV_Add(curWindowTitle, parent)
				isEmpty:=false
			}
		}
		If(isEmpty) {
			TV_Delete(parent)
		}
		i:=i+1
	}

	Gui, Show,,Window groups
Return

GuiEscape:
Gui, Destroy

GuiClose:
Gui, Destroy