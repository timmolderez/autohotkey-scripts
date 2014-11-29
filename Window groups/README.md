Window groups
=============

Window groups is an AutoHotkey script that lets you assign hotkeys to groups of windows. This can be quite useful if you often need to switch back and forth between different sets of applications. What's neat compared to using (work)spaces, which you may know from either Linux or MacOS X, is that the same window can be used in multiple groups. (For example, you may need access to your browser window in both your group for entertainment-related stuff and the group for work-related stuff.) Additionally, using Window groups is a slightly more light-weight approach: There isn't much of a graphical user interface, you only need to know two hotkeys: one to create a window group, another to activate a window group.

### Usage

Press Win + Alt + a numpad number key to create a window group. (You can use any numpad number key from 0 to 9, so you can create a total of 10 groups.) This window group contains all windows that were visible (i.e. not minimized) when you pressed the hotkey. Note that the size and position of each window is stored as well.
Press Win + a numpad number key to activate the window group with the same number as the numpad key you pressed. This will open all windows in this group and restore their size and positions. All other windows will be minimized.
Press Win + Alt + s to show an overview of all groups and the windows contained within. (You can press Esc to close this window.)

In case you're interested where I got the idea to create Window groups: real-time strategy (RTS) games. In most of these games, you can assign number keys to groups of units that you need quick access to. It's actually kind of surprising how much some games are geared towards productivity :)