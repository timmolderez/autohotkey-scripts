/**
 * Universal autoscroll - alternative
 * (uses the Click command instead of PostMessage to scroll)
 *
 * AutoHotkey script that lets you scroll (vertically) 
 * by holding the middle mouse-button. The vector from the initial cursor location
 * (when you started holding the button) to your current location determines 
 * the scrolling speed and direction.
 *
 * @author	Tim Molderez
 */
 
 deadzone:=30								; Deadzone in pixels before you start scrolling
 pollRate:=80								; Polling rate in milliseconds; i.e. lower means faster scrolling
 multiplierDistance:=60						; Scroll speed gets a +1 multiplier after this many pixels
 markerColor:="ff7201"						; HTML color code of the marker indicating your initial position
 CoordMode,Mouse,Screen						; Mouse coordinates are relative to the entire screen
 
~MButton::
	; Determine the initial mouse position and the control/window it's pointing at
	MouseGetPos,initX,initY,initWin,initControl,3
	If (initControl) {
		target := "ahk_id " . initControl
    } Else {
		target := "ahk_id " . initWin
	}
	
	; Initialize variables for the autoscroll marker
	markerX:=initX-2
	markerY:=initY-2
	markerDrawn:=false
	
	; Autoscroll while the middle mouse button is held
	While (GetKeyState("MButton")) {
		MouseGetPos,curX,curY
		
		; Do vertical scrolling
		yDiff:=curY-initY
		direction:=-1
		If(yDiff<0) {
			direction:=1
			yDiff:=yDiff*-1
		}
		multiplier:=((yDiff-deadzone)//multiplierDistance)+1
		If(yDiff>deadzone) {
			; PostMessage, 0x20A, (direction*multiplier*120)<<16, (initY+4<<16)|initX+4,,%target%
			If(direction=1) {
				Loop, %multiplier% {
					Click WheelUp
				}
			} Else {
				Loop, %multiplier% {
					Click WheelDown
				}
			}
		}
		
		; Draw marker, if needed
		If(!markerDrawn && (xDiff>deadzone||yDiff>deadzone)) {
			SplashImage,,BH5W5X%markerX%Y%markerY%CW%markerColor%
			markerDrawn:=true
		}
		
		Sleep,%pollRate%
	}
	SplashImage,Off
Return