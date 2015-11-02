;===============================================
/*

Quick Access Popup
Written using AutoHotkey_L v1.1.22+ (http://ahkscript.org/)
By Jean Lalonde (JnLlnd on AHKScript.org forum)
	
Based on FoldersPopup from the same author
https://github.com/JnLlnd/FoldersPopup
initialy inspired by Robert Ryan's script DirMenu v2 (rbrtryn on AutoHotkey.com forum)
http://www.autohotkey.com/board/topic/91109-favorite-folders-popup-menu-with-gui/
who was maybe inspired by Savage's script FavoriteFolders
http://www.autohotkey.com/docs/scripts/FavoriteFolders.htm
or Rexx version Folder Menu
http://www.autohotkey.com/board/topic/13392-folder-menu-a-popup-menu-to-quickly-change-your-folders/


BUGS
- sometimes backlink in Settings display an empty menu (intermittent, rare)
- when Clipboard menu had content, clipboard replace with non file/URL content, the Clipboard menu is maintained with its previous content
  but then the menu entry for Clipbopard get broken 1/2 times; note 1: broken only when Current Folders is refreshed too; note 2: menu also broen 1/2 when called from shortcut
  (bug found when working on "Clipboard menu should be preserved if Clipboard does not contain path or url")

TO-DO
- add QAP feature Add this folder Express (see this item in wishlist)
- improve exclusion lists gui in options, help text, class collector, QAP feature "Add window to exclusion list"
- adjust static control occurences showing cursor in WM_MOUSEMOVE
- review help text


HISTORY
=======

Version: 6.1.5 alpha (2015-11-01)
- stop loading not updated translation files until they alre ready, causing error when upgrading from FP
- add Add This Folder QAP feature to My QAP Essentials menu
- fix title in Manage hotkeys dialog box
- add a 20 ms delay after TrayTip to improve display on Windows 10
- add option to TrayTip to stop sound (on Win 10 and maybe before)
- shorten TrayTip texts for better display on Win 10
- shorten executable file description for Win 10
- add a function to return OS version up to WIN_10
- update some menu icons for Windows 10
- update special folders initialization for Windows 10
- adaptation for the new approach implemented setup program using the common AppData folder as repository allowing system admin to setup QAP pour end users
- fix bug locations with system variable (like %APPDATA%) not being expanded before sent to Explorer 

Version: 6.1.4 alpha (2015-10-18)
- add copy favorite button to Settings gui; copied favorite inherit all properties except hotkey
- add Ctrl+C hotkey to Settings gui to copy favorite, update gui hotkeys help text
- in groups, with Directory Opus or Total Commander, set in folders and FTP favorites in which side (left or right) display the favorite
- Ctrl+Right on a group in Settings gui now open the group

Version: 6.1.3 alpha (2015-10-17)
- remove Navigate Dialog from QAP features, now in Power menu
- remove Copy location to clipboard from QAP features, now in Power menu
- fix bug list of QAP features in Add Favorite including Power menu features by error
- fix bug validating window position for items without window position like menus
- fix bug after changing a hotkey twice before saving
- fix bug Power menu Copy Location was launching group
- fix bug Power menu Copy Location was copying inexsting favorite path for groups and QAP features items
- fix bug Power menu Open in new window was launching dummy folder
- improved Option, File managers intro text

Version: 6.1.2 alpha (2015-10-13)
- fix bug with file manager detection at startup
- fix bug in setup program installing QAPconnect.ini in the app folder instead of userapp folder

Version: 6.1.1 alpha (2015-10-12)
- support for custom file managers (in addition to Directory Opus and Total Commander) using the settings file QAPconnect.ini; thanks to Roland Toth (tpr) for his help maintaining these settings (https://github.com/rolandtoth)
- refactoring of custom file managers support (including Directory Opus and Total Commander), with a new user interface in Options to select the custom file manager
- add Edit QAPconnect.ini menu to Tray menu
- when running QAP under Win XP or Vista, show a message inviting user to run Folders Popup and qui QAP
- in Add/Edit Favorite dialog box, reword the checkbox label "Remember window position" to "Use default window position" and revert the checkbox behaviour

Version: 6.0.7 alpha (2015-10-01)
- support relative paths for icon file (but they have to be made relative in the ini file)
- fix bug when checking if a file exitst and location has relative path
- empty group settings when favorite is not a group
- stop making FTP favorite always open in a new window or tab
- QA that relative paths are fully supported in: folders, documents, applications, custom icons (relative path must be edited in ini file) and in advanced settings "launch with" and apps "start in" directory
- add windows identification parameter in FPconnect properties for the active file manager.

Version: 6.0.6 alpha (2015-09-27)
- open group completed but not fuly tested
- add an option in groups to determine if folder will be open with Explorer or the active alternative file manager (Directory Opus, Total Commander or FPconnect), FPconnect not fully supported yet
- making default URL encoding to true for FTP favorites, except for Total Commander always set FTP encoding to false
- fix bug, when folder name from DOpus includes HTML entities like apostrophe replaced by "apos;"
- current folders menu now supports FTP listers in DOpus 

Version: 6.0.5 alpha (2015-09-25)
- create a daily backup of ini file for alpha versions users
- fix bug some special folders not working with TC and DOpus
- fix bug prevent inserting separator/column added before back link in menus
- fix bug when accepting change folder in dialog option with checkbox unchecked
- fix bug when DOpus or TC are not supported and we open menu in DOpus or TC window
- fix bug phantom defaut value in group advanced settings after another group has been edited
- fix bugs when moving multiple favorites to another menu
- fix bug power menu Edit a favorite can now edit a Group favorite

Version: 6.0.4 alpha (2015-09-23)
- disable non folder menu items (except QAP features) when power menu features "Change folder in dialog" and "Open in new window" are selected
- re-enable non folder menu items after power menu features is executed
- add an option to enable Change folder in dialog boxes with main QAP hotkeys and make sure user understands the risk of changing folder in non-file dialog boxes
- fix a bug with special folders when using class IDs in Total Commander

Version: 6.0.3 alpha (2015-09-20)
* New tab in Option to set power menu hotkeys
* Show Power menu hotkeys in Manage hotkeys dialog box
* Implement Power key feature "Edit favorite"
* Add Power menu feature "Copy location"
* Add power menu feature "Change folder in dialog box"
* Disable "Change folder in dialog box" in Power menu if target is not dialog box
* Stop changing folder in dialog with regular popup hotkeys (prevent changing values in a non-file dialog box)
* Enable favorite hotkey for sub-menus
* Implement check for update for alpha versions

Version 6.0.2 alpha (2015-09-15)
- First alpha test release. List of work done since v6.0.1:

Initialisation
--------------
System variables
Special folders
Popup menu hotkeys
Themes

Favorite Types
--------------
Convert favorite types: Folder, Document, Application, Special, URL, and Menu
Add favorite types: FTP, QAP and Group

QAP Features
------------
Implement QAP features as favorite type with features:
About: about dialog box
 - Add This Folder: add the current folder to popup menu
 - Clipboard: list of file paths or URL in clipboard
 - Copy Favorite Location: copy location to clipboard
 - Current Folders: list of folders open in Explorer or supported file managers
 - Exit: quit QAP
 - Help: help dialog box
 - Hotkeys: list of favorite hotkeys and edit dialog box
 - Options: options dialog box
 - Recent Folders: list of Windows recent folders
 - Settings: setting dialog box
 - Support: support freeware dialog box
Use default language for QAP features name
Default hotkey to QAP features

Settings dialog box
-------------------
Build Settings dialog box
Open submenu when double-click in favorite list (use the Edit button to edit the menu item)
Add "back" navigation with ".." item in favorite list
Dialog box to manage favorite hotkeys
Remove one or muptiple favorites, remove submenu and underlying items
Add/Edit groups and manage them similarely to sub menus
Save Settings position when exiting

Favorites dialog box
--------------------
Add/Edit favorites dialog box with tabs: Basic Settings, Menu Options, Window Options and Advanced Settings
Add/Edit QAP features
Favorites hotkeys for all favorite types
Parameters advanced setting for all favorite types (except QAP features, Menus and Groups): 
Launch with application advanced setting for all favorite types (except Application, QAP features, Menus and Groups)
Working directory advanced setting for application favorites
Add an application favorite by selecting its path form a dropdown list of running apps
Edit window position for favorite types Folder, Special folders and Application, with a configurable delay when resizing or moving
Remember current window position when using "Add this folder"
Implementy FTP favorite type with login name, password and an option to encode login name and password in URL
Implement Group favorite with configurable delay when opening group (restoring groupe not done yet)

Options
-------
Convert all FP options
Add two exclusion lists to disable hotkeys in the selected type of window (basic user interface to be improved):
1) One exclusion list for mouse triggers (mouse QAP hotley and mouse Power hotkey)
2) One exclusion list for keyboard triggers (keyboard QAP hotley and keyboard Power hotkey)
Option to display or not the favorite shortcuts reminders in popup menu (full name or abbreviated name)

Menus
-----
Build main menu
Build Current Folders menu
Build Recent Folders menu
Build Tray menu
Add default "My Special folders" menu at first QAP use
Add default "Essential QAP Features" menu at first QAP use
Convert startup tray tip
Test if current target window can navigate folder
Test if current window is on exclusion list before showing popup up
When Current Folders and Clipboard are empty, attach an "empty" sub menu
Add group indicator [[]] to popup menu with nb of items in groups

Popup menu Hotkeys
------------------
New hotkey approach with two triggers:
 1) QAP hotkey (mouse and keyboard), available in all windows, opens the popup menu to choose the favoriteto launch; if the favorite is a folder and the target app supports it (Explorer, dialog box or other file managers), the window is changed (navigate) to this folder
 2) Power hotkey available in all windows, showing a menu of special features before showing the favorites menu (see "Power menu features" below)
Replace default keyboard FP hotkey Windows+A (#A) to Windows+W(#W) because #A is now a reserved shortcut in Windows 10

Actions
-------
Open favorite folders and special folders in current window (navigate) or in a new window (launch) if the target window supports navigation (Explorer, Dialog boxes, Directory Opus, TotalCommander, FPconnect and Console)
Navigate favorite with Clover (using keyboard input)
Run application wit working directory and parameters
Launch documents or URL with "launch with" application and parameters
Support location placeholders in parameters
Implement QAP features "Add this folder" and "Copy Location"
Add this folder remembers window position (for use when open the folder in a new window)
Add this folder supports known special folders (50 known special folders)
Open FTP favorite with login name and password in Explorer, Directory Opus and Total Commander
Resize and move window to remembered position when opening folder in a new window (working with Explorer, DOpus, TC, not working with FPconnect yet)
Resize and move window to remembered position when launching application, document or URL (working with some apps, not all, not fully tested)

Power menu features
-------------------
Open folder in a new window (even if the target window could navigate to this folder)
(more to be implemented)

Third party file managers
-------------------------
Support for Directory Opus
Support for Total Commander
Support for other file managers via FPconnect

Transition
----------
ImportFPsettings.ahk:
 - import favorites from Folders Popup and convert them to QAP format(replace all favorites)
 - import options settings from Folders Popup to QAP (overwrite existing options)

InnoSetup installer
-------------------
Prepare the QAP setup file, including ImportFPsettings.exe


Version: 6.0.1 alpha (2015-05-11)
* Replace "FoldersPopup" with "QuickAccessPopup"
* Update @Ahk2Exe-SetVersion with "6.0.1 alpha"
* Update strCurrentVersion with "6.0.1 alpha"
* Update @Ahk2Exe-SetDescription with "Most handy Windows launcher. Freeware!"
* Distinct variables strAppNameFile for "QuickAccessPopup" and strAppNameText for "Quick Access Popup"
* Update strCurrentBranch with "alpha"
* Adapt for alpha version without version checking for alpha branch
* Replace "FoldersPopup" with "QuickAccessPopup" in InitFileInstall, and language variable names
* Replace "strTempDir" with "g_strTempDir"

SEE PREVIOUS HISTORY on FoldersPopup's GitHub or in FoldersPopup.ahk file


VARIABLES NAMING CONVENTION
---------------------------

typNameOfVariable
^^^^^^^^^^^^^^^^^ description of the variable content, with name sections from general to specific

typeNameOfVariable
^^^^ type of variable, str for strings, int for integers (any size), dbl for reals (not used in this app),
     arr for arrays, obj for objects, menu for menus, etc.
  
g_typNameOfVariable
^ g_ for global, nothing for local

f_typNameOfVariable
^ f_ for form (Gui) variables

*/ 
;========================================================================================================================
!_010_COMPILER_DIRECTIVES:
;========================================================================================================================

; Doc: http://fincs.ahk4.net/Ahk2ExeDirectives.htm
; Note: prefix comma with `

;@Ahk2Exe-SetName Quick Access Popup
;@Ahk2Exe-SetDescription Quick Access Popup (freeware)
;@Ahk2Exe-SetVersion 6.1.5 alpha
;@Ahk2Exe-SetOrigFilename QuickAccessPopup.exe


;========================================================================================================================
!_011_INITIALIZATION:
;========================================================================================================================

#NoEnv
#SingleInstance force
#KeyHistory 0
ListLines, Off
DetectHiddenWindows, On
StringCaseSense, Off
ComObjError(False) ; we will do our own error handling

; avoid error message when shortcut destination is missing
; see http://ahkscript.org/boards/viewtopic.php?f=5&t=4477&p=25239#p25236
DllCall("SetErrorMode", "uint", SEM_FAILCRITICALERRORS := 1)

Gosub, SetQAPWorkingDirectory
; ###_V("AFTER SetQAPWorkingDirectory", A_WorkingDir)

; Force A_WorkingDir to A_ScriptDir if uncomplied (development environment)
;@Ahk2Exe-IgnoreBegin
; Start of code for development environment only - won't be compiled
; see http://fincs.ahk4.net/Ahk2ExeDirectives.htm
SetWorkingDir, %A_ScriptDir%
; ###_V("DEV A_WorkingDir", A_WorkingDir)
ListLines, On
; to test user data directory: SetWorkingDir, %A_AppData%\Quick Access Popup
; / End of code for developement enviuronment only - won't be compiled
;@Ahk2Exe-IgnoreEnd

OnExit, CleanUpBeforeExit ; must be positioned before InitFileInstall to ensure deletion of temporary files

Gosub, InitFileInstall

Gosub, InitLanguageVariables

; --- Global variables

g_strAppNameFile := "QuickAccessPopup"
g_strAppNameText := "Quick Access Popup"
g_strCurrentVersion := "6.1.5" ; "major.minor.bugs" or "major.minor.beta.release"
g_strCurrentBranch := "alpha" ; "prod", "beta" or "alpha", always lowercase for filename
g_strAppVersion := "v" . g_strCurrentVersion . (g_strCurrentBranch <> "prod" ? " " . g_strCurrentBranch : "")

g_blnDiagMode := False
g_strDiagFile := A_WorkingDir . "\" . g_strAppNameFile . "-DIAG.txt"
g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . ".ini"

g_blnMenuReady := false

g_arrSubmenuStack := Object()
g_arrSubmenuStackPosition := Object()

g_objIconsFile := Object()
g_objIconsIndex := Object()

g_strMenuPathSeparator := ">" ; spaces before/after are added only when submenus are added, separate submenu levels, not allowed in menu and group names
g_strGuiMenuSeparator := "----------------" ;  single-line displayed as line separators, allowed in item names
g_strGuiMenuSeparatorShort := "---" ;  short single-line displayed as line separators, allowed in item names
g_strGuiDoubleLine := "===" ;  double-line displayed in column break and end of menu indicators, allowed in item names
g_strGroupIndicatorPrefix := Chr(171) ; group item indicator, not allolowed in any item name
g_strGroupIndicatorSuffix := Chr(187) ; displayed in Settings with g_strGroupIndicatorPrefix, and with number of items in menus, allowed in item names
g_intListW := "" ; Gui width captured by GuiSize and used to adjust columns in fav list
g_strEscapePipe := "С��" ; used to escape pipe in ini file, should not be in item names or location but not checked

g_objGuiControls := Object() ; to build Settings gui

g_strMouseButtons := ""
g_arrMouseButtons := ""
g_arrMouseButtonsText := ""

g_objClassIdOrPathByDefaultName := Object() ; used by InitSpecialFolders and CollectExplorers
g_objSpecialFolders := Object()
g_strSpecialFoldersList := ""

g_objQAPFeatures := Object()
g_objQAPFeaturesCodeByDefaultName := Object()
g_objQAPFeaturesDefaultNameByCode := Object()
g_objQAPFeaturesPowerCodeByOrder := Object()
g_strQAPFeaturesList := ""

g_objHotkeysByLocation := Object() ; Hotkeys by Location

g_strQAPconnectIniPath := A_WorkingDir . "\QAPconnect.ini"
g_strQAPconnectFileManager := ""
g_strQAPconnectAppFilename := ""
g_strQAPconnectCompanionFilename := ""
g_strQAPconnectAppPath := ""
g_strQAPconnectCommandLine := ""
g_strQAPconnectNewTabSwitch := ""
g_strQAPconnectCompanionPath := ""

;---------------------------------
; Initial validation

if InStr("WIN_VISTA|WIN_2003|WIN_XP|WIN_2000", A_OSVersion)
{
	MsgBox, 4, %g_strAppNameFile%, % L(lOopsOSVerrsionError, g_strAppNameFile)
	IfMsgBox, Yes
		Run, http://code.jeanlalonde.ca/folderspopup/
	ExitApp
}

; if the app runs from a zip file, the script directory is created under the system Temp folder
if InStr(A_ScriptDir, A_Temp) ; must be positioned after g_strAppNameFile is created
{
	Oops(lOopsZipFileError, g_strAppNameFile)
	ExitApp
}

;---------------------------------
; Set developement ini file

;@Ahk2Exe-IgnoreBegin
; Start of code for developement environment only - won't be compiled
if (A_ComputerName = "JEAN-PC") ; for my home PC
	g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . "-HOME.ini"
else if InStr(A_ComputerName, "STIC") ; for my work hotkeys
	g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . "-WORK.ini"
; / End of code for developement environment only - won't be compiled
;@Ahk2Exe-IgnoreEnd

;---------------------------------
; Init routines

; Keep gosubs in this order
Gosub, InitSystemArrays
Gosub, InitLanguages
Gosub, InitLanguageArrays
Gosub, InitSpecialFolders
Gosub, InitQAPFeatures
Gosub, InitGuiControls

Gosub, LoadIniFile
; must be after LoadIniFile
IniWrite, %g_strCurrentVersion%, %g_strIniFile%, Global, % "LastVersionUsed" .  (g_strCurrentBranch = "alpha" ? "Alpha" : (g_strCurrentBranch = "beta" ? "Beta" : "Prod"))

if (g_blnDiagMode)
	Gosub, InitDiagMode
if (g_blnUseColors)
	Gosub, LoadThemeGlobal

; build even if not used because they could become used - will be updated at each call to popup menu
Gosub, BuildCurrentFoldersMenuInit 
Gosub, BuildClipboardMenuInit
; no need to build Recent folders menu at startup because this menu is refreshed/recreated on demand

Gosub, BuildMainMenu
Gosub, BuildPowerMenu
Gosub, LoadFavoriteHotkeys
Gosub, BuildGui
Gosub, BuildTrayMenu

if (g_blnCheck4Update)
	Gosub, Check4Update

IfExist, %A_Startup%\%g_strAppNameFile%.lnk ; update the shortcut in case the exe filename changed
{
	FileDelete, %A_Startup%\%g_strAppNameFile%.lnk
	FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%g_strAppNameFile%.lnk, %A_WorkingDir%
	Menu, Tray, Check, %lMenuRunAtStartup%
}

if (g_blnDisplayTrayTip)
{
; 1 NavigateOrLaunchHotkeyMouse, 2 NavigateOrLaunchHotkeyKeyboard, 3 PowerHotkeyMouse, 4 PowerHotkeyKeyboard
	TrayTip, % L(lTrayTipInstalledTitle, g_strAppNameText)
		, % L(lTrayTipInstalledDetail
			, HotkeySections2Text(strModifiers1, strMouseButton1, strOptionsKey1)
			, HotkeySections2Text(strModifiers2, strMouseButton2, strOptionsKey2))
		, , 17 ; 1 info icon + 16 no sound)
	Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
}

g_blnMenuReady := true

/* Enable after debugging
; Load the cursor and start the "hook" to change mouse cursor in Settings - See WM_MOUSEMOVE function below
objCursor := DllCall("LoadCursor", "UInt", NULL, "Int", 32649, "UInt") ; IDC_HAND
OnMessage(0x200, "WM_MOUSEMOVE")
*/

; To prevent double-click on image static controls to copy their path to the clipboard - See WM_LBUTTONDBLCLK function below
; see http://www.autohotkey.com/board/topic/94962-doubleclick-on-gui-pictures-puts-their-path-in-your-clipboard/#entry682595
OnMessage(0x203, "WM_LBUTTONDBLCLK")

; To popup menu when left click on the tray icon - See AHK_NOTIFYICON function below
OnMessage(0x404, "AHK_NOTIFYICON")

; Respond to SendMessage sent by ImportFPsettings to signal that QAP is running
; No specific reason for 0x2224, except that is is > 0x1000 (http://ahkscript.org/docs/commands/OnMessage.htm)
OnMessage(0x2224, "ReplyQAPisRunning")

; Create a mutex to allow Inno Setup to detect if FP is running before uninstall or update
DllCall("CreateMutex", "uint", 0, "int", false, "str", g_strAppNameFile . "Mutex")

; DEBUG
; -----
; Gosub, GuiShow
; Gosub, BuildClipboardMenu
; Menu, g_menuClipboard, Show

return


;------------------------------------------------------------
;------------------------------------------------------------
#If, CanNavigate(A_ThisHotkey)
; empty - act as a handle for the "Hotkey, If" confition
#If
;------------------------------------------------------------
;------------------------------------------------------------


;------------------------------------------------------------
;------------------------------------------------------------
#If, CanLaunch(A_ThisHotkey)
; empty - act as a handle for the "Hotkey, If" confition
#If
;------------------------------------------------------------
;------------------------------------------------------------


;========================================================================================================================
!_012_GUI_HOTKEYS:
;========================================================================================================================

; Gui Hotkeys
#If WinActive(L(lGuiTitle, g_strAppNameText, g_strAppVersion)) ; main Gui title

^Up::
if (LV_GetCount("Selected") > 1)
	Gosub, GuiMoveMultipleFavoritesUp
else
	Gosub, GuiMoveFavoriteUp
return

^Down::
if (LV_GetCount("Selected") > 1)
	Gosub, GuiMoveMultipleFavoritesDown
else
	Gosub, GuiMoveFavoriteDown
return

^Right::
Gosub, HotkeyChangeMenu
return

^Left::
GuiControlGet, blnUpMenuVisible, Visible, f_picUpMenu
if (blnUpMenuVisible)
	Gosub, GuiGotoPreviousMenu
return

^A::
LV_Modify(0, "Select")
return

^N::
Gosub, GuiAddFavoriteSelectType
return

Enter::
if (LV_GetCount("Selected") > 1)
	Gosub, GuiMoveMultipleFavoritesToMenu
else
	Gosub, GuiEditFavorite
return

Del::
if (LV_GetCount("Selected") > 1)
	Gosub, GuiRemoveMultipleFavorites
else
	Gosub, GuiRemoveFavorite
return

^C::
	Gosub, GuiCopyFavorite
return

#If
; End of Gui Hotkeys


;========================================================================================================================
; END OF GUI HOTKEYS
;========================================================================================================================



;========================================================================================================================
!_015_INITIALIZATION_SUBROUTINES:
;========================================================================================================================

;-----------------------------------------------------------
SetQAPWorkingDirectory:
;-----------------------------------------------------------

/*

First, the whole story...

Check if what mode QAP is running:
- if the file "_do_not_remove_or_rename.txt" is in A_ScriptDir, we are in Setup mode
- else we are in Portable mode.

IF PORTABLE

If we are in Portable mode, we keep the A_WorkingDir and return. It is equal to A_ScriptDir except if the user set the "Start In" folder in a shortcut.

IF SETUP

In the Start Menu Group "Quick Access Popup", setup program created a shortcut with "Start In" set to "{commonappdata}\Quick Access Popup"
(the Start Menu Group is created under the All Users profile unless the user installing the app does not have administrative privileges,
in which case it is created in the user's profile).

If A_WorkingDir equals A_ScriptDir and we are Setup mode, it means that QAP has been launched directly in the Program Files directory
instead of using the Start menu or Startup shortcuts. In this situation, we know that the working directory has not been set properly.
We change it to "{commonappdata}\Quick Access Popup".

In "{commonappdata}\Quick Access Popup", setup program created or saved the files:
- "{commonappdata}\{#MyAppName}" the files quickaccesspopup-setup.ini" (used to set initial QAP language to setup program language)
- "QAPconnect.ini" (used by QAP for custom file managers).

If, during setup, the user selected the "Import Folders Popup settings and favorites" option, the setup program will import the FP settings
and create the file "quickaccesspopup.ini" in "{commonappdata}\Quick Access Popup". An administrator could also create this file that will
be used as a template to be copied to "{userappdata}\Quick Access Popup" when QAP is launched for the first time.

Normally, when the user starts QAP with the Start Group shortcut, A_WorkingDir is set to "{commonappdata}\Quick Access Popup".
If not, keep the A_WorkingDir set by the user and return.

If A_WorkingDir is "{commonappdata}\Quick Access Popup", check if "{userappdata}\Quick Access Popup" exists. If not, create it.
If the files "quickaccesspopup-setup.ini", "QAPconnect.ini" and "quickaccesspopup.ini" do not exist in "{userappdata}\Quick Access Popup",
copy them from "{commonappdata}\Quick Access Popup".

Then, set A_WorkingDir to "{userappdata}\Quick Access Popup" and return.

AFTER A_WORKINGDIR IS SET (PORTABLE OR SETUP)

QAP check if quickaccesspopup.ini exists in A_WorkingDir. If not, it creates a new one, etc. (as in previous versions of FP and QAP).
If yes, it continues initialization with this file.

STARTUP SHORTCUT

If the "Run at startup" is enabled, a shortcut is created in the user's startup folder with "Start In" set to the current A_WorkingDir.
In Portable mode, A_WorkingDir is what the user decided. In Setup mode, A_WorkingDir is "{userappdata}\Quick Access Popup" (unless user changed it).

*/

; Now, step-by-step...

; Check if what mode QAP is running:
; - if the file "_do_not_remove_or_rename.txt" is in A_ScriptDir, we are in Setup mode
; - else we are in Portable mode.

; ###_V("A_ScriptDir\_do_not_remove_or_rename.txt exists?", FileExist(A_ScriptDir . "\_do_not_remove_or_rename.txt"), A_ScriptDir, A_WorkingDir)

; If we are in Portable mode, we keep the A_WorkingDir and return. It is equal to A_ScriptDir except if the user set the "Start In" folder in a shortcut.
if !FileExist(A_ScriptDir . "\_do_not_remove_or_rename.txt")
	return

; Now we are in Setup mode

; If A_WorkingDir equals A_ScriptDir and we are Setup mode, it means that QAP has been launched directly in the Program Files directory
; instead of using the Start menu or Startup shortcuts. In this situation, we know that the working directory has not been set properly.
; We change it to "{commonappdata}\Quick Access Popup".

if (A_WorkingDir = A_ScriptDir) and FileExist(A_WorkingDir . "\_do_not_remove_or_rename.txt")
	SetWorkingDir, %A_AppDataCommon%\Quick Access Popup

; Normally, when the user starts QAP with the Start Group shortcut, A_WorkingDir is set to "{commonappdata}\Quick Access Popup".
; If not, QAP was possibily launched with a Startup shortcut that set the A_WorkingDir to "{userappdata}\Quick Access Popup".
; Keep the A_WorkingDir set by the shortcut and return.

if (A_WorkingDir <> A_AppDataCommon . "\Quick Access Popup")
	return

; If A_WorkingDir is "{commonappdata}\Quick Access Popup", check if "{userappdata}\Quick Access Popup" exists. If not, create it.

if !FileExist(A_AppData . "\Quick Access Popup")
	FileCreateDir, %A_AppData%\Quick Access Popup

; If the files "quickaccesspopup-setup.ini", "QAPconnect.ini" and "quickaccesspopup.ini" do not exist in "{userappdata}\Quick Access Popup",
; copy them from "{commonappdata}\Quick Access Popup".
if !FileExist(A_AppData . "\Quick Access Popup\quickaccesspopup-setup.ini")
	FileCopy, %A_AppDataCommon%\Quick Access Popup\quickaccesspopup-setup.ini, %A_AppData%\Quick Access Popup
if !FileExist(A_AppData . "\Quick Access Popup\QAPconnect.ini")
	FileCopy, %A_AppDataCommon%\Quick Access Popup\QAPconnect.ini, %A_AppData%\Quick Access Popup
if !FileExist(A_AppData . "\Quick Access Popup\quickaccesspopup.ini")
	FileCopy, %A_AppDataCommon%\Quick Access Popup\quickaccesspopup.ini, %A_AppData%\Quick Access Popup

; Then, set A_WorkingDir to "{userappdata}\Quick Access Popup" and return.

SetWorkingDir, %A_AppData%\Quick Access Popup

return
;-----------------------------------------------------------


;-----------------------------------------------------------
InitFileInstall:
;-----------------------------------------------------------

g_strTempDir := A_WorkingDir . "\_temp"
FileCreateDir, %g_strTempDir%

/*
FileInstall, FileInstall\QuickAccessPopup_LANG_DE.txt, %g_strTempDir%\QuickAccessPopup_LANG_DE.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_FR.txt, %g_strTempDir%\QuickAccessPopup_LANG_FR.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_NL.txt, %g_strTempDir%\QuickAccessPopup_LANG_NL.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_KO.txt, %g_strTempDir%\QuickAccessPopup_LANG_KO.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_SV.txt, %g_strTempDir%\QuickAccessPopup_LANG_SV.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_IT.txt, %g_strTempDir%\QuickAccessPopup_LANG_IT.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_ES.txt, %g_strTempDir%\QuickAccessPopup_LANG_ES.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_PT-BR.txt, %g_strTempDir%\QuickAccessPopup_LANG_PT-BR.txt, 1
*/

FileInstall, FileInstall\default_browser_icon.html, %g_strTempDir%\default_browser_icon.html, 1

FileInstall, FileInstall\about-32.png, %g_strTempDir%\about-32.png
FileInstall, FileInstall\add_property-48.png, %g_strTempDir%\add_property-48.png
FileInstall, FileInstall\delete_property-48.png, %g_strTempDir%\delete_property-48.png
FileInstall, FileInstall\copy-48.png, %g_strTempDir%\copy-48.png
FileInstall, FileInstall\keyboard-48.png, %g_strTempDir%\keyboard-48.png
FileInstall, FileInstall\separator-26.png, %g_strTempDir%\separator-26.png
FileInstall, FileInstall\column-26.png, %g_strTempDir%\column-26.png
FileInstall, FileInstall\down_circular-26.png, %g_strTempDir%\down_circular-26.png
FileInstall, FileInstall\edit_property-48.png, %g_strTempDir%\edit_property-48.png
FileInstall, FileInstall\generic_sorting2-26-grey.png, %g_strTempDir%\generic_sorting2-26-grey.png
FileInstall, FileInstall\help-32.png, %g_strTempDir%\help-32.png
FileInstall, FileInstall\left-12.png, %g_strTempDir%\left-12.png
FileInstall, FileInstall\settings-32.png, %g_strTempDir%\settings-32.png
FileInstall, FileInstall\up-12.png, %g_strTempDir%\up-12.png
FileInstall, FileInstall\up_circular-26.png, %g_strTempDir%\up_circular-26.png

FileInstall, FileInstall\thumbs_up-32.png, %g_strTempDir%\thumbs_up-32.png
FileInstall, FileInstall\solutions-32.png, %g_strTempDir%\solutions-32.png
FileInstall, FileInstall\handshake-32.png, %g_strTempDir%\handshake-32.png
FileInstall, FileInstall\conference-32.png, %g_strTempDir%\conference-32.png
FileInstall, FileInstall\gift-32.png, %g_strTempDir%\gift-32.png

return
;-----------------------------------------------------------


;-----------------------------------------------------------
InitLanguageVariables:
;-----------------------------------------------------------

#Include %A_ScriptDir%\QuickAccessPopup_LANG.ahk

return
;-----------------------------------------------------------


;-----------------------------------------------------------
InitSystemArrays:
;-----------------------------------------------------------

; ----------------------
; Hotkeys: ini names, hotkey variables name, default values, gosub label and Gui hotkey titles
strPopupHotkeyNames := "NavigateOrLaunchHotkeyMouse|NavigateOrLaunchHotkeyKeyboard|PowerHotkeyMouse|PowerHotkeyKeyboard"
StringSplit, g_arrPopupHotkeyNames, strPopupHotkeyNames, |
strPopupHotkeyDefaults := "MButton|#W|+MButton|+#W"
StringSplit, g_arrPopupHotkeyDefaults, strPopupHotkeyDefaults, |
g_arrPopupHotkeys := Array ; initialized by LoadIniPopupHotkeys
g_arrPopupHotkeysPrevious := Array ; initialized by GuiOptions and checked in LoadIniPopupHotkeys

g_strMouseButtons := "None|LButton|MButton|RButton|XButton1|XButton2|WheelUp|WheelDown|WheelLeft|WheelRight|"
; leave last | to enable default value on the last item
StringSplit, g_arrMouseButtons, g_strMouseButtons, |

; ----------------------
; Icon files and index tested on Win 7 and Win 10. Win 8.1 assumed as Win 7.

strIconsMenus := "iconControlPanel|iconNetwork|iconRecycleBin|iconPictures|iconCurrentFolders"
	. "|iconMyMusic|iconMyComputer|iconDesktop|iconSettings|iconRecentFolders"
	. "|iconRecentFolders|iconNetworkNeighborhood|iconDownloads|iconChangeFolder|iconMyVideo"
	. "|iconDocuments|iconSpecialFolders|iconDonate|iconAddThisFolder"
	. "|iconFolder|iconHelp|iconFonts|iconGroupLoad|iconTemplates"
	. "|iconEditFavorite|iconFavorites|iconGroup|iconFTP|iconNoContent"
	. "|iconTemporary|iconHotkeys|iconUnknown|iconLaunch|iconExit"
	. "|iconAbout|iconHistory|iconClipboard|iconGroupSave|iconSubmenu"
	. "|iconOptions|iconApplication|iconWinver"

if (GetOsVersion() = "WIN_10")
{
	strIconsFile := "imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|winver"
	strIconsIndex := "23|29|50|68|96"
		. "|104|105|106|110|113"
		. "|113|115|176|177|179"
		. "|189|204|209|225"
		. "|4|24|39|46|55"
		. "|68|87|99|104|110"
		. "|153|174|176|215|216"
		. "|222|240|261|299|300"
		. "|319|324|1"
}
else
{
	strIconsFile := "imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres|imageres"
		. "|imageres|imageres|imageres|imageres"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|shell32|shell32|shell32"
		. "|shell32|shell32|winver"
	strIconsIndex := "23|29|50|68|96"
		. "|104|105|106|110|113"
		. "|113|115|176|177|179"
		. "|189|203|208|217"
		. "|4|24|39|46|55"
		. "|68|87|99|104|110"
		. "|153|174|176|215|216"
		. "|222|240|261|297|298"
		. "|301|304|1"
}

StringSplit, arrIconsFile, strIconsFile, |
StringSplit, arrIconsIndex, strIconsIndex, |

Loop, Parse, strIconsMenus, |
{
	g_objIconsFile[A_LoopField] := A_WinDir . "\System32\" . arrIconsFile%A_Index% . (arrIconsFile%A_Index% = "winver" ? ".exe" : ".dll")
	g_objIconsIndex[A_LoopField] := arrIconsIndex%A_Index%
}
; example: g_objIconsFile["iconPictures"] and g_objIconsIndex["iconPictures"]

; ----------------------
; FAVORITE TYPES
strFavoriteTypes := "Folder|Document|Application|Special|URL|FTP|QAP|Menu|Group"
StringSplit, g_arrFavoriteTypes, strFavoriteTypes, |
StringSplit, arrFavoriteTypesLabels, lDialogFavoriteTypesLabels, |
g_objFavoriteTypesLabels := Object()
StringSplit, arrFavoriteTypesLocationLabels, lDialogFavoriteTypesLocationLabels, |
g_objFavoriteTypesLocationLabels := Object()
; StringSplit, arrFavoriteTypesHelp, lDialogFavoriteTypesHelp, |
Loop, 9
	arrFavoriteTypesHelp%A_Index% := lDialogFavoriteTypesHelp%A_Index%
g_objFavoriteTypesHelp := Object()
StringSplit, arrFavoriteTypesShortNames, lDialogFavoriteTypesShortNames, |
g_objFavoriteTypesShortNames := Object()
Loop, %g_arrFavoriteTypes0%
{
	; example to display favorite type label: g_objFavoriteTypesLabels["Folder"], g_objFavoriteTypesLabels["Document"]
	g_objFavoriteTypesLabels.Insert(g_arrFavoriteTypes%A_Index%, arrFavoriteTypesLabels%A_Index%)
	g_objFavoriteTypesLocationLabels.Insert(g_arrFavoriteTypes%A_Index%, arrFavoriteTypesLocationLabels%A_Index%)
	g_objFavoriteTypesHelp.Insert(g_arrFavoriteTypes%A_Index%, arrFavoriteTypesHelp%A_Index%)
	g_objFavoriteTypesShortNames.Insert(g_arrFavoriteTypes%A_Index%, arrFavoriteTypesShortNames%A_Index%)
}

; 1 Basic Settings, 2 Menu Options, 3 Window Options, 4 Advanced Settings
StringSplit, g_arrFavoriteGuiTabs, lDialogAddFavoriteTabs, |

; ----------------------
; ACTIVE FILE MANAGER
; g_arrActiveFileManagerSystemNames: array system names (1-4)
; g_arrActiveFileManagerDisplayNames: array system names (1-4)
; g_intActiveFileManager: default 1 for "WindowsExplorer" (replace "blnUseXYZ" variables from FP)

strActiveFileManagerSystemNames := "WindowsExplorer|DirectoryOpus|TotalCommander|QAPconnect"
StringSplit, g_arrActiveFileManagerSystemNames, strActiveFileManagerSystemNames, |

strActiveFileManagerDisplayNames := "Windows Explorer|Directory Opus|Total Commander|QAPconnect"
StringSplit, g_arrActiveFileManagerDisplayNames, strActiveFileManagerDisplayNames, |

; ----------------------

strPopupHotkeyNames := ""
strPopupHotkeyDefaults := ""
strIconsMenus := ""
strIconsFile := ""
strIconsIndex := ""
arrIconsFile := ""
arrIconsIndex := ""
strFavoriteTypes := ""
arrFavoriteTypesLabels := ""
arrFavoriteTypesLocationLabels := ""
arrFavoriteTypesHelp := ""
arrFavoriteTypesShortNames := ""
strActiveFileManagerSystemNames := ""
strActiveFileManagerNames := ""
arrActiveFileManagerNames := ""

return
;-----------------------------------------------------------


;------------------------------------------------------------
InitLanguages:
;------------------------------------------------------------

IfNotExist, %g_strIniFile%
	; read language code from ini file created by the Inno Setup script in the user data folder
	IniRead, g_strLanguageCode, % A_WorkingDir . "\" . g_strAppNameFile . "-setup.ini", Global , LanguageCode, EN
else
	IniRead, g_strLanguageCode, %g_strIniFile%, Global, LanguageCode, EN

strLanguageFile := g_strTempDir . "\" . g_strAppNameFile . "_LANG_" . g_strLanguageCode . ".txt"
strReplacementForSemicolon := "!r4nd0mt3xt!" ; for non-comment semi-colons ";" escaped as ";;"

if FileExist(strLanguageFile)
{
	FileRead, strLanguageStrings, %strLanguageFile%
	Loop, Parse, strLanguageStrings, `n, `r
	{
		if (SubStr(A_LoopField, 1, 1) <> ";") ; skip comment lines
		{
			StringSplit, arrLanguageBit, A_LoopField, `t
			if SubStr(arrLanguageBit1, 1, 1) = "l"
				%arrLanguageBit1% := arrLanguageBit2
			StringReplace, %arrLanguageBit1%, %arrLanguageBit1%, ``n, `n, All
			
			if InStr(%arrLanguageBit1%, ";;") ; preserve escaped ; in string
				StringReplace, %arrLanguageBit1%, %arrLanguageBit1%, % ";;", %strReplacementForSemicolon%, A
			if InStr(%arrLanguageBit1%, ";")
				%arrLanguageBit1% := Trim(SubStr(%arrLanguageBit1%, 1, InStr(%arrLanguageBit1%, ";") - 1)) ; trim comment from ; and trim spaces and tabs
			if InStr(%arrLanguageBit1%, strReplacementForSemicolon) ; restore escaped ; in string
				StringReplace, %arrLanguageBit1%, %arrLanguageBit1%, %strReplacementForSemicolon%, % ";", A
		}
	}
}
else
	g_strLanguageCode := "EN"

strLanguageFile := ""
strReplacementForSemicolon := ""
strLanguageStrings := ""
arrLanguageBit := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
InitLanguageArrays:
;------------------------------------------------------------
StringSplit, g_arrOptionsPopupHotkeyTitles, lOptionsPopupHotkeyTitles, |
strOptionsLanguageCodes := "EN|FR|DE|NL|KO|SV|IT|ES|PT-BR"
StringSplit, g_arrOptionsLanguageCodes, strOptionsLanguageCodes, |
StringSplit, g_arrOptionsLanguageLabels, lOptionsLanguageLabels, |

loop, %g_arrOptionsLanguageCodes0%
	if (g_arrOptionsLanguageCodes%A_Index% = g_strLanguageCode)
		{
			g_strLanguageLabel := g_arrOptionsLanguageLabels%A_Index%
			break
		}

lDialogMouseButtonsText := lDialogNone . "|" . lDialogMouseButtonsText ; use lDialogNone because this is displayed
StringSplit, g_arrMouseButtonsText, lDialogMouseButtonsText, |

strOptionsLanguageCodes := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
InitSpecialFolders:
;------------------------------------------------------------

; Shell numeric Constants
; http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx

; Shell Commands:
; http://www.sevenforums.com/tutorials/4941-shell-command.html
; http://www.eightforums.com/tutorials/6050-shell-commands-windows-8-a.html

; Environment system variables
; http://en.wikipedia.org/wiki/Environment_variable#Windows

; InitSpecialFolderObject(strClassIdOrPath, strShellConstant, intShellConstant, strAHKConstant, strDOpusAlias, strTCCommand
;	, strDefaultName, strDefaultIcon
;	, strUse4NavigateExplorer, strUse4NewExplorer, strUse4Dialog, strUse4Console, strUse4DOpus, strUse4TC, strUse4FPc)

; 		CLS: Class ID
;		SCT: Shell Constant Text
;		SCN: Shell Constant Numeric
;		DOA: Directory Opus Alias
;		TCC: Total Commander Commands
;		NEW: Open in new Explorer anyway
;
; NOTES
; - Total Commander commands: cm_OpenDesktop (2121), cm_OpenDrives (2122), cm_OpenControls (2123), cm_OpenFonts (2124), cm_OpenNetwork (2125), cm_OpenPrinters (2126), cm_OpenRecycled (2127)
; - DOpus see http://resource.dopus.com/viewtopic.php?f=3&t=23691
;
; InitSpecialFolderObject(strClassIdOrPath, strShellConstantText, intShellConstantNumeric, strAHKConstant, strDOpusAlias, strTCCommand
;	, strDefaultName, strDefaultIcon
;	, strUse4NavigateExplorer, strUse4NewExplorer, strUse4Dialog, strUse4Console, strUse4DOpus, strUse4TC, strUse4FPc)

;---------------------
; CLSID giving localized name and icon, with valid Shell Command

InitSpecialFolderObject("{D20EA4E1-3957-11d2-A40B-0C5020524153}", "Common Administrative Tools", -1, "", "commonadmintools", ""
	, "Administrative Tools", "" ; Outils d�administration
	, "CLS", "CLS", "NEW", "NEW", "DOA", "NEW", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "MyComputerFolder", 17, "", "mycomputer", 2122
	, "Computer", "" ; Ordinateur
	, "SCT", "SCT", "SCT", "NEW", "DOA", "TCC", "NEW") ; for 1,2,3 CLS works, 7 OK for FPc but CLS does not work with DoubleCommander
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{21EC2020-3AEA-1069-A2DD-08002B30309D}", "ControlPanelFolder", 3, "", "controls", 2123
	, "Control Panel (Icons view)", "" ; Tous les Panneaux de configuration
	, "SCT", "SCT", "NEW", "NEW", "DOA", "CLS", "NEW")
	; OK     OK      OK     OK    OK  NO-use NEW
InitSpecialFolderObject("{450D8FBA-AD25-11D0-98A8-0800361B1103}", "Personal", 5, "A_MyDocuments", "mydocuments", ""
	, "Documents", "" ; Mes documents
	, "SCT", "SCT", "AHK", "AHK", "DOA", "AHK", "AHK")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{ED228FDF-9EA8-4870-83b1-96b02CFE0D52}", "Games", -1, "", "", ""
	, "Games Explorer", "" ; Jeux
	, "SCT", "SCT", "NEW", "NEW", "NEW", "CLS", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}", "HomeGroupFolder", -1, "", "", ""
	, "HomeGroup", "" ; Groupe r�sidentiel
	, "SCT", "SCT", "SCT", "NEW", "NEW", "CLS", "NEW")
	; OK     OK      OK     OK    OK     OK
InitSpecialFolderObject("{031E4825-7B94-4dc3-B131-E946B44C8DD5}", "Libraries", -1, "", "libraries", ""
	, "Libraries", "" ; Biblioth�que
	, "SCT", "SCT", "SCT", "NEW", "DOA", "CLS", "NEW")
	; OK     OK      OK     OK     OK      OK
InitSpecialFolderObject("{7007ACC7-3202-11D1-AAD2-00805FC1270E}", "ConnectionsFolder", -1, "", "", ""
	, "Network Connections", "" ; Connexions r�seau
	, "SCT", "SCT", "NEW", "NEW", "NEW", "CLS", "NEW")
	; OK     OK      OK     OK     OK    No-OK
InitSpecialFolderObject("{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}", "NetworkPlacesFolder", 18, "", "network", 2125
	, "Network", "" ; R�seau
	, "SCT", "SCT", "SCT", "NEW", "DOA", "TCC", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{2227A280-3AEA-1069-A2DE-08002B30309D}", "PrintersFolder", -1, "", "printers", 2126
	, "Printers and Faxes", "" ; Imprimantes
	, "SCT", "SCT", "NEW", "NEW", "DOA", "TCC", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{645FF040-5081-101B-9F08-00AA002F954E}", "RecycleBinFolder", 0, "", "trash", 2127
	, "Recycle Bin", "" ; Corbeille
	, "SCT", "SCT", "NEW", "NEW", "DOA", "TCC", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{59031a47-3f72-44a7-89c5-5595fe6b30ee}", "Profile", -1, "", "profile", ""
	, lMenuUserFolder, "" ; Dossier de l'utilisateur
	, "SCT", "SCT", "SCT", "NEW", "DOA", "CLS", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{1f3427c8-5c10-4210-aa03-2ee45287d668}", "User Pinned", -1, "", "", ""
	, lMenuUserPinned, "" ; Epingl� par l'utilisateur
	, "SCT", "SCT", "SCT", "NEW", "NEW", "NEW", "NEW")
	; OK     OK      OK     OK    OK      OK
InitSpecialFolderObject("{BD84B380-8CA2-1069-AB1D-08000948534}", "Fonts", -1, "", "fonts", 2124
	, lMenuFonts, "iconFonts"
	, "SCT", "SCT", "NEW", "NEW", "DOA", "TCC", "NEW")
	; OK     OK      OK     OK    OK      OK

;---------------------
; CLSID giving localized name and icon, no valid Shell Command, must be open in a new Explorer using CLSID - to be tested with DOpus, TC and FPc

InitSpecialFolderObject("{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}", "", -1, "", "", ""
	, "Backup and Restore", "" ; Sauvegarder et restaurer
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{ED7BA470-8E54-465E-825C-99712043E01C}", "", -1, "", "", ""
	, "Control Panel (All Tasks)", "" ; Toutes les t�ches
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{323CA680-C24D-4099-B94D-446DD2D7249E}", "", -1, "", "favorites", ""
	, "Favorites", "" ; Favoris (<> Favorites (Internet))
	, "CLS", "CLS", "CLS", "NEW", "DOA", "NEW", "NEW")
if (GetOsVersion() <> "WIN_10")
	InitSpecialFolderObject("{3080F90E-D7AD-11D9-BD98-0000947B0257}", "", -1, "", "", ""
		, "Flip 3D", "" ; Pas de traduction
		, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{6DFD7C5C-2451-11d3-A299-00C04F8EF6AF}", "", -1, "", "", ""
	, "Folder Options", "" ; Options des dossiers
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
if (A_OSVersion = "WIN_7") ; Performance Information and Tool not available on Win8+
	InitSpecialFolderObject("{78F3955E-3B90-4184-BD14-5397C15F1EFC}", "", -1, "", "", ""
		, "Performance Information and Tools", "" ; Informations et outils de performance
		, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{35786D3C-B075-49b9-88DD-029876E11C01}", "", -1, "", "", ""
	, "Portable Devices", "" ; Appareils mobiles
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{22877a6d-37a1-461a-91b0-dbda5aaebc99}", "", -1, "", "", ""
	, "Recent Places", "" ; Emplacements r�cents
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{3080F90D-D7AD-11D9-BD98-0000947B0257}", "", -1, "", "", ""
	, "Show Desktop", "" ; Afficher le Bureau
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")
InitSpecialFolderObject("{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}", "", -1, "", "", ""
	, "System", "" ; Syst�me
	, "CLS", "CLS", "NEW", "NEW", "NEW", "NEW", "NEW")

;---------------------
; Path from registry (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

RegRead, g_strDownloadPath, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, {374DE290-123F-4565-9164-39C4925E467B}
InitSpecialFolderObject(g_strDownloadPath, "", -1, "", "downloads", ""
	, lMenuDownloads, "iconDownloads"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Music
InitSpecialFolderObject(strException, "", -1, "", "mymusic", ""
	, lMenuMyMusic, "iconMyMusic"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Video
InitSpecialFolderObject(strException, "", -1, "", "myvideos", ""
	, lMenuMyVideo, "iconMyVideo"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Templates
InitSpecialFolderObject(strException, "", -1, "", "templates", ""
	, lMenuTemplates, "iconTemplates"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, g_strMyPicturesPath, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Pictures
InitSpecialFolderObject(g_strMyPicturesPath, "", 39, "", "mypictures", ""
	, lMenuPictures, "iconPictures"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Favorites ; Favorites (Internet)
InitSpecialFolderObject(strException, "", -1, "", "", ""
	, lMenuFavoritesInternet, "iconFavorites"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")

;---------------------
; Path under %APPDATA% (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Start Menu", "", -1, "A_StartMenu", "start", ""
	, lMenuStartMenu, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup", "", -1, "A_Startup", "startup", ""
	, lMenuStartup, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%", "", -1, "A_AppData", "appdata", ""
	, lMenuAppData, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Recent", "", -1, "", "recent", ""
	, lMenuRecentItems, "iconRecentFolders"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
if (GetOsVersion() = "WIN_10")
	InitSpecialFolderObject("%LocalAppData%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\Cookies", "", -1, "", "cookies", ""
		, lMenuCookies, "iconFolder"
		, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
else
	InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Cookies", "", -1, "", "cookies", ""
		, lMenuCookies, "iconFolder"
		, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Internet Explorer\Quick Launch", "", -1, "", "", ""
	, lMenuQuickLaunch, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\SystemCertificates", "", -1, "", "", ""
	, lMenuSystemCertificates, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")

;---------------------
; Path under other environment variables (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

InitSpecialFolderObject("%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu", "", -1, "A_StartMenuCommon", "commonstartmenu", ""
	, lMenuCommonStartMenu, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup", "", -1, "A_StartupCommon", "commonstartup", ""
	, lMenuCommonStartupMenu, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ALLUSERSPROFILE%", "", -1, "A_AppDataCommon", "commonappdata", ""
	, lMenuCommonAppData, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%LOCALAPPDATA%\Microsoft\Windows\Temporary Internet Files", "", -1, "", "", ""
	, lMenuCache, "iconTemporary"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")
InitSpecialFolderObject("%LOCALAPPDATA%\Microsoft\Windows\History", "", -1, "", "history", ""
	, lMenuHistory, "iconHistory"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ProgramFiles%", "", -1, "A_ProgramFiles", "programfiles", ""
	, lMenuProgramFiles, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
if (A_Is64bitOS)
	InitSpecialFolderObject("%ProgramFiles(x86)%", "", -1, "", "programfilesx86", ""
		, lMenuProgramFiles . " (x86)", "iconFolder"
		, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%PUBLIC%\Libraries", "", -1, "", "", ""
	, lMenuPublicLibraries, "iconFolder"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")

;---------------------
; Path under the Users folder (no CLSID, localized name and icon provided), no Shell Command

StringReplace, strPathUsername, A_AppData, \AppData\Roaming
StringReplace, strPathUsers, strPathUsername, \%A_UserName%

InitSpecialFolderObject(strPathUsers . "\Public", "Public", -1, "", "common", ""
	, "Public Folder", "" ; Public
	, "SCT", "SCT", "SCT", "CLS", "DOA", "CLS", "CLS")
	; OK     OK      OK     OK    OK      OK

;---------------------
; Path using AHK constants (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

InitSpecialFolderObject(A_Desktop, "", 0, "A_Desktop", "desktop", 2121
	, lMenuDesktop, "iconDesktop"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "TCC", "CLS")
InitSpecialFolderObject(A_DesktopCommon, "", -1, "A_DesktopCommon", "commondesktopdir", ""
	, lMenuCommonDesktop, "iconDesktop"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject(A_Temp, "", -1, "A_Temp", "temp", ""
	, lMenuTemporaryFiles, "iconTemporary"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject(A_WinDir, "", -1, "A_WinDir", "windows", ""
	, "Windows", "iconWinver"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject(A_Programs, "", -1, "A_Programs", "programs", "" ; CLSID was "{7be9d83c-a729-4d97-b5a7-1b7313c39e0a}" but not working under Win 10
	, lMenuProgramsFolderStartMenu, "" ; Menu D�marrer / Programmes (Menu Start/Programs)
	, "CLS", "CLS", "CLS", "CLS", "DOA", "AHK", "AHK")

;------------------------------------------------------------
; Build folders list for dropdown

g_strSpecialFoldersList := ""
for strSpecialFolderName in g_objClassIdOrPathByDefaultName
	g_strSpecialFoldersList .= strSpecialFolderName . "|"
StringTrimRight, g_strSpecialFoldersList, g_strSpecialFoldersList, 1

strException := ""
strPathUsername := ""
strPathUsers := ""
strSpecialFolderName := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
InitSpecialFolderObject(strClassIdOrPath, strShellConstantText, intShellConstantNumeric, strAHKConstant, strDOpusAlias, strTCCommand
	, strDefaultName, strDefaultIcon
	, strUse4NavigateExplorer, strUse4NewExplorer, strUse4Dialog, strUse4Console, strUse4DOpus, strUse4TC, strUse4FPc)

; strClassIdOrPath: CLSID or Path, used as key to access objSpecialFolder objects
;		CLSID Win_7: http://www.sevenforums.com/tutorials/110919-clsid-key-list-windows-7-a.html
;		CLSID Win_8: http://www.eightforums.com/tutorials/13591-clsid-key-guid-shortcuts-list-windows-8-a.html
; 		Environment system variables: http://en.wikipedia.org/wiki/Environment_variable#Windows
;		HKEY_CLASSES_ROOT Key: http://msdn.microsoft.com/en-us/library/windows/desktop/ms724475(v=vs.85).aspx
; 		NOTES How to call in Explorer...
;		... CLSID: shell:::{{20D04FE0-3AEA-1069-A2D8-08002B30309D}}
;		... ShellConstant: shell:MyComputerFolder

; strShellConstantText: text constant used to navigate using Explorer or Dialog box? What with DOpus and TC?
;		http://www.sevenforums.com/tutorials/4941-shell-command.html
;		http://www.eightforums.com/tutorials/6050-shell-commands-windows-8-a.html

; intShellConstantNumeric: numeric ShellSpecialFolderConstants constant 
;		http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx

; CLSID, strShellConstantText (by version XP!, Vista, 7) and intShellConstantNumeric: http://docs.rainmeter.net/tips/launching-windows-special-folders

; strAHKConstant: AutoHotkey constant

; strDOpusAlias: Directory Opus constant

; strTCCommand: Total Commander constant

; strDefaultName: name for menu if path is used, fallback name if CLSID is used to access localized name

; strDefaultIcon: icon in strIconsMenus if path is used, fallback icon (?) if CLSID returns no icon resource

; Constants for "use" flags:
; 		CLS: Class ID
;		SCT: Shell Constant Text
;		SCN: Shell Constant Numeric
;		DOA: Directory Opus Alias
;		TCC: Total Commander Commands

; Usage flags:
; 		strUse4NavigateExplorer
; 		strUse4NewExplorer
; 		strUse4Dialog
; 		strUse4Console
; 		strUse4DOpus
; 		strUse4TC
;		strUse4FPc

; Special Folder Object (objOneSpecialFolder) definition:
;		strClassIdOrPath: key to access one Special Folder object (example: g_objSpecialFolders[strClassIdOrPath], saved to ini file
;		objSpecialFolder.ShellConstantText: text constant used to navigate using Explorer or Dialog box? What with DOpus and TC?
;		objSpecialFolder.ShellConstantNumeric: numeric ShellSpecialFolderConstants constant 
;		objSpecialFolder.AHKConstant: AutoHotkey constant
;		objSpecialFolder.DOpusAlias: Directory Opus constant
;		objSpecialFolder.TCCommand: Total Commander constant
;		objSpecialFolder.DefaultName:
;		objSpecialFolder.DefaultIcon: icon resource name in the format "file,index"
;		objSpecialFolder.Use4NavigateExplorer:
;		objSpecialFolder.Use4NewExplorer:
;		objSpecialFolder.Use4Dialog:
;		objSpecialFolder.Use4Console:
;		objSpecialFolder.Use4DOpus:
;		objSpecialFolder.Use4TC:
;		objSpecialFolder.Use4FPc:

;------------------------------------------------------------
{
	global g_objIconsFile
	global g_objIconsIndex
	global g_objClassIdOrPathByDefaultName
	global g_objSpecialFolders
	
	objOneSpecialFolder := Object()
	
	blnIsClsId := (SubStr(strClassIdOrPath, 1, 1) = "{")

	if (blnIsClsId)
		strThisDefaultName := GetLocalizedNameForClassId(strClassIdOrPath)
	If !StrLen(strThisDefaultName)
		strThisDefaultName := strDefaultName
    g_objClassIdOrPathByDefaultName.Insert(strThisDefaultName, strClassIdOrPath)
	objOneSpecialFolder.DefaultName := strThisDefaultName
	
	if (blnIsClsId)
		strThisDefaultIcon := GetIconForClassId(strClassIdOrPath)
	if !StrLen(strThisDefaultIcon) and StrLen(g_objIconsFile[strDefaultIcon]) and StrLen(g_objIconsIndex[strDefaultIcon])
		strThisDefaultIcon := g_objIconsFile[strDefaultIcon] . "," . g_objIconsIndex[strDefaultIcon]
	if !StrLen(strThisDefaultIcon)
		strThisDefaultIcon := "%SystemRoot%\System32\shell32.dll,4"
	objOneSpecialFolder.DefaultIcon := strThisDefaultIcon

	objOneSpecialFolder.ShellConstantText := strShellConstantText
	objOneSpecialFolder.ShellConstantNumeric := intShellConstantNumeric
	objOneSpecialFolder.AHKConstant := strAHKConstant
	objOneSpecialFolder.DOpusAlias := strDOpusAlias
	objOneSpecialFolder.TCCommand := strTCCommand
	
	objOneSpecialFolder.Use4NavigateExplorer := strUse4NavigateExplorer
	objOneSpecialFolder.Use4NewExplorer := strUse4NewExplorer
	objOneSpecialFolder.Use4Dialog := strUse4Dialog
	objOneSpecialFolder.Use4Console := strUse4Console
	objOneSpecialFolder.Use4DOpus := strUse4DOpus
	objOneSpecialFolder.Use4TC := strUse4TC
	objOneSpecialFolder.Use4FPc := strUse4FPc
	
	g_objSpecialFolders.Insert(strClassIdOrPath, objOneSpecialFolder)
}
;------------------------------------------------------------


;------------------------------------------------------------
GetLocalizedNameForClassId(strClassId)
;------------------------------------------------------------
{
    RegRead, strLocalizedString, HKEY_CLASSES_ROOT, CLSID\%strClassId%, LocalizedString
    ; strLocalizedString example: "@%SystemRoot%\system32\shell32.dll,-9216"

    StringSplit, arrLocalizedString, strLocalizedString, `,
    intDllNameStart := InStr(arrLocalizedString1, "\", , 0)
    StringRight, strDllFile, arrLocalizedString1, % StrLen(arrLocalizedString1) - intDllNameStart
    strDllIndex := arrLocalizedString2
    strTranslatedName := TranslateMUI(strDllFile, Abs(strDllIndex))
    
    return strTranslatedName
}
;------------------------------------------------------------


;------------------------------------------------------------
GetIconForClassId(strClassId)
;------------------------------------------------------------
{
	RegRead, strDefaultIcon, HKEY_CLASSES_ROOT, CLSID\%strClassId%\DefaultIcon
    return strDefaultIcon
}
;------------------------------------------------------------


;------------------------------------------------------------
TranslateMUI(resDll, resID)
; source: 7plus (https://github.com/7plus/7plus/blob/master/MiscFunctions.ahk)
;------------------------------------------------------------
{
	VarSetCapacity(buf, 256) 
	hDll := DllCall("LoadLibrary", "str", resDll, "Ptr") 
	Result := DllCall("LoadString", "Ptr", hDll, "uint", resID, "str", buf, "int", 128)
	return buf
}
;------------------------------------------------------------


;------------------------------------------------------------
InitQAPFeatures:
;------------------------------------------------------------

; InitQAPFeatureObject(strQAPFeatureCode, strThisDefaultName, strQAPFeatureMenuName, strQAPFeatureCommand, intQAPFeaturePowerOrder, strThisDefaultIcon, strDefaultHotkey)

; Submenus features
InitQAPFeatureObject("Clipboard", lMenuClipboard . "...", "g_menuClipboard", "ClipboardMenuShortcut", 0, "iconClipboard", "+^C")
InitQAPFeatureObject("Current Folders", lMenuCurrentFolders . "...", "g_menuCurrentFolders", "CurrentFoldersMenuShortcut", 0, "iconCurrentFolders", "+^F")

; Command features
InitQAPFeatureObject("About", lGuiAbout . "...", "", "GuiAbout", 0, "iconAbout")
InitQAPFeatureObject("Add Favorite", lMenuAddFavorite . "...", "", "AddThisFolder", 0, "iconLaunch")
InitQAPFeatureObject("Add This Folder", lMenuAddThisFolder . "...", "", "AddThisFolder", 0, "iconAddThisFolder", "+^A")
InitQAPFeatureObject("Exit", L(lMenuExitApp, g_strAppNameText), "", "ExitApp", 0, "iconExit")
InitQAPFeatureObject("Help", lGuiHelp . "...", "", "GuiHelp", 0, "iconHelp")
InitQAPFeatureObject("Hotkeys", lDialogHotkeys . "...", "", "GuiHotkeysManageFromQAPFeature", 0, "iconHotkeys")
InitQAPFeatureObject("Options", lGuiOptions . "...", "", "GuiOptionsFromQAPFeature", 0, "iconOptions")
InitQAPFeatureObject("Recent Folders", lMenuRecentFolders . "...", "", "RecentFoldersMenuShortcut", 0, "iconRecentFolders", "+^R")
InitQAPFeatureObject("Settings", lMenuSettings . "...", "", "SettingsHotkey", 0, "iconSettings", "+^S")
InitQAPFeatureObject("Support", lGuiDonate . "...", "", "GuiDonate", 0, "iconDonate")

; Power Menu features
InitQAPFeatureObject("Open in New Window", lMenuPowerNewWindow, "", "", 1, "iconFolder")
InitQAPFeatureObject("Edit Favorite", lMenuPowerEditFavorite, "", "", 3, "iconEditFavorite")
InitQAPFeatureObject("Copy Favorite Location", lMenuCopyLocation, "", "", 5, "iconClipboard", "+^V")

;--------------------------------
; Build folders list for dropdown

g_strQAPFeaturesList := ""
for strQAPFeatureName, strThisQAPFeatureCode in g_objQAPFeaturesCodeByDefaultName
	if !(g_objQAPFeatures[strThisQAPFeatureCode].QAPFeaturePowerOrder) ; exclude Power menu features
		g_strQAPFeaturesList .= strQAPFeatureName . "|"
StringTrimRight, g_strQAPFeaturesList, g_strQAPFeaturesList, 1

strQAPFeatureName := ""
strThisQAPFeatureCode := ""
strQAPFeaturePowerOrder := ""
strQAPFeaturePowerCode := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
InitQAPFeatureObject(strQAPFeatureCode, strThisLocalizedName, strQAPFeatureMenuName, strQAPFeatureCommand, intQAPFeaturePowerOrder, strThisDefaultIcon, strDefaultHotkey := "")

; QAP Feature Objects (g_objQAPFeatures) definition:
;		Key: strQAPFeatureInternalName
;		Value: objOneQAPFeature

; QAP Features Object (objOneQAPFeature) definition:
;		LocalizedName: QAP Feature localized label
;		QAPFeatureMenuName: menu to be added to the menu (excluding the starting ":"), empty if no submenu associated to this QAP feature
;		QAPFeatureCommand: command to be executed when this favorite is selected (excluding the ending ":")
;		QAPFeaturePowerOrder: order of feature in the Power Menu displayed before user choose the target favorite (0 if not Power menu feature)
;		DefaultIcon: default icon (in the "file,index" format)
;		DefaultHotkey: default feature hotkey (string like "+^s")

;------------------------------------------------------------
{
	global g_objIconsFile
	global g_objIconsIndex
	global g_objQAPFeatures
	global g_objQAPFeaturesCodeByDefaultName
	global g_objQAPFeaturesDefaultNameByCode
	global g_objQAPFeaturesPowerCodeByOrder
	
	objOneQAPFeature := Object()
	
	objOneQAPFeature.LocalizedName := strThisLocalizedName
	objOneQAPFeature.DefaultIcon := g_objIconsFile[strThisDefaultIcon] . "," . g_objIconsIndex[strThisDefaultIcon]
	objOneQAPFeature.QAPFeatureMenuName := strQAPFeatureMenuName
	objOneQAPFeature.QAPFeatureCommand := strQAPFeatureCommand
	objOneQAPFeature.QAPFeaturePowerOrder := intQAPFeaturePowerOrder
	objOneQAPFeature.DefaultHotkey := strDefaultHotkey
	; ###_O("objOneQAPFeature", objOneQAPFeature)
	
	g_objQAPFeatures.Insert("{" . strQAPFeatureCode . "}", objOneQAPFeature)
	g_objQAPFeaturesCodeByDefaultName.Insert(strThisLocalizedName, "{" . strQAPFeatureCode . "}")
	g_objQAPFeaturesDefaultNameByCode.Insert("{" . strQAPFeatureCode . "}", strThisLocalizedName)
	if (intQAPFeaturePowerOrder)
		g_objQAPFeaturesPowerCodeByOrder.Insert(intQAPFeaturePowerOrder, "{" . strQAPFeatureCode . "}")
}
;------------------------------------------------------------


;------------------------------------------------------------
InitGuiControls:
;------------------------------------------------------------

; Order of controls important to avoid drawgins gliches when resizing

InsertGuiControlPos("f_lnkGuiDropHelpClicked",		 -88, -130)
InsertGuiControlPos("f_lnkGuiHotkeysHelpClicked",	  40, -130)

InsertGuiControlPos("f_picGuiOptions",				 -44,   10, true) ; true = center
InsertGuiControlPos("f_picGuiAddFavorite",			 -44,  120, true)
InsertGuiControlPos("f_picGuiEditFavorite",			 -44,  190, true)
InsertGuiControlPos("f_picGuiRemoveFavorite",		 -44,  260, true)
InsertGuiControlPos("f_picGuiCopyFavorite",			 -44,  330, true)
InsertGuiControlPos("f_picGuiHotkeysManage",		 -44, -140, true, true) ; true = center, true = draw
InsertGuiControlPos("f_picGuiDonate",				  50,  -62, true, true)
InsertGuiControlPos("f_picGuiHelp",					 -44,  -62, true, true)
InsertGuiControlPos("f_picGuiAbout",				-104,  -62, true, true)

InsertGuiControlPos("f_picAddColumnBreak",			  10,  230)
InsertGuiControlPos("f_picAddSeparator",			  10,  200)
InsertGuiControlPos("f_picMoveFavoriteDown",		  10,  170)
InsertGuiControlPos("f_picMoveFavoriteUp",			  10,  140)
InsertGuiControlPos("f_picPreviousMenu",			  10,   84)
; InsertGuiControlPos("picSortFavorites",			  10, -165) ; REMOVED
InsertGuiControlPos("f_picUpMenu",					  25,   84)

InsertGuiControlPos("f_btnGuiSaveFavorites",		   0,  -90, , true)				
InsertGuiControlPos("f_btnGuiCancel",				   0,  -90, , true)

InsertGuiControlPos("f_drpMenusList",				  40,   84)

InsertGuiControlPos("f_lblGuiDonate",				  50,  -20, true)
InsertGuiControlPos("f_lblGuiAbout",				-104,  -20, true)
InsertGuiControlPos("f_lblGuiHelp",					 -44,  -20, true)
InsertGuiControlPos("f_lblAppName",					  10,   10)
InsertGuiControlPos("f_lblAppTagLine",				  10,   42)
InsertGuiControlPos("f_lblGuiAddFavorite",			 -44,  170, true)
InsertGuiControlPos("f_lblGuiEditFavorite",			 -44,  240, true)
InsertGuiControlPos("f_lblGuiOptions",				 -44,   45, true)
InsertGuiControlPos("f_lblGuiRemoveFavorite",		 -44,  310, true)
InsertGuiControlPos("f_lblGuiCopyFavorite",			 -44,  380, true)
InsertGuiControlPos("f_lblSubmenuDropdownLabel",	  40,   66)
InsertGuiControlPos("f_lblGuiHotkeysManage",		 -44, -100, true)

InsertGuiControlPos("f_lvFavoritesList",			  40,  115)

return
;------------------------------------------------------------


;------------------------------------------------------------
InsertGuiControlPos(strControlName, intX, intY, blnCenter := false, blnDraw := false)
;------------------------------------------------------------
{
	global g_objGuiControls
	
	objGuiControl := Object()
	objGuiControl.Name := strControlName
	objGuiControl.X := intX
	objGuiControl.Y := intY
	objGuiControl.Center := blnCenter
	objGuiControl.Draw := blnDraw
	
	g_objGuiControls.Insert(objGuiControl)
	
	objGuiControl := ""
}
;------------------------------------------------------------


;-----------------------------------------------------------
LoadIniFile:
ReloadIniFile:
;-----------------------------------------------------------

; create a backup of the ini file before loading
StringReplace, strIniBackupFile, g_strIniFile, .ini, -backup.ini
FileCopy, %g_strIniFile%, %strIniBackupFile%, 1

if (g_strCurrentBranch = "alpha")
; create a daily backup of the ini file for alpha versions users
{
	StringReplace, strIniBackupFile, strIniBackupFile, .ini, % "-" . SubStr(A_Now, 1, 8) . ".ini"
	if !FileExist(strIniBackupFile)
		FileCopy, %g_strIniFile%, %strIniBackupFile%, 1
}
; reinit after Settings save if already exist
g_objMenuInGui := Object() ; object of menu currently in Gui
g_objMenusIndex := Object() ; index of menus path used in Gui menu dropdown list and to access the menu object for a given menu path
g_objQAPfeaturesInMenus := Object() ; index of QAP features actualy present in menu
g_objMainMenu := Object() ; object of menu structure entry point
g_objMainMenu.MenuPath := lMainMenuName ; localized name of the main menu
g_objMainMenu.MenuType := "Menu" ; main menu is not a group

IfNotExist, %g_strIniFile% ; if it exists, it was created by ImportFavoritesFP2QAP.ahk during install
{
	strNavigateOrLaunchHotkeyMouseDefault := g_arrPopupHotkeyDefaults1 ; "MButton"
	strNavigateOrLaunchHotkeyKeyboardDefault := g_arrPopupHotkeyDefaults2 ; "W"
	strPowerHotkeyMouseDefault := g_arrPopupHotkeyDefaults3 ; "+MButton"
	strPowerHotkeyKeyboardDefault := g_arrPopupHotkeyDefaults4 ; "+#W"
	
	g_intIconSize := 32

	FileAppend,
		(LTrim Join`r`n
			[Global]
			NavigateOrLaunchHotkeyMouse=%strNavigateOrLaunchHotkeyMouseDefault%
			NavigateOrLaunchHotkeyKeyboard=%strNavigateOrLaunchHotkeyKeyboardDefault%
			PowerHotkeyMouseDefault=%strPowerHotkeyMouseDefault%
			PowerHotkeyKeyboardDefault=%strPowerHotkeyKeyboardDefault%
			DisplayTrayTip=1
			DisplayIcons=1
			RecentFolders=10
			DisplayMenuShortcuts=0
			PopupMenuPosition=1
			PopupFixPosition=20,20
			HotkeyReminders=3
			DiagMode=0
			Startups=1
			LanguageCode=%g_strLanguageCode%
			DirectoryOpusPath=
			IconSize=%g_intIconSize%
			OpenMenuOnTaskbar=1
			AvailableThemes=Windows|Grey|Light Blue|Light Green|Light Red|Yellow
			Theme=Windows
			[Favorites]
			Favorite1=Folder|C:\|C:\
			Favorite2=Folder|Windows|%A_WinDir%
			Favorite3=Folder|Program Files|%A_ProgramFiles%
			Favorite4=Folder|User Profile|`%USERPROFILE`%
			Favorite5=Application|Notepad|%A_WinDir%\system32\notepad.exe
			Favorite6=URL|%g_strAppNameText% web site|http://www.QuickAccessPopup.com
			Favorite7=Z
			[LocationHotkeys]
			Hotkey1={Settings}|+^S
			Hotkey2={Current Folders}|+^F
			Hotkey3={Recent Folders}|+^R
			Hotkey4={Clipboard}|+^C
			[Gui-Grey]
			WindowColor=E0E0E0
			TextColor=000000
			ListviewBackground=FFFFFF
			ListviewText=000000
			MenuBackgroundColor=FFFFFF
			[Gui-Yellow]
			WindowColor=f9ffc6
			TextColor=000000
			ListviewBackground=fcffe0
			ListviewText=000000
			MenuBackgroundColor=fcffe0
			[Gui-Light Blue]
			WindowColor=e8e7fa
			TextColor=000000
			ListviewBackground=e7f0fa
			ListviewText=000000
			MenuBackgroundColor=e7f0fa
			[Gui-Light Red]
			WindowColor=fddcd7
			TextColor=000000
			ListviewBackground=fef1ef
			ListviewText=000000
			MenuBackgroundColor=fef1ef
			[Gui-Light Green]
			WindowColor=d6fbde
			TextColor=000000
			ListviewBackground=edfdf1
			ListviewText=000000
			MenuBackgroundColor=edfdf1

)
		, %g_strIniFile%
}

Gosub, LoadIniPopupHotkeys

; ---------------------
; Load Options Tab 1 General

IniRead, g_blnDisplayTrayTip, %g_strIniFile%, Global, DisplayTrayTip, 1
IniRead, g_blnCheck4Update, %g_strIniFile%, Global, Check4Update, 1
IniRead, g_blnRememberSettingsPosition, %g_strIniFile%, Global, RememberSettingsPosition, 1
IniRead, g_intRecentFoldersMax, %g_strIniFile%, Global, RecentFoldersMax, 10

IniRead, g_intPopupMenuPosition, %g_strIniFile%, Global, PopupMenuPosition, 1
IniRead, strPopupFixPosition, %g_strIniFile%, Global, PopupFixPosition, 20,20
StringSplit, g_arrPopupFixPosition, strPopupFixPosition, `,
IniRead, g_intHotkeyReminders, %g_strIniFile%, Global, HotkeyReminders, 3
IniRead, g_blnDisplayNumericShortcuts, %g_strIniFile%, Global, DisplayMenuShortcuts, 0
IniRead, g_blnOpenMenuOnTaskbar, %g_strIniFile%, Global, OpenMenuOnTaskbar, 1
IniRead, g_blnDisplayIcons, %g_strIniFile%, Global, DisplayIcons, 1
g_blnDisplayIcons := (g_blnDisplayIcons and OSVersionIsWorkstation())
IniRead, g_intIconSize, %g_strIniFile%, Global, IconSize, 32

; ---------------------
; Load Options Tab 2 Menu Hotkeys

IniRead, g_blnChangeFolderInDialog, %g_strIniFile%, Global, ChangeFolderInDialog, 0
if (g_blnChangeFolderInDialog)
	IniRead, g_blnChangeFolderInDialog, %g_strIniFile%, Global, UnderstandChangeFoldersInDialogRisk, 0

IniRead, g_strTheme, %g_strIniFile%, Global, Theme, Windows
IniRead, g_strAvailableThemes, %g_strIniFile%, Global, AvailableThemes
g_blnUseColors := (g_strTheme <> "Windows")
	
; ---------------------
; Load Options Tab 3 Power Menu

; ---------------------
; Options Tab 4 Exclusion List

IniRead, g_strExclusionMouseClassList, %g_strIniFile%, Global, ExclusionMouseClassList, %A_Space% ; empty string if not found
IniRead, g_strExclusionKeyboardClassList, %g_strIniFile%, Global, ExclusionKeyboardClassList, %A_Space% ; empty string if not found

; ---------------------
; Load Options Tab 5 File Managers

IniRead, g_intActiveFileManager, %g_strIniFile%, Global, ActiveFileManager ; if not exist returns "ERROR"

if (g_intActiveFileManager = "ERROR") ; no selection
	Gosub, CheckActiveFileManager

; Read values for all options: if user switch back to a previou option we can preset previous values
IniRead, g_strQAPconnectFileManager, %g_strIniFile%, Global, QAPconnectFileManager, %A_Space% ; empty string if not found
Gosub, LoadIniQAPconnectValues

IniRead, g_strDirectoryOpusPath, %g_strIniFile%, Global, DirectoryOpusPath, %A_Space% ; empty string if not found
IniRead, g_blnDirectoryOpusUseTabs, %g_strIniFile%, Global, DirectoryOpusUseTabs, 1 ; use tabs by default
IniRead, g_strTotalCommanderPath, %g_strIniFile%, Global, TotalCommanderPath, %A_Space% ; empty string if not found
IniRead, g_blnTotalCommanderUseTabs, %g_strIniFile%, Global, TotalCommanderUseTabs, 1 ; use tabs by default

strActiveFileManagerSystemName := g_arrActiveFileManagerSystemNames%g_intActiveFileManager%
if (g_intActiveFileManager = 4) ; QAPconnect connected File Manager
{
	blnActiveFileManangerOK := StrLen(g_strQAPconnectAppPath)
	if (blnActiveFileManangerOK)
		blnActiveFileManangerOK := FileExist(g_strQAPconnectAppPath)
}
else if (g_intActiveFileManager > 1) ; 2 DirectoryOpus or 3 TotalCommander
{
	blnActiveFileManangerOK := StrLen(g_str%strActiveFileManagerSystemName%Path)
	if (blnActiveFileManangerOK) 
		blnActiveFileManangerOK := FileExist(g_str%strActiveFileManagerSystemName%Path)
}
if (g_intActiveFileManager > 1) ; 2 DirectoryOpus, 3 TotalCommander or 4 QAPconnect
	if (blnActiveFileManangerOK)
		Gosub, SetActiveFileManager
	else
	{
		if (g_intActiveFileManager = 4) ; QAPconnect
			Oops(lOopsWrongThirdPartyPathQAPconnect, g_strQAPconnectFileManager, g_strQAPconnectAppPath, "QAPconnect.ini", L(lMenuEditIniFile, "QAPconnect.ini"), lOptionsThirdParty)
		else ; 2 DirectoryOpus or 3 TotalCommander
			Oops(lOopsWrongThirdPartyPath, g_arrActiveFileManagerDisplayNames%g_intActiveFileManager%, g_str%strActiveFileManagerSystemName%Path, lOptionsThirdParty)
		g_intActiveFileManager := 1 ; must be after previous line
	}

; ---------------------
; Load internal flags

IniRead, g_blnDiagMode, %g_strIniFile%, Global, DiagMode, 0
IniRead, g_blnDonor, %g_strIniFile%, Global, Donor, 0 ; Please, be fair. Don't cheat with this.

IniRead, blnDefaultMenuBuilt, %g_strIniFile%, Global, DefaultMenuBuilt, 0 ; default false
if !(blnDefaultMenuBuilt)
 	Gosub, AddToIniDefaultMenu ; modify the ini file Favorites section before reading it

; ---------------------
; Load favorites

IfNotExist, %g_strIniFile%
{
	Oops(lOopsWriteProtectedError, g_strAppNameText)
	ExitApp
}
else
{
	g_intIniLine := 1
	
	if (RecursiveLoadMenuFromIni(g_objMainMenu) <> "EOM") ; build menu tree
		Oops("An error occurred while reading the favorites in the ini file.")
}

strIniBackupFile := ""
arrMainMenu := ""
strNavigateOrLaunchHotkeyMouseDefault := ""
strNavigateOrLaunchHotkeyKeyboard := ""
strPowerHotkeyMouseDefault := ""
strPowerHotkeyKeyboardDefault := ""
strPopupFixPosition := ""
blnDefaultMenuBuilt := ""
blnMyQAPFeaturesBuilt := ""
strLoadIniLine := ""
arrThisFavorite := ""
objLoadIniFavorite := ""
arrSubMenu := ""
g_intIniLine := ""
blnActiveFileManangerOK := ""
strActiveFileManagerSystemName := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveLoadMenuFromIni(objCurrentMenu)
;------------------------------------------------------------
{
	global g_objMenusIndex
	global g_strIniFile
	global g_intIniLine
	global g_strMenuPathSeparator
	global g_strGroupIndicatorPrefix
	global g_strGroupIndicatorSuffix
	global g_strEscapePipe
	global g_objQAPfeaturesInMenus
	global g_objQAPFeaturesDefaultNameByCode
	
	g_objMenusIndex.Insert(objCurrentMenu.MenuPath, objCurrentMenu) ; update the menu index
	intMenuItemPos := 0

	Loop
	{
		IniRead, strLoadIniLine, %g_strIniFile%, Favorites, Favorite%g_intIniLine%
        g_intIniLine++

		if (strLoadIniLine = "ERROR")
			Return, "EOF" ; end of file - should not happen if main menu ends with a "Z" type favorite as expected
		
		strLoadIniLine := strLoadIniLine . "||||||||" ; additional "|" to make sure we have all empty items
		; 1 FavoriteType, 2 FavoriteName, 3 FavoriteLocation, 4 FavoriteIconResource, 5 FavoriteArguments, 6 FavoriteAppWorkingDir,
		; 7 FavoriteWindowPosition, (X FavoriteHotkey), 8 FavoriteLaunchWith, 9 FavoriteLoginName, 10 FavoritePassword,
		; 11 FavoriteGroupSettings, 12 FavoriteFtpEncoding
		StringSplit, arrThisFavorite, strLoadIniLine, |

		if (arrThisFavorite1 = "Z")
			return, "EOM" ; end of menu
		
		objLoadIniFavorite := Object() ; new favorite item
		
		if InStr("Menu|Group", arrThisFavorite1) ; begin a submenu
		{
			objNewMenu := Object() ; create the submenu object
			objNewMenu.MenuPath := objCurrentMenu.MenuPath . " " . g_strMenuPathSeparator . " " . arrThisFavorite2 . (arrThisFavorite1 = "Group" ? " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix : "")
			objNewMenu.MenuType := arrThisFavorite1
			
			; create a navigation entry to navigate to the parent menu
			objNewMenuBack := Object()
			objNewMenuBack.FavoriteType := "B" ; for Back link to parent menu
			objNewMenuBack.FavoriteName := "(" . GetDeepestMenuPath(objCurrentMenu.MenuPath) . ")"
			objNewMenuBack.SubMenu := objCurrentMenu ; this is the link to the parent menu
			objNewMenu.Insert(objNewMenuBack)
			
			; build the submenu
			strResult := RecursiveLoadMenuFromIni(objNewMenu) ; RECURSIVE
			
			if (strResult = "EOF") ; end of file was encountered while building this submenu, exit recursive function
				Return, %strResult%
		}
		
		if (arrThisFavorite1 = "QAP")
		{
			; get QAP feature's name in current language (QAP features names are not saved to ini file)
			arrThisFavorite2 := g_objQAPFeaturesDefaultNameByCode[arrThisFavorite3]
			
			; to keep track of QAP features in menus to allow enable/disable menu items
			g_objQAPfeaturesInMenus.Insert(arrThisFavorite3, 1) ; boolean just to flag that we have this QAP feature in menus
			/*
			if g_objQAPfeaturesInMenus.HasKey(arrThisFavorite3) ; QAP feature already in object
				g_objQAPfeaturesInMenus[arrThisFavorite3] .= objCurrentMenu.MenuPath . g_strSeparatorQAPMenuPath . intMenuItemPos . "|"
			else
				g_objQAPfeaturesInMenus.Insert(arrThisFavorite3, objCurrentMenu.MenuPath . g_strSeparatorQAPMenuPath . intMenuItemPos . "|") ; add it with menu path
			*/
		}

		; this is a regular favorite, add it to the current menu
		objLoadIniFavorite.FavoriteType := arrThisFavorite1 ; see Favorite Types
		objLoadIniFavorite.FavoriteName := ReplaceAllInString(arrThisFavorite2, g_strEscapePipe, "|") ; display name of this menu item
		objLoadIniFavorite.FavoriteLocation := ReplaceAllInString(arrThisFavorite3, g_strEscapePipe, "|") ; path, URL or menu path (without "Main") for this menu item
		objLoadIniFavorite.FavoriteIconResource := arrThisFavorite4 ; icon resource in format "iconfile,iconindex"
		objLoadIniFavorite.FavoriteArguments := ReplaceAllInString(arrThisFavorite5, g_strEscapePipe, "|") ; application arguments
		objLoadIniFavorite.FavoriteAppWorkingDir := arrThisFavorite6 ; application working directory
		objLoadIniFavorite.FavoriteWindowPosition := arrThisFavorite7 ; Boolean,Left,Top,Width,Height,Delay,RestoreSide (comma delimited)
		objLoadIniFavorite.FavoriteLaunchWith := arrThisFavorite8 ; launch favorite with this executable
		objLoadIniFavorite.FavoriteLoginName := ReplaceAllInString(arrThisFavorite9, g_strEscapePipe, "|") ; login name for FTP favorite
		objLoadIniFavorite.FavoritePassword := ReplaceAllInString(arrThisFavorite10, g_strEscapePipe, "|") ; password for FTP favorite
		objLoadIniFavorite.FavoriteGroupSettings := arrThisFavorite11 ; coma separated values for group restore settings
		objLoadIniFavorite.FavoriteFtpEncoding := arrThisFavorite12 ; encoding of FTP username and password, 0 do not encode, 1 encode
		
		; this is a submenu favorite, link to the submenu object
		if InStr("Menu|Group", arrThisFavorite1)
			objLoadIniFavorite.SubMenu := objNewMenu
		
		; update the current menu object
		objCurrentMenu.Insert(objLoadIniFavorite)
		
		if !InStr("X|K", objLoadIniFavorite.FavoriteType) ; menu separators and column breaks do not use a item position numeric shortcut number
			intMenuItemPos++
	}
}
;-----------------------------------------------------------


;------------------------------------------------------------
AddToIniDefaultMenu:
;------------------------------------------------------------

strThisMenuName := lMenuMySpecialMenu
Gosub, AddToIniGetMenuName ; find next favorite number in ini file and check if Special menu name exists
g_intNextFavoriteNumber -= 1 ; minus one to overwrite the existing end of main menu marker

AddToIniOneDefaultMenu("", "", "X")
AddToIniOneDefaultMenu(g_strMenuPathSeparator . " " . strDefaultMenu, strDefaultMenu, "Menu")
AddToIniOneDefaultMenu(A_Desktop, lMenuDesktop, "Special") ; Desktop
AddToIniOneDefaultMenu("{450D8FBA-AD25-11D0-98A8-0800361B1103}", "", "Special") ; Documents
AddToIniOneDefaultMenu(g_strMyPicturesPath, "", "Special") ; Pictures
AddToIniOneDefaultMenu(g_strDownloadPath, "", "Special") ; Downloads
AddToIniOneDefaultMenu("", "", "X")
AddToIniOneDefaultMenu("{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "", "Special") ; Computer
AddToIniOneDefaultMenu("{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}", "", "Special") ; Network
AddToIniOneDefaultMenu("", "", "X")
AddToIniOneDefaultMenu("{21EC2020-3AEA-1069-A2DD-08002B30309D}", "", "Special") ; Control Panel
AddToIniOneDefaultMenu("{645FF040-5081-101B-9F08-00AA002F954E}", "", "Special") ; Recycle Bin
AddToIniOneDefaultMenu("", "", "Z") ; close special menu

strThisMenuName := lMenuMyQAPMenu
Gosub, AddToIniGetMenuName ; find next favorite number in ini file and check if QAP menu name exists

AddToIniOneDefaultMenu(g_strMenuPathSeparator . " " . strDefaultMenu, strDefaultMenu, "Menu")
AddToIniOneDefaultMenu("{Add This Folder}", lMenuAddThisFolder . "...", "QAP")
AddToIniOneDefaultMenu("", "", "X")
AddToIniOneDefaultMenu("{Current Folders}", lMenuCurrentFolders . "...", "QAP")
AddToIniOneDefaultMenu("{Recent Folders}", lMenuRecentFolders . "...", "QAP")
AddToIniOneDefaultMenu("", "", "X")
AddToIniOneDefaultMenu("{Clipboard}", lMenuClipboard . "...", "QAP")
AddToIniOneDefaultMenu("", "", "Z") ; close QAP menu

strThisMenuName := lMenuSettings . "..."
Gosub, AddToIniGetMenuName ; find next favorite number in ini file and check if QAP menu name exists
if (strThisMenuName = lMenuSettings . "...") ; if equal, it means that this menu is not already there
	; (we cannot have this menu twice with "+" because QAP features always have the same menu name)
	AddToIniOneDefaultMenu("{Settings}", lMenuSettings . "...", "QAP") ; back in main menu

AddToIniOneDefaultMenu("", "", "Z") ; restore end of main menu marker

IniWrite, 1, %g_strIniFile%, Global, DefaultMenuBuilt

g_intNextFavoriteNumber := ""
strThisMenuName := ""
strDefaultMenu := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
AddToIniGetMenuName:
;------------------------------------------------------------

strInstance := ""

Loop
{
	IniRead, strIniLine, %g_strIniFile%, Favorites, Favorite%A_Index%
	if InStr(strIniLine, strThisMenuName . strInstance)
		strInstance .= "+"
	if (strIniLine = "ERROR")
	{
		g_intNextFavoriteNumber := A_Index
		Break
	}
}
strDefaultMenu := strThisMenuName . strInstance

strInstance := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
AddToIniOneDefaultMenu(strLocation, strName, strFavoriteType)
;------------------------------------------------------------
{
	global g_strIniFile
	global g_objIconsFile
	global g_objIconsIndex
	global g_objSpecialFolders
	global g_objQAPFeatures
	global g_intNextFavoriteNumber
	
	if (strFavoriteType = "Z")
		strNewIniLine := strFavoriteType
	else
	{
		if (strFavoriteType = "Menu")
			strIconResource := g_objIconsFile["iconSpecialFolders"] . "," . g_objIconsIndex["iconSpecialFolders"]
		else if (strFavoriteType = "Special")
			strIconResource := g_objSpecialFolders[strLocation].DefaultIcon
		else
			strIconResource := g_objQAPFeatures[strLocation].DefaultIcon

		if !StrLen(strName)
			if (strFavoriteType = "Special")
				strName := g_objSpecialFolders[strLocation].DefaultName
			else
				strName := g_objQAPFeatures[strLocation].DefaultName
		
		strNewIniLine := strFavoriteType . "|" . strName . "|" . strLocation . "|" . strIconResource . "||||||||"
	}
	
	IniWrite, %strNewIniLine%, %g_strIniFile%, Favorites, Favorite%g_intNextFavoriteNumber%
	g_intNextFavoriteNumber++
}
;------------------------------------------------------------


;-----------------------------------------------------------
LoadIniPopupHotkeys:
;-----------------------------------------------------------

; Read the values and set hotkey shortcuts
loop, % g_arrPopupHotkeyNames%0%
; NavigateOrLaunchHotkeyMouse|NavigateOrLaunchHotkeyKeyboard|PowerHotkeyMouse|PowerHotkeyKeyboard
{
	; Prepare global arrays used by SplitHotkey function
	IniRead, g_arrPopupHotkeys%A_Index%, %g_strIniFile%, Global, % g_arrPopupHotkeyNames%A_Index%, % g_arrPopupHotkeyDefaults%A_Index%
	SplitHotkey(g_arrPopupHotkeys%A_Index%, strModifiers%A_Index%, strOptionsKey%A_Index%, strMouseButton%A_Index%, strMouseButtonsWithDefault%A_Index%)
}

; First, if we can, navigate with QAP hotkeys (1 NavigateOrLaunchHotkeyMouse and 2 NavigateOrLaunchHotkeyKeyboard) 
Hotkey, If, CanNavigate(A_ThisHotkey)
	if HasHotkey(g_arrPopupHotkeysPrevious1)
		Hotkey, % g_arrPopupHotkeysPrevious1, , Off
	if HasHotkey(g_arrPopupHotkeys1)
		Hotkey, % g_arrPopupHotkeys1, NavigateHotkeyMouse, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, g_arrPopupHotkeys1, g_arrOptionsTitles1)
	if HasHotkey(g_arrPopupHotkeysPrevious2)
		Hotkey, % g_arrPopupHotkeysPrevious2, , Off
	if HasHotkey(g_arrPopupHotkeys2)
		Hotkey, % g_arrPopupHotkeys2, NavigateHotkeyKeyboard, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, g_arrPopupHotkeys2, g_arrOptionsTitles2)
Hotkey, If

; Second, if we can't navigate but can launch, launch with QAP hotkey s(1 NavigateOrLaunchHotkeyMouse and 2 NavigateOrLaunchHotkeyKeyboard) 
Hotkey, If, CanLaunch(A_ThisHotkey)
	if HasHotkey(g_arrPopupHotkeysPrevious1)
		Hotkey, % g_arrPopupHotkeysPrevious1, , Off
	if HasHotkey(g_arrPopupHotkeys1)
		Hotkey, % g_arrPopupHotkeys1, LaunchHotkeyMouse, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, g_arrPopupHotkeys1, g_arrOptionsTitles1)
	if HasHotkey(g_arrPopupHotkeysPrevious2)
		Hotkey, % g_arrPopupHotkeysPrevious2, , Off
	if HasHotkey(g_arrPopupHotkeys2)
		Hotkey, % g_arrPopupHotkeys2, LaunchHotkeyKeyboard, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, g_arrPopupHotkeys2, g_arrOptionsTitles2)
Hotkey, If

; Then, if QAP hotkey cannot be activated, open the Power menu with the Power hotkeys (3 PowerHotkeyMouse and 4 PowerHotkeyKeyboard)
if HasHotkey(g_arrPopupHotkeysPrevious3)
	Hotkey, % g_arrPopupHotkeysPrevious3, , Off
if HasHotkey(g_arrPopupHotkeys3)
	Hotkey, % g_arrPopupHotkeys3, PowerHotkeyMouse, On UseErrorLevel
if (ErrorLevel)
	Oops(lDialogInvalidHotkey, g_arrPopupHotkeys3, g_arrOptionsTitles3)
if HasHotkey(g_arrPopupHotkeysPrevious4)
	Hotkey, % g_arrPopupHotkeysPrevious4, , Off
if HasHotkey(g_arrPopupHotkeys4)
	Hotkey, % g_arrPopupHotkeys4, PowerHotkeyKeyboard, On UseErrorLevel
if (ErrorLevel)
	Oops(lDialogInvalidHotkey, g_arrPopupHotkeys4, g_arrOptionsTitles4)

; Load location hotkeys
Loop
{
	IniRead, strLocationHotkey, %g_strIniFile%, LocationHotkeys, Hotkey%A_Index%
	if (strLocationHotkey = "ERROR")
		break
	StringSplit, arrLocationHotkey, strLocationHotkey, |
	g_objHotkeysByLocation.Insert(arrLocationHotkey1, arrLocationHotkey2)
}

; Turn off previous QAP Power Menu features hotkeys
for strCode, objThisQAPFeature in g_objQAPFeatures
	if HasHotkey(objThisQAPFeature.CurrentHotkey)
		Hotkey, % objThisQAPFeature.CurrentHotkey, , Off
	
; Load QAP Power Menu hotkeys
for intOrder, strCode in g_objQAPFeaturesPowerCodeByOrder
{
	IniRead, strHotkey,  %g_strIniFile%, PowerMenuHotkeys, %strCode%
	if (strHotkey <> "ERROR")
	{
		Hotkey, %strHotkey%, OpenPowerMenuHotkey, On UseErrorLevel
		g_objQAPFeatures[strCode].CurrentHotkey := strHotkey
	}
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, strHotkey, g_objQAPFeatures[strCode].LocalizedName)
}

strCode := ""
objThisQAPFeature := ""
strHotkey := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
InitDiagMode:
;------------------------------------------------------------

MsgBox, 52, %g_strAppNameText%, % L(lDiagModeCaution, g_strAppNameText, g_strDiagFile)
IfMsgBox, No
{
	g_blnDiagMode := False
	IniWrite, 0, %g_strIniFile%, Global, DiagMode
	return
}
	
if !FileExist(g_strDiagFile)
{
	FileAppend, DateTime`tType`tData`n, %g_strDiagFile%
	Diag("DIAGNOSTIC FILE", lDiagModeIntro)
	Diag("AppNameFile", g_strAppNameFile)
	Diag("AppNameText", g_strAppNameText)
	Diag("AppVersion", g_strAppVersion)
	Diag("A_ScriptFullPath", A_ScriptFullPath)
	Diag("A_WorkingDir", A_WorkingDir)
	Diag("A_AhkVersion", A_AhkVersion)
	Diag("A_OSVersion", A_OSVersion)
	Diag("A_Is64bitOS", A_Is64bitOS)
	Diag("A_Language", A_Language)
	Diag("A_IsAdmin", A_IsAdmin)
}

FileRead, strIniFileContent, %g_strIniFile%
StringReplace, strIniFileContent, strIniFileContent, `", `"`"
Diag("IniFile", """" . strIniFileContent . """")
FileAppend, `n, %g_strDiagFile% ; required when the last line of the existing file ends with "

strIniFileContent := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
LoadThemeGlobal:
;------------------------------------------------------------

IniRead, g_strGuiWindowColor, %g_strIniFile%, Gui-%g_strTheme%, WindowColor, E0E0E0
IniRead, g_strMenuBackgroundColor, %g_strIniFile%, Gui-%g_strTheme%, MenuBackgroundColor, FFFFFF

return
;------------------------------------------------------------


;========================================================================================================================
; END OF INITIALIZATION
;========================================================================================================================


;========================================================================================================================
!_017_EXIT:
;========================================================================================================================

;-----------------------------------------------------------
ExitApp:
TrayMenuExitApp:
;-----------------------------------------------------------

ExitApp
;-----------------------------------------------------------


;-----------------------------------------------------------
CleanUpBeforeExit:
;-----------------------------------------------------------

strSettingsPosition := "-1" ; center at minimal size
if (g_blnRememberSettingsPosition)
{
	WinGet, intMinMax, MinMax, ahk_id %g_strAppHwnd%
	if (intMinMax <> 1) ; if window is maximized, we keep the default positionand size (center at minimal size)
	{
		WinGetPos, intX, intY, intW, intH, ahk_id %g_strAppHwnd%
		strSettingsPosition := intX . "|" . intY . "|" . intW . "|" . intH
	}
}
IniWrite, %strSettingsPosition%, %g_strIniFile%, Global, SettingsPosition

FileRemoveDir, %g_strTempDir%, 1 ; Remove all files and subdirectories

if (g_blnDiagMode)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDiagModeExit, g_strAppNameText, g_strDiagFile) . "`n`n" . lDiagModeIntro . "`n`n" . lDiagModeSee
	IfMsgBox, Yes
		Run, %g_strDiagFile%
}

strSettingsPosition := ""
intMinMax := ""
intX := ""
intY := ""
intW := ""
intH := ""

ExitApp
;-----------------------------------------------------------


;========================================================================================================================
; END OF EXIT
;========================================================================================================================



;========================================================================================================================
!_020_BUILD:
;========================================================================================================================

;------------------------------------------------------------
BuildTrayMenu:
;------------------------------------------------------------

Menu, Tray, Icon, , , 1 ; last 1 to freeze icon during pause or suspend
Menu, Tray, NoStandard
;@Ahk2Exe-IgnoreBegin
; Start of code for developement phase only - won't be compiled
Menu, Tray, Icon, %A_ScriptDir%\qap-white-rounded-512.ico, 1, 1 ; last 1 to freeze icon during pause or suspend
Menu, Tray, Standard
Menu, Tray, Add
; / End of code for developement phase only - won't be compiled
;@Ahk2Exe-IgnoreEnd
; Menu, Tray, Add, % L(lMenuFPMenu, g_strAppNameText, lMenuMenu), :%lMainMenuName% ; REMOVED seems to cause a BUG in submenu display (first display only) - unexplained...
Menu, Tray, Add, % lMenuSettings . "...", GuiShow
Menu, Tray, Add, % L(lMenuEditIniFile, g_strAppNameFile . ".ini"), ShowSettingsIniFile
Menu, Tray, Add, % L(lMenuEditIniFile, "QAPconnect.ini"), ShowQAPconnectIniFile
Menu, Tray, Add
Menu, Tray, Add, %lMenuRunAtStartup%, RunAtStartup
Menu, Tray, Add, %lMenuSuspendHotkeys%, SuspendHotkeys
Menu, Tray, Add
Menu, Tray, Add, %lMenuUpdate%, Check4Update
Menu, Tray, Add, %lMenuHelp%, GuiHelp
Menu, Tray, Add, %lMenuAbout%, GuiAbout
Menu, Tray, Add, %lDonateMenu%, GuiDonate
Menu, Tray, Add
Menu, Tray, Add, % L(lMenuExitApp, g_strAppNameText), TrayMenuExitApp
Menu, Tray, Default, % lMenuSettings . "..."
if (g_blnUseColors)
	Menu, Tray, Color, %g_strMenuBackgroundColor%
Menu, Tray, Tip, % g_strAppNameText . " " . g_strAppVersion . " (" . (A_PtrSize * 8) . "-bit)`n" . (g_blnDonor ? lDonateThankyou : lDonateButton) ; A_PtrSize * 8 = 32 or 64

return
;------------------------------------------------------------


;------------------------------------------------------------
CurrentFoldersMenuShortcut:
;------------------------------------------------------------

Gosub, SetMenuPosition

Gosub, BuildCurrentFoldersMenu

CoordMode, Menu, % (g_intPopupMenuPosition = 2 ? "Window" : "Screen")
Menu, g_menuCurrentFolders, Show, %g_intMenuPosX%, %g_intMenuPosY%

return
;------------------------------------------------------------


;------------------------------------------------------------
InitDOpusListText:
;------------------------------------------------------------

FileDelete, %g_strDOpusTempFilePath%
RunDOpusRt("/info", g_strDOpusTempFilePath, ",paths") ; list opened listers in a text file
; Run, "%strDirectoryOpusRtPath%" /info "%g_strDOpusTempFilePath%"`,paths
loop, 10
	if FileExist(g_strDOpusTempFilePath)
		Break
	else
		Sleep, 50 ; was 10 and had some gliches with FP - is 50 enough?
FileRead, g_strDOpusListText, %g_strDOpusTempFilePath%

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildCurrentFoldersMenuInit:
BuildCurrentFoldersMenu:
;------------------------------------------------------------

Menu, g_menuCurrentFolders, Add ; create the menu

if (A_ThisLabel = "BuildCurrentFoldersMenuInit")
	return

if (g_intActiveFileManager = 2) ; DirectoryOpus
{
	Gosub, InitDOpusListText
	objDOpusListers := CollectDOpusListersList(g_strDOpusListText) ; list all listers, excluding special folders like Recycle Bin
}

objExplorersWindows := CollectExplorers(ComObjCreate("Shell.Application").Windows)

objCurrentFoldersList := Object()

intExplorersIndex := 0 ; used in PopupMenu and SaveGroup to check if we disable menu or button when empty

if (g_intActiveFileManager = 2) ; DirectoryOpus
	for intIndex, objLister in objDOpusListers
	{
		; if we have no path or or DOpus collection, skip it
		if !StrLen(objLister.LocationURL) or InStr(objLister.LocationURL, "coll://")
			continue
		
		if NameIsInObject(objLister.Name, objCurrentFoldersList)
			continue
		
		intExplorersIndex++
			
		objCurrentFolder := Object()
		objCurrentFolder.LocationURL := objLister.LocationURL
		objCurrentFolder.Name := objLister.Name
		
		; used for DOpus windows to discriminatre different listers
		objCurrentFolder.WindowId := objLister.Lister
		
		; info used to create groups
		objCurrentFolder.TabId := objLister.Tab
		objCurrentFolder.Position := objLister.Position
		objCurrentFolder.MinMax := objLister.MinMax
		objCurrentFolder.Pane := (objLister.Pane = 0 ? 1 : objLister.Pane) ; consider pane 0 as pane 1
		objCurrentFolder.WindowType := "DO"
		
		objCurrentFoldersList.Insert(intExplorersIndex, objCurrentFolder)
	}

for intIndex, objFolder in objExplorersWindows
{
	; if we have no path, skip it
	if !StrLen(objFolder.LocationURL)
		continue
		
	if NameIsInObject(objFolder.LocationName, objCurrentFoldersList)
		continue
	
	intExplorersIndex++
	
	objCurrentFolder := Object()
	objCurrentFolder.LocationURL := objFolder.LocationURL
	objCurrentFolder.Name := objFolder.LocationName
	objCurrentFolder.IsSpecialFolder := objFolder.IsSpecialFolder
	
	; not used for Explorer windows, but keep it
	objCurrentFolder.WindowId := objFolder.WindowId

	; info used to create groups
	objCurrentFolder.Position := objFolder.Position
	objCurrentFolder.MinMax := objFolder.MinMax
	objCurrentFolder.WindowType := "EX"

	objCurrentFoldersList.Insert(intExplorersIndex, objCurrentFolder)
}

; ##### Clipboard bug doe not occur if following 4 lines are commented - but this break the Current folders menu...
Menu, g_menuCurrentFolders, Add
Menu, g_menuCurrentFolders, DeleteAll
if (g_blnUseColors)
	Menu, g_menuCurrentFolders, Color, %g_strMenuBackgroundColor%

intShortcutCurrentFolders := 0
g_objCurrentFoldersLocationUrlByName := Object()

if (intExplorersIndex)
	for intIndex, objCurrentFolder in objCurrentFoldersList
	{
		strMenuName := (g_blnDisplayNumericShortcuts and (intShortcutCurrentFolders <= 35) ? "&" . NextMenuShortcut(intShortcutCurrentFolders) . " " : "") . objCurrentFolder.Name
		g_objCurrentFoldersLocationUrlByName.Insert(strMenuName, objCurrentFolder.LocationURL) ; can include the numeric shortcut
		AddMenuIcon("g_menuCurrentFolders", strMenuName, "OpenCurrentFolder", "iconFolder")
	}
else
	AddMenuIcon("g_menuCurrentFolders", lMenuNoCurrentFolder, "GuiShow", "iconNoContent", false) ; will never be called because disabled

objDOpusListers := ""
objExplorersWindows := ""
objCurrentFolder := ""
objCurrentFoldersList := ""
intIndex := ""
objLister := ""
objFolder := ""
intShortcutCurrentFolders := ""
strMenuName := ""
intExplorersIndex := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
CollectDOpusListersList(strList)
; list all DirectoryOpus listers, excluding special folders like Recycle Bin, Network because they are not included in dopus-list.txt
;------------------------------------------------------------
{
	objListers := Object()
	
	strList := SubStr(strList, InStr(strList, "<path"))
	Loop
	{
		objLister := Object()
		
		strList := SubStr(strList, InStr(strList, "<path"))
		strSubStr := SubStr(strList, InStr(strList, "<path"))
		strSubStr := SubStr(strSubStr, 1, InStr(strSubStr, "</path>") - 1)
		
		if (StrLen(strSubStr))
		{
			objLister.Active_lister := ParseDOpusListerProperty(strSubStr, "active_lister")
			objLister.Active_tab := ParseDOpusListerProperty(strSubStr, "active_tab")
			objLister.Lister := ParseDOpusListerProperty(strSubStr, "lister")
			objLister.Side := ParseDOpusListerProperty(strSubStr, "side")
			objLister.Tab := ParseDOpusListerProperty(strSubStr, "tab")
			objLister.Tab_state := ParseDOpusListerProperty(strSubStr, "tab_state")
			objLister.LocationURL := SubStr(strSubStr, InStr(strSubStr, ">") + 1)
			
			objLister.Name := ComUnHTML(objLister.LocationURL) ; convert HTML entities to text (like "&apos;")

			WinGetPos, intX, intY, intW, intH, % "ahk_id " . objLister.lister
			objLister.Position := intX . "|" . intY . "|" . intW . "|" . intH
			WinGet, intMinMax, MinMax, % "ahk_id " . objLister.lister
			objLister.MinMax := intMinMax
			objLister.Pane := objLister.Side
			
			; if !InStr(objLister.LocationURL, "ftp://") - removed in v6.0.6 - FTP from DOpus now supported
				; Swith Explorer to DOpus FTP folder not supported (see https://github.com/JnLlnd/FoldersPopup/issues/84)
				
			objListers.Insert(A_Index, objLister)
				
			strList := SubStr(strList, StrLen(strSubStr))
		}
	} until	(!StrLen(strSubStr))

	return objListers
}
;------------------------------------------------------------


;------------------------------------------------------------
ParseDOpusListerProperty(strSource, strProperty)
;------------------------------------------------------------
{
	intStartPos := InStr(strSource, " " . strProperty . "=")
	if !(intStartPos)
		return ""
	strSource := SubStr(strSource, intStartPos + StrLen(strProperty) + 3)
	intEndPos := InStr(strSource, """")
	return SubStr(strSource, 1, intEndPos - 1)
}
;------------------------------------------------------------


;------------------------------------------------------------
CollectExplorers(pExplorers)
;------------------------------------------------------------
{
	objExplorers := Object()
	intExplorers := 0
	
	For pExplorer in pExplorers
	; see http://msdn.microsoft.com/en-us/library/windows/desktop/aa752084(v=vs.85).aspx
	{
		/* in v.3.9.8: stop interupting Explorer collection if an error occurs - just check for content and continue
		if (A_LastError)
			; an error occurred during ComObjCreate (A_LastError probably is E_UNEXPECTED = -2147418113 #0x8000FFFFL)
			break
		*/

		strType := ""
		try strType := pExplorer.Type ; Gets the type name of the contained document object. "Document HTML" for IE windows. Should be empty for file Explorer windows.
		strWindowID := ""
		try strWindowID := pExplorer.HWND ; Try to get the handle of the window. Some ghost Explorer in the ComObjCreate may return an empty handle
		
		if !StrLen(strType) ; must be empty
			and StrLen(strWindowID) ; must not be empty
		{
			intExplorers++
			objExplorer := Object()
			objExplorer.Position := pExplorer.Left . "|" . pExplorer.Top . "|" . pExplorer.Width . "|" . pExplorer.Height

			objExplorer.IsSpecialFolder := !StrLen(pExplorer.LocationURL) ; empty for special folders like Recycle bin
			
			if (objExplorer.IsSpecialFolder)
			{
				objExplorer.LocationURL := pExplorer.Document.Folder.Self.Path
				objExplorer.LocationName := pExplorer.LocationName ; see http://msdn.microsoft.com/en-us/library/aa752084#properties
			}
			else
			{
				objExplorer.LocationURL := pExplorer.LocationURL
				strLocationName :=  UriDecode(pExplorer.LocationURL)
				StringReplace, strLocationName, strLocationName, file:///
				StringReplace, strLocationName, strLocationName, /, \, A
				objExplorer.LocationName := strLocationName
			}
			
			objExplorer.WindowId := pExplorer.HWND ; not used for Explorer windows, but keep it
			WinGet, intMinMax, MinMax, % "ahk_id " . pExplorer.HWND
			objExplorer.MinMax := intMinMax
			
			objExplorers.Insert(intExplorers, objExplorer) ; I was checking if StrLen(pExplorer.HWND) - any reason?
		}
	}
	
	return objExplorers
}
;------------------------------------------------------------


;------------------------------------------------------------
RecentFoldersMenuShortcut:
;------------------------------------------------------------

Gosub, SetMenuPosition

ToolTip, %lMenuRefreshRecent%...
Gosub, BuildRecentFoldersMenu
ToolTip

CoordMode, Menu, % (g_intPopupMenuPosition = 2 ? "Window" : "Screen")
Menu, g_menuRecentFolders, Show, %g_intMenuPosX%, %g_intMenuPosY%

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildRecentFoldersMenu:
;------------------------------------------------------------

Menu, g_menuRecentFolders, Add
Menu, g_menuRecentFolders, DeleteAll ; had problem with DeleteAll making the Special menu to disappear 1/2 times - now OK
if (g_blnUseColors)
	Menu, g_menuRecentFolders, Color, %g_strMenuBackgroundColor%

g_objRecentFolders := Object()
g_intRecentFoldersIndex := 0 ; used in PopupMenu... to check if we disable the menu when empty

RegRead, strRecentsFolder, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Recent

/*
; Alternative to collect recent files *** NOT WORKING with XP and SLOWER because all shortcuts are resolved before getting the list
; See: post from Skan http://ahkscript.org/boards/viewtopic.php?f=5&t=4477#p25261
; Implement for Win7+ if FileGetShortcut still produce Windows errors when external drive is not available (despite DllCall in initialization)

strWinPathRecent := RegExReplace(SubStr(strRecentsFolder, 3) . "\", "\\", "\\")
strDirList := ""
for ObjItem in ComObjGet("winmgmts:")
	.ExecQuery("Select * from Win32_ShortcutFile where path = '" . strWinPathRecent . "'")
	strDirList .= ObjItem.LastModified . A_Tab . ObjItem.Extension . A_Tab . ObjItem.Target . "`n"
*/

Loop, %strRecentsFolder%\*.* ; tried to limit to number of recent but they are not sorted chronologically
	strDirList .= A_LoopFileTimeModified . "`t" . A_LoopFileFullPath . "`n"

Sort, strDirList, R

intShortcut := 0

Loop, parse, strDirList, `n
{
	if !StrLen(A_LoopField) ; last line is empty
		continue

	arrShortcutFullPath := StrSplit(A_LoopField, A_Tab)
	strShortcutFullPath := arrShortcutFullPath[2]
	
	FileGetShortcut, %strShortcutFullPath%, strTargetPath
	
	if (errorlevel) ; hidden or system files (like desktop.ini) returns an error
		continue
	if !FileExist(strTargetPath) ; if folder/document was delete or on a removable drive
		continue
	if LocationIsDocument(strTargetPath) ; not a folder
		continue

	g_intRecentFoldersIndex++
	g_objRecentFolders.Insert(g_intRecentFoldersIndex, strTargetPath)
	
	strMenuName := (g_blnDisplayNumericShortcuts and (intShortcut <= 35) ? "&" . NextMenuShortcut(intShortcut) . " " : "") . strTargetPath
	AddMenuIcon("g_menuRecentFolders", strMenuName, "OpenRecentFolder", "iconFolder")

	if (g_intRecentFoldersIndex >= g_intRecentFoldersMax)
		break
}

strRecentsFolder := ""
strDirList := ""
intShortcut := ""
arrShortcutFullPath := ""
strShortcutFullPath := ""
strTargetPath := ""
strMenuName := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ClipboardMenuShortcut:
;------------------------------------------------------------

Gosub, SetMenuPosition

Gosub, RefreshClipboardMenu
CoordMode, Menu, % (g_intPopupMenuPosition = 2 ? "Window" : "Screen")

Menu, g_menuClipboard, Show, %g_intMenuPosX%, %g_intMenuPosY%

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildClipboardMenuInit:
;------------------------------------------------------------

; create the empty menu allowing to be attached to parent menu even if never refreshed

Menu, g_menuClipboard, Add 
Menu, g_menuClipboard, DeleteAll
if (g_blnUseColors)
    Menu, g_menuClipboard, Color, %g_strMenuBackgroundColor%
AddMenuIcon("g_menuClipboard", lMenuNoClipboard, "GuiShow", "iconNoContent", false)	; will never be called because disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
RefreshClipboardMenu:
;------------------------------------------------------------

blnPreviousClipboardMenuDeleted := false
intShortcutClipboardMenu := 0
strURLsInClipboard := ""

; Parse Clipboard for folder, document or application filenames (filenames alone on one line)
Loop, parse, Clipboard, `n, `r%A_Space%%A_Tab%/?:*`"><|
{
    strClipboardLine := A_LoopField
	strClipboardLineExpanded := EnvVars(strClipboardLine) ; only to test if file exist - will not be displayed in menu

	if StrLen(FileExist(strClipboardLineExpanded))
	{
		if !(blnPreviousClipboardMenuDeleted)
		{
			Menu, g_menuClipboard, Add
			Menu, g_menuClipboard, DeleteAll
			blnPreviousClipboardMenuDeleted := true
		}

		strMenuName := (g_blnDisplayNumericShortcuts and (intShortcutCurrentFolders <= 35) ? "&" . NextMenuShortcut(intShortcutClipboardMenu) . " " : "") . strClipboardLine
		if (g_blnDisplayIcons)
		{
			if LocationIsDocument(strClipboardLineExpanded)
			{
				GetIcon4Location(strClipboardLineExpanded, strThisIconFile, intThisIconIndex)
				strIconValue := strThisIconFile . "," . intThisIconIndex
			}
			else
				strIconValue := "iconFolder"
		}
		AddMenuIcon("g_menuClipboard", strMenuName, "OpenClipboard", strIconValue)
	}

	; Parse Clipboard line for URLs (anywhere on the line)
	strURLSearchString := strClipboardLine
	Gosub, GetURLsInClipboardLine
}

Sort, strURLsInClipboard

Loop, parse, strURLsInClipboard, `n
{
	if !StrLen(A_LoopField)
		break
	
	; if we get here, we have at least one URL, check if we need to delete previous menu
	if !(blnPreviousClipboardMenuDeleted)
	{
		Menu, g_menuClipboard, Add
		Menu, g_menuClipboard, DeleteAll
		blnPreviousClipboardMenuDeleted := true
	}

	strMenuName := (g_blnDisplayNumericShortcuts and (intShortcutCurrentFolders <= 35) ? "&" . NextMenuShortcut(intShortcutClipboardMenu) . " " : "") . A_LoopField
	if StrLen(strMenuName) < 260 ; skip too long URLs
	{
		Menu, g_menuClipboard, Add, %strMenuName%, OpenClipboard
		if (blnDisplayIcon)
			Menu, g_menuClipboard, Icon, %strMenuName%, %strThisIconFile%, %intThisIconIndex%, %g_intIconSize%
	}
}

blnPreviousClipboardMenuDeleted := ""
intShortcutClipboardMenu := ""
strURLsInClipboard := ""
strClipboardLine := ""
strClipboardLineExpanded := ""
strURLSearchString := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GetURLsInClipboardLine:
;------------------------------------------------------------
; Adapted from AHK help file: http://ahkscript.org/docs/commands/LoopReadFile.htm
; It's done this particular way because some URLs have other URLs embedded inside them:
StringGetPos, intURLStart1, strURLSearchString, http://
StringGetPos, intURLStart2, strURLSearchString, https://
StringGetPos, intURLStart3, strURLSearchString, www.

; Find the left-most starting position:
intURLStart := intURLStart1 ; Set starting default.
Loop
{
	; It helps performance (at least in a script with many variables) to resolve
	; "intURLStart%A_Index%" only once:
	intArrayElement := intURLStart%A_Index%
	if (intArrayElement = "") ; End of the array has been reached.
		break
	if (intArrayElement = -1) ; This element is disqualified.
		continue
	if (intURLStart = -1)
		intURLStart := intArrayElement
	else ; intURLStart has a valid position in it, so compare it with intArrayElement.
	{
		if (intArrayElement <> -1)
			if (intArrayElement < intURLStart)
				intURLStart := intArrayElement
	}
}

if (intURLStart = -1) ; No URLs exist in strURLSearchString.
	return ; (exit loop without cleaning local variables that could be re-used)

; Otherwise, extract this strURL:
StringTrimLeft, strURL, strURLSearchString, %intURLStart% ; Omit the beginning/irrelevant part.
Loop, parse, strURL, %A_Tab%%A_Space%<> ; Find the first space, tab, or angle (if any).
{
	strURL := A_LoopField
	break ; i.e. perform only one loop iteration to fetch the first "field".
}
; If the above loop had zero iterations because there were no ending characters found,
; leave the contents of the strURL var untouched.

; If the strURL ends in a double quote, remove it.  For now, StringReplace is used, but
; note that it seems that double quotes can legitimately exist inside URLs, so this
; might damage them:
StringReplace, strURLCleansed, strURL, ",, All

; See if there are any other URLs in this line:
StringLen, intCharactersToOmit, strURL
intCharactersToOmit += intURLStart
StringTrimLeft, strURLSearchString, strURLSearchString, %intCharactersToOmit%

Gosub, GetURLsInClipboardLine ; Recursive call to self (end of loop)

strURLsInClipboard .= strURLCleansed . "`n"

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildPowerMenu:
;------------------------------------------------------------

Menu, g_menuPower, Add
Menu, g_menuPower, DeleteAll

Loop
	if g_objQAPFeaturesPowerCodeByOrder.Haskey(A_Index)
		AddMenuIcon("g_menuPower", g_objQAPFeatures[g_objQAPFeaturesPowerCodeByOrder[A_Index]].LocalizedName
			, "OpenPowerMenu", g_objQAPFeatures[g_objQAPFeaturesPowerCodeByOrder[A_Index]].DefaultIcon)
	else
		if g_objQAPFeaturesPowerCodeByOrder.Haskey(A_Index + 1) ; there is another menu item, add a menu separator
			Menu, g_menuPower, Add
		else
			break ; menu finished

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildMainMenu:
BuildMainMenuWithStatus:
;------------------------------------------------------------

if (A_ThisLabel = "BuildMainMenuWithStatus")
{
	TrayTip, % L(lTrayTipWorkingTitle, g_strAppNameText)
		, %lTrayTipWorkingDetail%, , 17
	Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
}

Menu, %lMainMenuName%, Add
Menu, %lMainMenuName%, DeleteAll
if (g_blnUseColors)
	Menu, %lMainMenuName%, Color, %g_strMenuBackgroundColor%

g_objMenuColumnBreaks := Object() ; re-init before rebuilding menu

RecursiveBuildOneMenu(g_objMainMenu) ; recurse for submenus

if !(g_blnDonor)
{
	if (g_objMenusIndex[lMainMenuName][g_objMenusIndex[lMainMenuName].MaxIndex()].FavoriteType <> "K")
	; column break not allowed if first item is a separator
		Menu, %lMainMenuName%, Add
	AddMenuIcon(lMainMenuName, lDonateMenu . "...", "GuiDonate", "iconDonate")
}

if (A_ThisLabel = "BuildMainMenuWithStatus")
{
	TrayTip, % L(lTrayTipInstalledTitle, g_strAppNameText)
		, %lTrayTipWorkingDetailFinished%, , 17
	Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
}

return
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveBuildOneMenu(objCurrentMenu)
;------------------------------------------------------------
{
	global g_blnDisplayNumericShortcuts
	global g_blnDisplayIcons
	global g_intIconSize
	global g_strMenuBackgroundColor
	global g_objIconsFile
	global g_objIconsIndex
	global g_blnUseColors
	global g_strGroupIndicatorPrefix
	global g_strGroupIndicatorSuffix
	global g_objQAPFeatures
	global g_objMenuColumnBreaks
	global g_intHotkeyReminders
	global g_objHotkeysByLocation

	
	intShortcut := 0
	
	; try because at first execution the strMenu menu does not exist and produces an error,
	; but DeleteAll is required later for menu updates
	try Menu, % objCurrentMenu.MenuPath, DeleteAll
	
	intMenuItemsCount := 0
	
	Loop, % objCurrentMenu.MaxIndex()
	{	
		intMenuItemsCount++ ; for objMenuColumnBreak
		
		if StrLen(objCurrentMenu[A_Index].FavoriteName)
			strMenuName := (g_blnDisplayNumericShortcuts and (intShortcut <= 35) ? "&" . NextMenuShortcut(intShortcut) . " " : "") . objCurrentMenu[A_Index].FavoriteName
		
		if (objCurrentMenu[A_Index].FavoriteType = "Group")
			strMenuName .= " " . g_strGroupIndicatorPrefix . objCurrentMenu[A_Index].Submenu.MaxIndex() - 1 . g_strGroupIndicatorSuffix
		
		if (g_intHotkeyReminders > 1) and g_objHotkeysByLocation.HasKey(objCurrentMenu[A_Index].FavoriteLocation)
			strMenuName .= " (" . (g_intHotkeyReminders = 2 ? g_objHotkeysByLocation[objCurrentMenu[A_Index].FavoriteLocation] : Hotkey2Text(g_objHotkeysByLocation[objCurrentMenu[A_Index].FavoriteLocation])) . ")"
		
		if (objCurrentMenu[A_Index].FavoriteType = "B") ; skip back link
			continue
		
		if (objCurrentMenu[A_Index].FavoriteType = "Menu")
		{
			RecursiveBuildOneMenu(objCurrentMenu[A_Index].SubMenu) ; RECURSIVE - build the submenu first
			
			if (g_blnUseColors)
				Try Menu, % objCurrentMenu[A_Index].SubMenu.MenuPath, Color, %g_strMenuBackgroundColor% ; Try because this can fail if submenu is empty
			
			Try Menu, % objCurrentMenu.MenuPath, Add, %strMenuName%, % ":" . objCurrentMenu[A_Index].SubMenu.MenuPath
			catch e ; when menu objCurrentMenu[A_Index].SubMenu.MenuPath is empty
				Menu, % objCurrentMenu.MenuPath, Add, %strMenuName%, OpenFavorite ; will never be called because disabled
			Menu, % objCurrentMenu.MenuPath, % (objCurrentMenu[A_Index].SubMenu.MaxIndex() > 1 ? "Enable" : "Disable"), %strMenuName% ; disable menu if contains only the back .. item
			if (g_blnDisplayIcons)
			{
				ParseIconResource(objCurrentMenu[A_Index].FavoriteIconResource, strThisIconFile, intThisIconIndex, "iconSubmenu")
				
				Menu, % objCurrentMenu.MenuPath, UseErrorLevel, on
				Menu, % objCurrentMenu.MenuPath, Icon, %strMenuName%
					, %strThisIconFile%, %intThisIconIndex% , %g_intIconSize%
				if (ErrorLevel)
					Menu, % objCurrentMenu.MenuPath, Icon, %strMenuName%
						, % g_objIconsFile["iconUnknown"], % g_objIconsIndex["iconUnknown"], %g_intIconSize%
				Menu, % objCurrentMenu.MenuPath, UseErrorLevel, off
			}
		}
		
		else if (objCurrentMenu[A_Index].FavoriteType = "X") ; this is a separator
			
			if (objCurrentMenu[A_Index - 1].FavoriteType = "K")
				intMenuItemsCount -= 1 ; separator not allowed as first item is a column, skip it
			else
				Menu, % objCurrentMenu.MenuPath, Add
			
		else if (objCurrentMenu[A_Index].FavoriteType = "K") ; this is a column break
		{
			intMenuItemsCount -= 1 ; column breaks do not take a slot in menus
			objMenuColumnBreak := Object()
			objMenuColumnBreak.MenuPath := objCurrentMenu.MenuPath
			objMenuColumnBreak.MenuPosition := intMenuItemsCount - (objCurrentMenu.MenuPath <> lMainMenuName ? 1 : 0)
			g_objMenuColumnBreaks.Insert(objMenuColumnBreak)
		}
		else ; this is a favorite (Folder, Document, Application, Special, URL, FTP, QAP or Group)
		{
			if (objCurrentMenu[A_Index].FavoriteType = "QAP") and Strlen(g_objQAPFeatures[objCurrentMenu[A_Index].FavoriteLocation].QAPFeatureMenuName)
				; menu should never be empty (if no item, it contains a "no item" menu)
				Menu, % objCurrentMenu.MenuPath, Add, %strMenuName%, % ":" . g_objQAPFeatures[objCurrentMenu[A_Index].FavoriteLocation].QAPFeatureMenuName
			else if (objCurrentMenu[A_Index].FavoriteType = "Group")
				Menu, % objCurrentMenu.MenuPath, Add, %strMenuName%, OpenFavoriteGroup
			else
				Menu, % objCurrentMenu.MenuPath, Add, %strMenuName%, OpenFavorite

			if (g_blnDisplayIcons)
			{
				Menu, % objCurrentMenu.MenuPath, UseErrorLevel, on
				if (objCurrentMenu[A_Index].FavoriteType = "Folder") ; this is a folder
					ParseIconResource(objCurrentMenu[A_Index].FavoriteIconResource, strThisIconFile, intThisIconIndex, "iconFolder")
				else if (objCurrentMenu[A_Index].FavoriteType = "URL") ; this is an URL
					if StrLen(objCurrentMenu[A_Index].FavoriteIconResource)
						ParseIconResource(objCurrentMenu[A_Index].FavoriteIconResource, strThisIconFile, intThisIconIndex)
					else
						GetIcon4Location(g_strTempDir . "\default_browser_icon.html", strThisIconFile, intThisIconIndex)
						; not sure it is required to have a physical file with .html extension - but keep it as is by safety
				else ; this is a document or application, ### or Special / FTP / QAP that must have FavoriteIconResource ?)
					if StrLen(objCurrentMenu[A_Index].FavoriteIconResource)
						ParseIconResource(objCurrentMenu[A_Index].FavoriteIconResource, strThisIconFile, intThisIconIndex)
					else
						GetIcon4Location(objCurrentMenu[A_Index].FavoriteLocation, strThisIconFile, intThisIconIndex)
					
				ErrorLevel := 0 ; for safety clear in case Menu is not called in next if
				if StrLen(strThisIconFile)
					Menu, % objCurrentMenu.MenuPath, Icon, %strMenuName%, %strThisIconFile%, %intThisIconIndex%, %g_intIconSize%
				if (!StrLen(strThisIconFile) or ErrorLevel)
					Menu, % objCurrentMenu.MenuPath, Icon, %strMenuName%
						, % g_objIconsFile["iconUnknown"], % g_objIconsIndex["iconUnknown"], %g_intIconSize%
						
				Menu, % objCurrentMenu.MenuPath, UseErrorLevel, off
			}
			if (objCurrentMenu[A_Index].FavoriteName = lMenuSettings . "...") ; make Settings... menu bold in any menu
				Menu, % objCurrentMenu.MenuPath, Default, %strMenuName%
		}
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
AddMenuIcon(strMenuName, ByRef strMenuItemName, strLabel, strIconValue, blnEnabled := true)
; strIconValue can be an item from strIconsMenus (eg: "iconFolder") or a "file,index" combo (eg: "imageres.dll,33")
; strThisDefaultIcon is returned truncated if longer than 260 chars
;------------------------------------------------------------
{
	global g_intIconSize
	global g_blnDisplayIcons
	global g_objIconsFile ; ok
	global g_objIconsIndex ; ok
	global g_blnMainIsFirstColumn

	if !StrLen(strMenuItemName)
		return
	
	; The names of menus and menu items can be up to 260 characters long.
	if StrLen(strMenuItemName) > 260
		strMenuItemName := SubStr(strMenuItemName, 1, 256) . "..." ; minus one for the luck ;-)
	
	Menu, %strMenuName%, Add, %strMenuItemName%, %strLabel%
	if (g_blnDisplayIcons)
		; under Win_XP, display icons in main menu only when in first column (for other menus, this fuction is not called)
	{
		Menu, %strMenuName%, UseErrorLevel, on
		if InStr(strIconValue, ",")
			ParseIconResource(strIconValue, strIconFile, intIconIndex)
		else
		{
			strIconFile := g_objIconsFile[strIconValue]
			intIconIndex := g_objIconsIndex[strIconValue]
		}
		
		Menu, %strMenuName%, Icon, %strMenuItemName%, %strIconFile%, %intIconIndex%, %g_intIconSize%
		if (ErrorLevel)
			Menu, %strMenuName%, Icon, %strMenuItemName%
				, % g_objIconsFile["iconUnknown"], % g_objIconsIndex["iconUnknown"], %g_intIconSize%
		Menu, %strMenuName%, UseErrorLevel, off
	}
	
	if !(blnEnabled)
		Menu, %strMenuName%, Disable, %strMenuItemName%
}
;------------------------------------------------------------


;------------------------------------------------------------
InsertColumnBreaks:
; Based on Lexikos
; http://www.autohotkey.com/board/topic/69553-menu-with-columns-problem-with-adding-column-separator/#entry440866
;------------------------------------------------------------

VarSetCapacity(mii, cb:=16+8*A_PtrSize, 0) ; A_PtrSize is used for 64-bit compatibility.
NumPut(cb, mii, "uint")
NumPut(0x100, mii, 4, "uint") ; fMask = MIIM_FTYPE
NumPut(0x20, mii, 8, "uint") ; fType = MFT_MENUBARBREAK

for intIndex, objMenuColumnBreak in g_objMenuColumnBreaks
{
	pMenuHandle := GetMenuHandle(objMenuColumnBreak.MenuPath) 
	DllCall("SetMenuItemInfo", "ptr", pMenuHandle, "uint", objMenuColumnBreak.MenuPosition, "int", 1, "ptr", &mii)
}

return
;------------------------------------------------------------


;------------------------------------------------------------
GetMenuHandle(strMenuName)
; from MenuIcons v2 by Lexikos
; http://www.autohotkey.com/board/topic/20253-menu-icons-v2/
;------------------------------------------------------------
{
	static pMenuDummy
	
	; v2.2: Check for !pMenuDummy instead of pMenuDummy="" in case init failed last time.
	If !pMenuDummy
	{
		Menu, menuDummy, Add
		Menu, menuDummy, DeleteAll
		
		Gui, 99:Menu, menuDummy
		; v2.2: Use LastFound method instead of window title. [Thanks animeaime.]
		Gui, 99:+LastFound
		
		pMenuDummy := DllCall("GetMenu", "uint", WinExist())
		
		Gui, 99:Menu
		Gui, 99:Destroy
		
		; v2.2: Return only after cleaning up. [Thanks animeaime.]
		if !pMenuDummy
			return 0
	}

	Menu, menuDummy, Add, :%strMenuName%
	pMenu := DllCall( "GetSubMenu", "uint", pMenuDummy, "int", 0 )
	DllCall( "RemoveMenu", "uint", pMenuDummy, "uint", 0, "uint", 0x400 )
	Menu, menuDummy, Delete, :%strMenuName%

	return pMenu
}
;------------------------------------------------------------



;========================================================================================================================
; END OF BUILD
;========================================================================================================================



;========================================================================================================================
!_025_OPTIONS:
;========================================================================================================================

;------------------------------------------------------------
GuiOptions:
GuiOptionsFromQAPFeature:
;------------------------------------------------------------

if (A_ThisLabel = "GuiOptionsFromQAPFeature")
	Gosub, GuiShow

g_intGui1WinID := WinExist("A")
loop, 4
	g_arrPopupHotkeysPrevious%A_Index% := g_arrPopupHotkeys%A_Index% ; allow to turn off changed hotkeys and to revert g_arrPopupHotkeys if cancel

g_objQAPFeaturesNewHotkeys := Object() ; re-init
for intOrder, strPowerCode in g_objQAPFeaturesPowerCodeByOrder
	if HasHotkey(g_objQAPFeatures[strPowerCode].CurrentHotkey)
		; ###_V("strPowerCode", strPowerCode, g_objQAPFeatures[strPowerCode].LocalizedName, g_objQAPFeatures[strPowerCode].Hotkey)
		; g_objQAPFeaturesNewHotkeys will be saved to ini file and g_objQAPFeatures will be used to turn off previous hotkeys
		g_objQAPFeaturesNewHotkeys.Insert(strPowerCode, g_objQAPFeatures[strPowerCode].CurrentHotkey)

StringSplit, g_arrOptionsTitlesSub, lOptionsPopupHotkeyTitlesSub, |

;---------------------------------------
; Build Gui header
Gui, 1:Submit, NoHide
Gui, 2:New, , % L(lOptionsGuiTitle, g_strAppNameText, g_strAppVersion)
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%
Gui, 2:+Owner1
Gui, 2:Font, s10 w700, Verdana
Gui, 2:Add, Text, x10 y10 w595 center, % L(lOptionsGuiTitle, g_strAppNameText)

Gui, 2:Font, s8 w600, Verdana
Gui, 2:Add, Tab2, vf_intOptionsTab w620 h400 AltSubmit, %A_Space%%lOptionsOtherOptions% | %lOptionsMouseAndKeyboard% | %lOptionsPowerMenuFeatures% | %lOptionsExclusionList% | %lOptionsThirdParty%%A_Space%

;---------------------------------------
; Tab 1: General options

Gui, 2:Tab, 1

Gui, 2:Font
Gui, 2:Add, Text, x10 y+10 w595 center, % L(lOptionsTabOtherOptionsIntro, g_strAppNameText)

; column 1
Gui, 2:Add, Text, y+10 x15 Section, %lOptionsLanguage%
Gui, 2:Add, DropDownList, y+5 xs w120 vf_drpLanguage Sort, %lOptionsLanguageLabels%
GuiControl, ChooseString, f_drpLanguage, %g_strLanguageLabel%

Gui, 2:Add, Text, y+10 xs, %lOptionsTheme%
Gui, 2:Add, DropDownList, y+5 xs w120 vf_drpTheme, %g_strAvailableThemes%
GuiControl, ChooseString, f_drpTheme, %g_strTheme%

Gui, 2:Add, CheckBox, y+15 xs w220 vf_blnOptionsRunAtStartup, %lOptionsRunAtStartup%
GuiControl, , f_blnOptionsRunAtStartup, % FileExist(A_Startup . "\" . g_strAppNameFile . ".lnk") ? 1 : 0

Gui, 2:Add, CheckBox, y+10 xs w220 vf_blnDisplayTrayTip, %lOptionsTrayTip%
GuiControl, , f_blnDisplayTrayTip, %g_blnDisplayTrayTip%

Gui, 2:Add, CheckBox, y+10 xs w220 vf_blnCheck4Update, %lOptionsCheck4Update%
GuiControl, , f_blnCheck4Update, %g_blnCheck4Update%

Gui, 2:Add, CheckBox, y+10 xs w220 vf_blnRememberSettingsPosition, %lOptionsRememberSettingsPosition%
GuiControl, , f_blnRememberSettingsPosition, %g_blnRememberSettingsPosition%

Gui, 2:Add, Text, y+15 xs, %lOptionsRecentFoldersPrompt%
Gui, 2:Add, Edit, y+5 xs w36 h17 vf_intRecentFoldersMax center, %g_intRecentFoldersMax%
Gui, 2:Add, Text, yp x+10 w180, %lOptionsRecentFolders%

; column 2

Gui, 2:Add, Text, ys x300 w190 Section, %lOptionsMenuPositionPrompt%

Gui, 2:Add, Radio, % "y+5 xs w190 vf_radPopupMenuPosition1 gPopupMenuPositionClicked Group " . (g_intPopupMenuPosition = 1 ? "Checked" : ""), %lOptionsMenuNearMouse%
Gui, 2:Add, Radio, % "y+5 xs w190 vf_radPopupMenuPosition2 gPopupMenuPositionClicked " . (g_intPopupMenuPosition = 2 ? "Checked" : ""), %lOptionsMenuActiveWindow%
Gui, 2:Add, Radio, % "y+5 xs w190 vf_radPopupMenuPosition3 gPopupMenuPositionClicked " . (g_intPopupMenuPosition = 3 ? "Checked" : ""), %lOptionsMenuFixPosition%

Gui, 2:Add, Text, % "y+5 xs+18 vf_lblPopupFixPositionX " . (g_intPopupMenuPosition = 3 ? "" : "Disabled"), %lOptionsPopupFixPositionX%
Gui, 2:Add, Edit, % "yp x+5 w36 h17 vf_strPopupFixPositionX center " . (g_intPopupMenuPosition = 3 ? "" : "Disabled"), %g_arrPopupFixPosition1%
Gui, 2:Add, Text, % "yp x+5 vf_lblPopupFixPositionY " . (g_intPopupMenuPosition = 3 ? "" : "Disabled"), %lOptionsPopupFixPositionY%
Gui, 2:Add, Edit, % "yp x+5 w36 h17 vf_strPopupFixPositionY center " . (g_intPopupMenuPosition = 3 ? "" : "Disabled"), %g_arrPopupFixPosition2%

Gui, 2:Add, Text, y+10 x300 w190 Section, %lOptionsHotkeyRemindersPrompt%

Gui, 2:Add, Radio, % "y+5 xs w190 vf_radHotkeyReminders1 Group " . (g_intHotkeyReminders = 1 ? "Checked" : ""), %lOptionsHotkeyRemindersNo%
Gui, 2:Add, Radio, % "y+5 xs w190 vf_radHotkeyReminders2 " . (g_intHotkeyReminders = 2 ? "Checked" : ""), %lOptionsHotkeyRemindersShort%
Gui, 2:Add, Radio, % "y+5 xs w190 vf_radHotkeyReminders3 " . (g_intHotkeyReminders = 3 ? "Checked" : ""), %lOptionsHotkeyRemindersFull%

Gui, 2:Add, CheckBox, y+15 xs w220 vf_blnDisplayNumericShortcuts, %lOptionsDisplayMenuShortcuts%
GuiControl, , f_blnDisplayNumericShortcuts, %g_blnDisplayNumericShortcuts%

Gui, 2:Add, CheckBox, y+10 xs w220 vf_blnOpenMenuOnTaskbar, %lOptionsOpenMenuOnTaskbar%
GuiControl, , f_blnOpenMenuOnTaskbar, %g_blnOpenMenuOnTaskbar%

if !OSVersionIsWorkstation()
{
	g_blnDisplayIcons := false
	GuiControl, Disable, f_blnDisplayIcons
}
Gui, 2:Add, CheckBox, y+10 xs w220 vf_blnDisplayIcons gDisplayIconsClicked, %lOptionsDisplayIcons%
GuiControl, , f_blnDisplayIcons, %g_blnDisplayIcons%

Gui, 2:Add, Text, % "y+10 xs vf_drpIconSizeLabel " . (g_blnDisplayIcons ? "" : "Disabled"), %lOptionsIconSize%
Gui, 2:Add, DropDownList, % "yp x+10 w40 vf_drpIconSize Sort " . (g_blnDisplayIcons ? "" : "Disabled"), 16|24|32|48|64
GuiControl, ChooseString, f_drpIconSize, %g_intIconSize%

;---------------------------------------
; Tab 2: Popup menu hotkeys

Gui, 2:Tab, 2

Gui, 2:Font
Gui, 2:Add, Text, x10 y+10 w595 center, % L(lOptionsTabMouseAndKeyboardIntro, g_strAppNameText)

loop, % g_arrPopupHotkeyNames%0%
{
	Gui, 2:Font, s8 w700
	Gui, 2:Add, Text, x15 y+20 w610, % g_arrOptionsPopupHotkeyTitles%A_Index%
	Gui, 2:Font, s9 w500, Courier New
	Gui, 2:Add, Text, Section x260 y+5 w280 h23 center 0x1000 vf_lblHotkeyText%A_Index% gButtonOptionsChangeHotkey%A_Index%, % HotkeySections2Text(strModifiers%A_Index%, strMouseButton%A_Index%, strOptionsKey%A_Index%)
	Gui, 2:Font
	Gui, 2:Add, Button, yp x555 vf_btnChangeHotkey%A_Index% gButtonOptionsChangeHotkey%A_Index%, %lOptionsChangeHotkey%
	Gui, 2:Font, s8 w500
	Gui, 2:Add, Link, x15 ys w240 gOptionsTitlesSubClicked, % g_arrOptionsTitlesSub%A_Index%
}

Gui, 2:Add, CheckBox, y+15 x15 w600 vf_blnChangeFolderInDialog gChangeFoldersInDialogClicked, %lOptionsChangeFolderInDialog%
GuiControl, , f_blnChangeFolderInDialog, %g_blnChangeFolderInDialog%

;---------------------------------------
; Tab 3: Power Menu Features

Gui, 2:Tab, 3

Gui, 2:Font
Gui, 2:Add, Text, x10 y+10 w595 center, % L(lOptionsPowerMenuFeaturesIntro, Hotkey2Text(g_arrPopupHotkeys3), Hotkey2Text(g_arrPopupHotkeys4))

for intOrder, strPowerCode in g_objQAPFeaturesPowerCodeByOrder
{
	; ###_V("g_objQAPFeaturesPowerCodeByOrder", intOrder, strPowerCode, g_objQAPFeatures[strPowerCode].CurrentHotkey)
	; ###_V("strPowerCode", strPowerCode, g_objQAPFeatures[strPowerCode].LocalizedName, g_objQAPFeatures[strPowerCode].CurrentHotkey)
	Gui, 2:Font, s8 w700
	Gui, 2:Add, Link, x15 y+10 w240, % g_objQAPFeatures[strPowerCode].LocalizedName . " <A id=""" . strPowerCode . """>?</A>" ; ### link to help
	Gui, 2:Font, s9 w500, Courier New
	Gui, 2:Add, Text, Section x260 yp w280 h20 center 0x1000 vf_lblPowerHotkeyText%intOrder% gButtonOptionsChangePowerHotkey
		, % Hotkey2Text(g_objQAPFeatures[strPowerCode].CurrentHotkey)
	Gui, 2:Font
	Gui, 2:Add, Button, yp x555 vf_btnChangePowerHotkey%intOrder% gButtonOptionsChangePowerHotkey, %lOptionsChangeHotkey%
}

;---------------------------------------
; Tab 4: Exclusion list

Gui, 2:Tab, 4
Gui, 2:Font

Gui, 2:Add, Text, x10 y+10 w595, Exclusions list for Mouse hotkeys
Gui, 2:Add, Edit, x10 y+5 w600 r10 vf_strExclusionMouseClassList, % ReplaceAllInString(Trim(g_strExclusionMouseClassList), "|", "`n")

Gui, 2:Add, Text, x10 y+20 w595, Exclusions list for Keyboard hotkey
Gui, 2:Add, Edit, x10 y+5 w600 r10 vf_strExclusionKeyboardClassList, % ReplaceAllInString(Trim(g_strExclusionKeyboardClassList), "|", "`n")

;---------------------------------------
; Tab 5: File Managers

Gui, 2:Tab, 5

Gui, 2:Add, Text, x10 y+10 w595 center, %lOptionsTabFileManagersIntro%

loop, %g_arrActiveFileManagerSystemNames0%
	Gui, 2:Add, Radio, % "y+10 x15 gActiveFileManagerClicked vf_radActiveFileManager" . A_Index . (g_intActiveFileManager = A_Index ? " checked" : ""), % g_arrActiveFileManagerDisplayNames%A_Index%
	
/*
Gui, 2:Add, Radio, % "y+10 x15 gActiveFileManagerClicked vf_radActiveFileManager1" . (g_strActiveFileManager = "Windows Explorer" ? " checked" : ""), Windows Explorer ; 1
Gui, 2:Add, Radio, % "y+10 x15 gActiveFileManagerClicked vf_radActiveFileManager2" . (g_strActiveFileManager = "Directory Opus" ? " checked" : ""), Directory Opus ; 2
Gui, 2:Add, Radio, % "y+10 x15 gActiveFileManagerClicked vf_radActiveFileManager3" . (g_strActiveFileManager = "Total Commander" ? " checked" : ""), Total Commander ; 3
Gui, 2:Add, Radio, % "y+10 x15 gActiveFileManagerClicked vf_radActiveFileManager4" . (g_strActiveFileManager = "QAPconnect" ? " checked" : ""), % "QAPconnect (" . L(lOptionsThirdPartyQAPconnectRadio, "QAPconnect.ini") . ")" ; 4
*/

Gui, 2:Font, s8 w700
Gui, 2:Add, Link, y+25 x32 w500 vf_lnkFileManagerHelp hidden
Gui, 2:Font
Gui, 2:Add, Text, y+10 x32 w500 vf_lblFileManagerDetail hidden
Gui, 2:Add, Text, y+10 x32 vf_lblFileManagerPrompt hidden, %lDialogApplicationLabel%:
Gui, 2:Add, Edit, yp x+10 w300 h20 vf_strFileManagerPath hidden
IniRead, strQAPconnectFileManagersList, %g_strQAPconnectIniPath%, , , %A_Space% ; list of QAPconnect.ini applications, empty by default

if StrLen(strQAPconnectFileManagersList)
{
	strQAPconnectFileManagersList .= "|"
	StringReplace, strQAPconnectFileManagersList, strQAPconnectFileManagersList, `n, |, All
	if StrLen(g_strQAPconnectFileManager)
		StringReplace, strQAPconnectFileManagersList, strQAPconnectFileManagersList, %g_strQAPconnectFileManager%|, %g_strQAPconnectFileManager%||
}
Gui, 2:Add, DropDownList, xp yp w300 vf_drpQAPconnectFileManager hidden Sort, %strQAPconnectFileManagersList%
if StrLen(g_strQAPconnectFileManager)
	GuiControl, ChooseString, f_drpQAPconnectFileManager, %g_strQAPconnectFileManager%
Gui, 2:Add, Button, x+10 yp vf_btnFileManagerPath gButtonSelectFileManagerPath hidden, %lDialogBrowseButton%
Gui, 2:Add, Checkbox, y+10 x32 w590 vf_blnFileManagerUseTabs hidden, %lOptionsThirdPartyUseTabs%
Gui, 2:Add, Button, xp yp vf_btnQAPconnectEdit gShowQAPconnectIniFile hidden, % L(lMenuEditIniFile, "QAPconnect.ini")

Gosub, ActiveFileManagerClicked ; init visible fields

;---------------------------------------
; Build Gui footer

Gui, 2:Tab

GuiControlGet, arrTabPos, Pos, f_intOptionsTab

Gui, 2:Add, Button, % "y" . arrTabPosY + arrTabPosH + 10 . " x10 vf_btnOptionsSave gButtonOptionsSave Default", %lGuiSave%
Gui, 2:Add, Button, yp vf_btnOptionsCancel gButtonOptionsCancel, %lGuiCancel%
Gui, 2:Add, Button, yp vf_btnOptionsDonate gGuiDonate, %lDonateButton%
GuiCenterButtons(L(lOptionsGuiTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnOptionsSave", "f_btnOptionsCancel", "f_btnOptionsDonate")

Gui, 2:Add, Text
GuiControl, Focus, f_btnOptionsSave

Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

strQAPconnectFileManagersList := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ActiveFileManagerClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, % (f_radActiveFileManager1 ? "Hide" : "Show"), f_lnkFileManagerHelp
GuiControl, % (f_radActiveFileManager1 ? "Hide" : "Show"), f_lblFileManagerDetail
GuiControl, % (f_radActiveFileManager1 ? "Hide" : "Show"), f_lblFileManagerPrompt
GuiControl, % (f_radActiveFileManager1 or f_radActiveFileManager4 ? "Hide" : "Show"), f_strFileManagerPath
GuiControl, % (!f_radActiveFileManager4 ? "Hide" : "Show"), f_drpQAPconnectFileManager
GuiControl, % (f_radActiveFileManager1 or f_radActiveFileManager4 ? "Hide" : "Show"), f_btnFileManagerPath
GuiControl, % (!f_radActiveFileManager4 ? "Hide" : "Show"), f_btnQAPconnectEdit
GuiControl, % (f_radActiveFileManager1 or f_radActiveFileManager4 ? "Hide" : "Show"), f_blnFileManagerUseTabs

if (f_radActiveFileManager2) ; DirectoryOpus
{
	g_intClickedFileManager := 2
	strHelpUrl := "http://code.jeanlalonde.ca/using-folderspopup-with-directory-opus/"
}
else if (f_radActiveFileManager3) ; TotalCommander
{
	g_intClickedFileManager := 3
	strHelpUrl := "http://code.jeanlalonde.ca/using-folderspopup-with-total-commander/"
}
else if (f_radActiveFileManager4) ; QAPconnect
{
	g_intClickedFileManager := 4
	strHelpUrl := "###"
}
else ; f_radActiveFileManager1
	g_intClickedFileManager := 1

if !(f_radActiveFileManager1) ; DirectoryOpus, TotalCommander or QAPconnect
{
	strClickedFileManagerSystemNames := g_arrActiveFileManagerSystemNames%g_intClickedFileManager%
	
	if !StrLen(g_str%strClickedFileManagerSystemNames%Path)
		IniRead, g_str%strClickedFileManagerSystemNames%Path, %g_strIniFile%, Global, %strClickedFileManagerSystemNames%Path, %A_Space% ; empty if error
	
	GuiControl, , f_lnkFileManagerHelp, % L(lOptionsThirdPartySelectedHelp, g_arrActiveFileManagerDisplayNames%g_intClickedFileManager%, strHelpUrl, lGuiHelp)
	GuiControl, , f_lblFileManagerDetail, % (f_radActiveFileManager4 ? L(lOptionsThirdPartyDetailQAPconnect, "QAPconnect.ini") : L(lOptionsThirdPartyDetail, g_arrActiveFileManagerDisplayNames%g_intClickedFileManager%))
	GuiControl, , f_strFileManagerPath, % g_str%strClickedFileManagerSystemNames%Path
	if !(f_radActiveFileManager4) ; DirectoryOpus or TotalCommander
	{
		if !StrLen(g_bln%strClickedFileManagerSystemNames%UseTabs)
			IniRead, g_bln%strClickedFileManagerSystemNames%UseTabs, %g_strIniFile%, Global, %strClickedFileManagerSystemNames%UseTabs, %A_Space% ; empty if error
		GuiControl, , f_blnFileManagerUseTabs, % (g_bln%strClickedFileManagerSystemNames%UseTabs ? 1 : 0)
	}
}

strClickedFileManagerSystemNames := ""
strHelpUrl := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
DisplayIconsClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, % (f_blnDisplayIcons ? "Enable" : "Disable"), f_drpIconSizeLabel
GuiControl, % (f_blnDisplayIcons ? "Enable" : "Disable"), f_drpIconSize

return
;------------------------------------------------------------


;------------------------------------------------------------
PopupMenuPositionClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, % (f_radPopupMenuPosition3 ? "Enable" : "Disable"), f_lblPopupFixPositionX
GuiControl, % (f_radPopupMenuPosition3 ? "Enable" : "Disable"), f_strPopupFixPositionX
GuiControl, % (f_radPopupMenuPosition3 ? "Enable" : "Disable"), f_lblPopupFixPositionY
GuiControl, % (f_radPopupMenuPosition3 ? "Enable" : "Disable"), f_strPopupFixPositionY

return
;------------------------------------------------------------


;------------------------------------------------------------
OptionsTitlesSubClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, Choose, f_intOptionsTab, 3

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonOptionsChangeHotkey1:
ButtonOptionsChangeHotkey2:
ButtonOptionsChangeHotkey3:
ButtonOptionsChangeHotkey4:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

StringReplace, intHotkeyIndex, A_ThisLabel, ButtonOptionsChangeHotkey

if InStr(g_arrPopupHotkeyNames%intHotkeyIndex%, "Mouse")
	intHotkeyType := 1 ; Mouse
else
	intHotkeyType := 2 ; Keyboard

strPopupHotkeysBackup := g_arrPopupHotkeys%intHotkeyIndex%
g_arrPopupHotkeys%intHotkeyIndex% := SelectHotkey(g_arrPopupHotkeys%intHotkeyIndex%, g_arrOptionsPopupHotkeyTitles%intHotkeyIndex%, "", "", intHotkeyType, g_arrPopupHotkeyDefaults%intHotkeyIndex%, g_arrOptionsTitlesSub%intHotkeyIndex%)

if StrLen(g_arrPopupHotkeys%intHotkeyIndex%)
	GuiControl, 2:, f_lblHotkeyText%intHotkeyIndex%, % Hotkey2Text(g_arrPopupHotkeys%intHotkeyIndex%)
else
	g_arrPopupHotkeys%intHotkeyIndex% := strPopupHotkeysBackup
	
strPopupHotkeysBackup := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonOptionsChangePowerHotkey:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

intPowerOrder := A_GuiControl
StringReplace, intPowerOrder, intPowerOrder, f_lblPowerHotkeyText
StringReplace, intPowerOrder, intPowerOrder, f_btnChangePowerHotkey
; ###_V(intPowerOrder, g_objQAPFeaturesPowerCodeByOrder[intPowerOrder], g_objQAPFeatures[g_objQAPFeaturesPowerCodeByOrder[intPowerOrder]].Hotkey)

strThisPowerCode := g_objQAPFeaturesPowerCodeByOrder[intPowerOrder]
objThisPower := g_objQAPFeatures[strThisPowerCode]
g_objQAPFeaturesNewHotkeys[strThisPowerCode] := SelectHotkey(objThisPower.CurrentHotkey, objThisPower.LocalizedName, lDialogHotkeysManagePower
	, "", 3, objThisPower.DefaultHotkey)
; ###_D(Hotkey2Text(g_objQAPFeaturesNewHotkeys[strThisPowerCode]))

if StrLen(g_objQAPFeaturesNewHotkeys[strThisPowerCode])
	GuiControl, 2:, f_lblPowerHotkeyText%intPowerOrder%, % Hotkey2Text(g_objQAPFeaturesNewHotkeys[strThisPowerCode])
	
; strPopupHotkeysBackup := ""
intPowerOrder := ""
strThisPowerCode := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ChangeFoldersInDialogClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

if !(f_blnChangeFolderInDialog)
	return
GuiControl, 2:, f_blnChangeFolderInDialog, 0

intGui2WinID := WinExist("A")

Gui, 3:New, , %lOptionsChangeFolderInDialog%
Gui, 3:+Owner2

if (g_blnUseColors)
	Gui, 3:Color, %g_strGuiWindowColor%
Gui, 3:Font, s10 w700, Verdana
Gui, 3:Add, Text, x10 y10 w400, %lOptionsChangeFolderInDialog%
Gui, 3:Font
Gui, 3:Add, Text, x10 w400, % L(lOptionsChangeFolderInDialogText , Hotkey2Text(g_arrPopupHotkeys3), Hotkey2Text(g_arrPopupHotkeys4), Hotkey2Text(g_arrPopupHotkeys1), Hotkey2Text(g_arrPopupHotkeys2))
Gui, 3:Add, Checkbox, x10 w400 vf_blnUnderstandChangeFoldersInDialogRisk, %lOptionsChangeFolderInDialogCheckbox%

Gui, Add, Button, y+25 x10 vf_btnChangeFolderInDialogOK gChangeFoldersInDialogOK, %lDialogOK%
Gui, Add, Button, yp x+20 vf_btnChangeFolderInDialogCancel gChangeFoldersInDialogCancel, %lGuiCancel%
	
GuiCenterButtons(lOptionsChangeFolderInDialog, 10, 5, 20, "f_btnChangeFolderInDialogOK", "f_btnChangeFolderInDialogCancel")

GuiControl, Focus, f_btnChangeFolderInDialogCancel
Gui, Show, AutoSize Center
Gui, 2:+Disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
ChangeFoldersInDialogOK:
ChangeFoldersInDialogCancel:
;------------------------------------------------------------
Gui, 3:Submit, NoHide

if (A_ThisLabel = "ChangeFoldersInDialogOK" and f_blnUnderstandChangeFoldersInDialogRisk)
{
	GuiControl, 2:, f_blnChangeFolderInDialog, 1
	IniWrite, 1, %g_strIniFile%, Global, UnderstandChangeFoldersInDialogRisk
}

Gosub, 3GuiClose

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonSelectFileManagerPath:
;------------------------------------------------------------
Gui, 2:+OwnDialogs

strActiveFileManagerSystemName := g_arrActiveFileManagerSystemNames%g_intClickedFileManager%
if StrLen(g_str%strActiveFileManagerSystemName%Path)
	strCurrentLocation := g_str%strActiveFileManagerSystemName%Path
else
{
	IniRead, strCurrentLocation, %g_strIniFile%, Global, %strActiveFileManagerSystemName%Path, %A_Space% ; empty if error
	if !StrLen(strCurrentLocation)
		if (g_intClickedFileManager = 2) ; DirectoryOpus
			strCurrentLocation := A_ProgramFiles . "\GPSoftware\Directory Opus\dopus.exe"
		else ; TotalCommander
			strCurrentLocation := GetTotalCommanderPath()
}
FileSelectFile, strNewLocation, 3, %strCurrentLocation%, %lDialogAddFolderSelect%

if !(StrLen(strNewLocation))
	return

GuiControl, 2:, f_strFileManagerPath, %strNewLocation%

strActiveFileManagerSystemName := ""
strCurrentLocation := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonOptionsSave:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

g_blnMenuReady := false

;---------------------------------------
; Validation Tab 5: File Managers

strActiveFileManagerDisplayName := g_arrActiveFileManagerDisplayNames%g_intClickedFileManager%

if (g_intClickedFileManager = 4) ; QAPconnect
{
	blnActiveFileManangerOK := StrLen(f_drpQAPconnectFileManager)
	if (blnActiveFileManangerOK)
	{
		g_strQAPconnectFileManager := f_drpQAPconnectFileManager
		Gosub, LoadIniQAPconnectValues ; values are already expanded
		blnActiveFileManangerOK := FileExist(g_strQAPconnectAppPath)
		if (blnActiveFileManangerOK)
			g_strQAPconnectFileManager := f_drpQAPconnectFileManager
	}
}
else if (g_intClickedFileManager > 1) ; 2 DirectoryOpus or 3 TotalCommander
{
	blnActiveFileManangerOK := StrLen(f_strFileManagerPath)
	if (blnActiveFileManangerOK)
		blnActiveFileManangerOK := FileExist(PathCombine(A_WorkingDir, EnvVars(f_strFileManagerPath)))
}
; ###_V(A_ThisLabel, g_intClickedFileManager, f_drpQAPconnectFileManager, blnActiveFileManangerOK, g_strQAPconnectFileManager, g_strQAPconnectCompanionPath)
if (g_intClickedFileManager > 1 and !blnActiveFileManangerOK)
{
	if (g_intClickedFileManager = 4)
		Oops(lOptionsThirdPartyFileNotFound, f_drpQAPconnectFileManager, g_strQAPconnectAppPath)
	else ; 2 DirectoryOpus or 3 TotalCommander
		if StrLen(f_strFileManagerPath)
			Oops(lOptionsThirdPartyFileNotFound, strActiveFileManagerDisplayName, PathCombine(A_WorkingDir, EnvVars(f_strFileManagerPath)))
		else
			Oops(lOptionsThirdPartySelectFile, strActiveFileManagerDisplayName)

	return
}
; from here, we know that we have valid file manager path values

; ###_V(A_ThisLabel, g_intClickedFileManager, g_strQAPconnectFileManager, g_strQAPconnectAppPath, strActiveFileManagerDisplayName, f_strFileManagerPath)

;---------------------------------------
; Save Tab 1: General options

IfExist, %A_Startup%\%g_strAppNameFile%.lnk
	FileDelete, %A_Startup%\%g_strAppNameFile%.lnk
if (f_blnOptionsRunAtStartup)
	FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%g_strAppNameFile%.lnk, %A_WorkingDir%
Menu, Tray, % f_blnOptionsRunAtStartup ? "Check" : "Uncheck", %lMenuRunAtStartup%

g_blnDisplayTrayTip := f_blnDisplayTrayTip
IniWrite, %g_blnDisplayTrayTip%, %g_strIniFile%, Global, DisplayTrayTip
g_blnChangeFolderInDialog := f_blnChangeFolderInDialog
IniWrite, %g_blnChangeFolderInDialog%, %g_strIniFile%, Global, ChangeFolderInDialog
g_blnDisplayIcons := f_blnDisplayIcons
IniWrite, %g_blnDisplayIcons%, %g_strIniFile%, Global, DisplayIcons
g_intRecentFoldersMax := f_intRecentFoldersMax
IniWrite, %g_intRecentFoldersMax%, %g_strIniFile%, Global, RecentFoldersMax
if (g_blnDisplayNumericShortcuts <> f_blnDisplayNumericShortcuts)
	gosub, RefreshClipboardMenu ; previous menu becomes unusable when adding/removing shortcuts
g_blnDisplayNumericShortcuts := f_blnDisplayNumericShortcuts
IniWrite, %g_blnDisplayNumericShortcuts%, %g_strIniFile%, Global, DisplayMenuShortcuts
g_blnCheck4Update := f_blnCheck4Update
IniWrite, %g_blnCheck4Update%, %g_strIniFile%, Global, Check4Update
g_blnOpenMenuOnTaskbar := f_blnOpenMenuOnTaskbar
IniWrite, %g_blnOpenMenuOnTaskbar%, %g_strIniFile%, Global, OpenMenuOnTaskbar
g_blnRememberSettingsPosition := f_blnRememberSettingsPosition
IniWrite, %g_blnRememberSettingsPosition%, %g_strIniFile%, Global, RememberSettingsPosition

if (f_radPopupMenuPosition1)
	g_intPopupMenuPosition := 1
else if (f_radPopupMenuPosition2)
	g_intPopupMenuPosition := 2
else
	g_intPopupMenuPosition := 3
IniWrite, %g_intPopupMenuPosition%, %g_strIniFile%, Global, PopupMenuPosition

g_arrPopupFixPosition1 := f_strPopupFixPositionX
g_arrPopupFixPosition2 := f_strPopupFixPositionY
IniWrite, %g_arrPopupFixPosition1%`,%g_arrPopupFixPosition2%, %g_strIniFile%, Global, PopupFixPosition

if (f_radHotkeyReminders1)
	g_intHotkeyReminders := 1
else if (f_radHotkeyReminders2)
	g_intHotkeyReminders := 2
else
	g_intHotkeyReminders := 3
IniWrite, %g_intHotkeyReminders%, %g_strIniFile%, Global, HotkeyReminders

strLanguageCodePrev := g_strLanguageCode
g_strLanguageLabel := f_drpLanguage
loop, %g_arrOptionsLanguageLabels0%
	if (g_arrOptionsLanguageLabels%A_Index% = g_strLanguageLabel)
		{
			g_strLanguageCode := g_arrOptionsLanguageCodes%A_Index%
			break
		}
IniWrite, %g_strLanguageCode%, %g_strIniFile%, Global, LanguageCode

strThemePrev := g_strTheme
g_strTheme := f_drpTheme
IniWrite, %g_strTheme%, %g_strIniFile%, Global, Theme

g_intIconSize := f_drpIconSize
IniWrite, %g_intIconSize%, %g_strIniFile%, Global, IconSize

;---------------------------------------
; Save Tab 2: Popup menu hotkeys

loop, % g_arrPopupHotkeyNames%0%
	if (g_arrPopupHotkeys%A_Index% = "None") ; do not compare with lOptionsMouseNone because it is translated
		IniWrite, None, %g_strIniFile%, Global, % g_arrPopupHotkeyNames%A_Index% ; do not write lOptionsMouseNone because it is translated
	else
		IniWrite, % g_arrPopupHotkeys%A_Index%, %g_strIniFile%, Global, % g_arrPopupHotkeyNames%A_Index%

;---------------------------------------
; Save Tab 3: Popup menu hotkeys

IniDelete, %g_strIniFile%, PowerMenuHotkeys
for strThisPowerCode, strNewHotkey in g_objQAPFeaturesNewHotkeys
	if HasHotkey(strNewHotkey)
		IniWrite, %strNewHotkey%, %g_strIniFile%, PowerMenuHotkeys, %strThisPowerCode%

Gosub, LoadIniPopupHotkeys ; reload ini variables and reset hotkeys

;---------------------------------------
; Save Tab 4: Exclusion list

g_strExclusionMouseClassList := ReplaceAllInString(Trim(f_strExclusionMouseClassList, " `t`n"), "`n", "|")
IniWrite, %g_strExclusionMouseClassList%, %g_strIniFile%, Global, ExclusionMouseClassList

g_strExclusionKeyboardClassList := ReplaceAllInString(Trim(f_strExclusionKeyboardClassList, " `t`n"), "`n", "|")
IniWrite, %g_strExclusionKeyboardClassList%, %g_strIniFile%, Global, ExclusionKeyboardClassList

;---------------------------------------
; Save Tab 5: File Managers

g_intActiveFileManager := g_intClickedFileManager
IniWrite, %g_intActiveFileManager%, %g_strIniFile%, Global, ActiveFileManager
	
strActiveFileManagerSystemName := g_arrActiveFileManagerSystemNames%g_intActiveFileManager%
; strActiveFileManagerDisplayName define during validation earlier

if (g_intActiveFileManager = 4) ; QAPconnect
	IniWrite, %g_strQAPconnectFileManager%, %g_strIniFile%, Global, QAPconnectFileManager
else if (g_intActiveFileManager > 1) ; 2 DirectoryOpus or 3 TotalCommander
{
	g_str%strActiveFileManagerSystemName%Path := f_strFileManagerPath
	IniWrite, % g_str%strActiveFileManagerSystemName%Path, %g_strIniFile%, Global, %strActiveFileManagerSystemName%Path
	
	g_bln%strActiveFileManagerSystemName%UseTabs := f_blnFileManagerUseTabs
	IniWrite, % g_bln%strActiveFileManagerSystemName%UseTabs, %g_strIniFile%, Global, %strActiveFileManagerSystemName%UseTabs
	if (g_intActiveFileManager = 2)
		if (g_blnDirectoryOpusUseTabs)
			g_strDirectoryOpusNewTabOrWindow := "NEWTAB" ; open new folder in a new lister tab
		else
			g_strDirectoryOpusNewTabOrWindow := "NEW" ; open new folder in a new DOpus lister (instance)
	else ; TotalCommander
		if (g_blnTotalCommanderUseTabs)
			g_strTotalCommanderNewTabOrWindow := "/O /T" ; open new folder in a new tab
		else
			g_strTotalCommanderNewTabOrWindow := "/N" ; open new folder in a new window (TC instance)
	IniWrite, % g_str%strActiveFileManagerSystemName%NewTabOrWindow, %g_strIniFile%, Global, %strActiveFileManagerSystemName%NewTabOrWindow
}
if (g_intActiveFileManager > 1) ; 2 DirectoryOpus, 3 TotalCommander or 4 QAPconnect
	Gosub, SetActiveFileManager

;---------------------------------------
; End of tabs

; if language or theme changed, offer to restart the app
if (strLanguageCodePrev <> g_strLanguageCode) or (strThemePrev <> g_strTheme)
{
	MsgBox, 52, %g_strAppNameText%, % L(lReloadPrompt, (strLanguageCodePrev <> g_strLanguageCode ? lOptionsLanguage : lOptionsTheme), (strLanguageCodePrev <> g_strLanguageCode ? g_strLanguageLabel : g_strTheme), g_strAppNameText)
	IfMsgBox, Yes
		Reload
}	

; else rebuild Explorers folder
Gosub, BuildCurrentFoldersMenu

; and rebuild Folders menus w/ or w/o optional folders and shortcuts
for strMenuName, arrMenu in g_objMenusIndex
{
	Menu, %strMenuName%, Add
	Menu, %strMenuName%, DeleteAll
	arrMenu := "" ; free object's memory
}
Gosub, BuildMainMenuWithStatus

Gosub, 2GuiClose

g_blnMenuReady := true

strLanguageCodePrev := ""
strThemePrev := ""
strActiveFileManagerSystemName := ""
strActiveFileManagerDisplayName := ""
blnActiveFileManangerOK := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonOptionsCancel:
;------------------------------------------------------------

loop, 4
	g_arrPopupHotkeys%A_Index% := g_arrPopupHotkeysPrevious%A_Index% ; revert to previous content of g_arrPopupHotkeys

Gosub, 2GuiClose

return
;------------------------------------------------------------



;========================================================================================================================
; END OF OPTIONS
;========================================================================================================================


;========================================================================================================================
!_030_FAVORITES_LIST:
;========================================================================================================================

;------------------------------------------------------------
BuildGui:
;------------------------------------------------------------

IniRead, strTextColor, %g_strIniFile%, Gui-%g_strTheme%, TextColor, 000000
IniRead, g_strGuiListviewBackgroundColor, %g_strIniFile%, Gui-%g_strTheme%, ListviewBackground, FFFFFF
IniRead, g_strGuiListviewTextColor, %g_strIniFile%, Gui-%g_strTheme%, ListviewText, 000000

lGuiFullTitle := L(lGuiTitle, g_strAppNameText, g_strAppVersion)
Gui, 1:New, +Resize -MinimizeBox +MinSize636x538, %lGuiFullTitle%

Gui, +LastFound
g_strAppHwnd := WinExist()

if (g_blnUseColors)
	Gui, 1:Color, %g_strGuiWindowColor%

; Order of controls important to avoid drawgins gliches when resizing

Gui, 1:Font, % "s12 w700 " . (g_blnUseColors ? "c" . strTextColor : ""), Verdana
Gui, 1:Add, Text, vf_lblAppName x0 y0, %g_strAppNameText% %g_strAppVersion%
Gui, 1:Font, s9 w400, Verdana
Gui, 1:Add, Text, vf_lblAppTagLine, %lAppTagline%

Gui, 1:Add, Picture, vf_picGuiAddFavorite gGuiAddFavoriteSelectType, %g_strTempDir%\add_property-48.png ; Static3
Gui, 1:Add, Picture, vf_picGuiEditFavorite gGuiEditFavorite x+1 yp, %g_strTempDir%\edit_property-48.png ; Static4
Gui, 1:Add, Picture, vf_picGuiRemoveFavorite gGuiRemoveFavorite x+1 yp, %g_strTempDir%\delete_property-48.png ; Static5
Gui, 1:Add, Picture, vf_picGuiCopyFavorite gGuiCopyFavorite x+1 yp, %g_strTempDir%\copy-48.png ; Static5
Gui, 1:Add, Picture, vf_picGuiHotkeysManage gGuiHotkeysManage x+1 yp, %g_strTempDir%\keyboard-48.png ; Static6
Gui, 1:Add, Picture, vf_picGuiOptions gGuiOptions x+1 yp, %g_strTempDir%\settings-32.png ; Static7
Gui, 1:Add, Picture, vf_picPreviousMenu gGuiGotoPreviousMenu hidden x+1 yp, %g_strTempDir%\left-12.png ; Static8
Gui, 1:Add, Picture, vf_picUpMenu gGuiGotoUpMenu hidden x+1 yp, %g_strTempDir%\up-12.png ; Static9
Gui, 1:Add, Picture, vf_picMoveFavoriteUp gGuiMoveFavoriteUp x+1 yp, %g_strTempDir%\up_circular-26.png ; Static10
Gui, 1:Add, Picture, vf_picMoveFavoriteDown gGuiMoveFavoriteDown x+1 yp, %g_strTempDir%\down_circular-26.png ; Static11
Gui, 1:Add, Picture, vf_picAddSeparator gGuiAddSeparator x+1 yp, %g_strTempDir%\separator-26.png ; Static12
Gui, 1:Add, Picture, vf_picAddColumnBreak gGuiAddColumnBreak x+1 yp, %g_strTempDir%\column-26.png ; Static13
; OUT Gui, 1:Add, Picture, vpicSortFavorites gGuiSortFavorites x+1 yp, %g_strTempDir%\generic_sorting2-26-grey.png ; Static14
Gui, 1:Add, Picture, vf_picGuiAbout gGuiAbout x+1 yp, %g_strTempDir%\about-32.png ; Static15
Gui, 1:Add, Picture, vf_picGuiHelp gGuiHelp x+1 yp, %g_strTempDir%\help-32.png ; Static16

Gui, 1:Font, s8 w400, Arial ; button legend
Gui, 1:Add, Text, vf_lblGuiOptions gGuiOptions x0 y+20, %lGuiOptions% ; Static17
Gui, 1:Add, Text, vf_lblGuiAddFavorite center gGuiAddFavoriteSelectType x+1 yp, %lGuiAddFavorite% ; Static18
Gui, 1:Add, Text, vf_lblGuiEditFavorite center gGuiEditFavorite x+1 yp w88, %lGuiEditFavorite% ; Static19, w88 to make room fot when multiple favorites are selected
Gui, 1:Add, Text, vf_lblGuiRemoveFavorite center gGuiRemoveFavorite x+1 yp, %lGuiRemoveFavorite% ; Static20
Gui, 1:Add, Text, vf_lblGuiCopyFavorite center gGuiCopyFavorite x+1 yp, %lDialogCopy% ; Static20
Gui, 1:Add, Text, vf_lblGuiHotkeysManage center gGuiHotkeysManage x+1 yp, %lDialogHotkeys% ; Static21
Gui, 1:Add, Text, vf_lblGuiAbout center gGuiAbout x+1 yp, %lGuiAbout% ; Static22
Gui, 1:Add, Text, vf_lblGuiHelp center gGuiHelp x+1 yp, %lGuiHelp% ; Static23

Gui, 1:Font, s8 w400 italic, Verdana
Gui, 1:Add, Link, vf_lnkGuiHotkeysHelpClicked gGuiHotkeysHelpClicked x0 y+1, <a>%lGuiHotkeysHelp%</a> ; center option not working SysLink1
Gui, 1:Add, Link, vf_lnkGuiDropHelpClicked gGuiDropFilesHelpClicked right x+1 yp, <a>%lGuiDropFilesHelp%</a> ; SysLink2

Gui, 1:Font, s8 w400 normal, Verdana
Gui, 1:Add, Text, vf_lblSubmenuDropdownLabel x+1 yp, %lGuiSubmenuDropdownLabel%
Gui, 1:Add, DropDownList, vf_drpMenusList gGuiMenusListChanged x0 y+1

Gui, 1:Add, ListView
	, % "vf_lvFavoritesList Count32 AltSubmit NoSortHdr LV0x10 " . (g_blnUseColors ? "c" . g_strGuiListviewTextColor . " Background" . g_strGuiListviewBackgroundColor : "") . " gGuiFavoritesListEvents x+1 yp"
	, %lGuiLvFavoritesHeader%

Gui, 1:Font, s9 w600, Verdana
Gui, 1:Add, Button, vf_btnGuiSaveFavorites Disabled Default gGuiSaveFavorites x200 y400 w100 h50, %lGuiSave% ; Button1
Gui, 1:Add, Button, vf_btnGuiCancel gGuiCancel x350 yp w100 h50, %lGuiClose% ; Close until changes occur - Button2

if !(g_blnDonor)
{
	strDonateButtons := "thumbs_up|solutions|handshake|conference|gift"
	StringSplit, arrDonateButtons, strDonateButtons, |
	Random, intDonateButton, 1, 5

	Gui, 1:Add, Picture, vf_picGuiDonate gGuiDonate x0 y+1, % g_strTempDir . "\" . arrDonateButtons%intDonateButton% . "-32.png" ; Static25
	Gui, 1:Font, s8 w400, Arial ; button legend
	Gui, 1:Add, Text, vf_lblGuiDonate center gGuiDonate x0 y+1, %lGuiDonate% ; Static26
}

IniRead, strSettingsPosition, %g_strIniFile%, Global, SettingsPosition, -1 ; center at minimal size
StringSplit, arrSettingsPosition, strSettingsPosition, |

Gui, 1:Show, % "Hide "
	. (arrSettingsPosition1 = -1 or arrSettingsPosition1 = "" or arrSettingsPosition2 = ""
	? "center w636 h538"
	: "x" . arrSettingsPosition1 . " y" . arrSettingsPosition2)
sleep, 100
if (arrSettingsPosition1 <> -1)
	WinMove, ahk_id %g_strAppHwnd%, , , , %arrSettingsPosition3%, %arrSettingsPosition4%

strSettingsPosition := ""
arrSettingsPosition := ""
strTextColor := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
LoadMenuInGui:
LoadMenuInGuiFromPower:
;------------------------------------------------------------

Gui, 1:ListView, f_lvFavoritesList
LV_Delete()

Loop, % g_objMenuInGui.MaxIndex()
	
	if InStr("Menu|Group", g_objMenuInGui[A_Index].FavoriteType) ; this is a menu or a group
		LV_Add(, g_objMenuInGui[A_Index].FavoriteName, g_objFavoriteTypesShortNames[g_objMenuInGui[A_Index].FavoriteType]
			, (g_objMenuInGui[A_Index].FavoriteType = "Menu" ? g_strMenuPathSeparator : " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix))
	
	else if (g_objMenuInGui[A_Index].FavoriteType = "X") ; this is a separator
		LV_Add(, g_strGuiMenuSeparator, g_strGuiMenuSeparatorShort, g_strGuiMenuSeparator . g_strGuiMenuSeparator)
	
	else if (g_objMenuInGui[A_Index].FavoriteType = "K") ; this is a column break
		LV_Add(, g_strGuiDoubleLine . " " . lMenuColumnBreak . " " . g_strGuiDoubleLine
		, g_strGuiDoubleLine, g_strGuiDoubleLine . " " . lMenuColumnBreak . " " . g_strGuiDoubleLine)
		
	else if (g_objMenuInGui[A_Index].FavoriteType = "B") ; this is a back link
		LV_Add(, g_objMenuInGui[A_Index].FavoriteName, "   ..   " , "")
		
	else ; this is a folder, document, URL or application
		LV_Add(, g_objMenuInGui[A_Index].FavoriteName, g_objFavoriteTypesShortNames[g_objMenuInGui[A_Index].FavoriteType], g_objMenuInGui[A_Index].FavoriteLocation)

LV_Modify((A_ThisLabel = "LoadMenuInGuiFromPower" ? g_intOriginalMenuPosition : 1 + (g_objMenuInGui[1].FavoriteType = "B" ? 1 : 0)), "Select Focus") 

Gosub, AdjustColumnsWidth

GuiControl, , f_drpMenusList, % "|" . RecursiveBuildMenuTreeDropDown(g_objMainMenu, g_objMenuInGui.MenuPath) . "|"

GuiControl, Focus, f_lvFavoritesList

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiSize:
;------------------------------------------------------------

if (A_EventInfo = 1)  ; The window has been minimized.  No action needed.
    return

g_intListW := A_GuiWidth - 40 - 88
intListH := A_GuiHeight - 115 - 132

intButtonSpacing := (g_intListW - (100 * 2)) // 3

for intIndex, objGuiControl in g_objGuiControls
{
	intX := objGuiControl.X
	intY := objGuiControl.Y

	if (intX < 0)
		intX:= A_GuiWidth + intX
	if (intY < 0)
		intY := A_GuiHeight + intY

	if (objGuiControl.Center)
	{
		GuiControlGet, arrPos, Pos, % objGuiControl.Name
		intX := intX - (arrPosW // 2) ; Floor divide
	}

	if (objGuiControl.Name = "f_lnkGuiDropHelpClicked")
	{
		GuiControlGet, arrPos, Pos, f_lnkGuiDropHelpClicked
		intX := intX - arrPosW
	}
	else if (objGuiControl.Name = "f_btnGuiSaveFavorites")
		intX := 40 + intButtonSpacing
	else if (objGuiControl.Name = "f_btnGuiCancel")
		intX := 40 + (2 * intButtonSpacing) + 100
		
	GuiControl, % "1:Move" . (objGuiControl.Draw ? "Draw" : ""), % objGuiControl.Name, % "x" . intX	.  " y" . intY
		
}

GuiControl, 1:Move, f_drpMenusList, w%g_intListW%
GuiControl, 1:Move, f_lvFavoritesList, w%g_intListW% h%intListH%

Gosub, AdjustColumnsWidth

intListH := ""
intButtonSpacing := ""
intIndex := ""
objGuiControl := ""
intX := ""
intY := ""
arrPos := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiHotkeysHelpClicked:
;------------------------------------------------------------
Gui, 1:+OwnDialogs

MsgBox, 0, %g_strAppNameText% - %lGuiHotkeysHelp%
	, %lGuiHotkeysHelpText%

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiDropFilesHelpClicked:
;------------------------------------------------------------
Gui, 1:+OwnDialogs

MsgBox, 0, %g_strAppNameText% - %lGuiDropFilesHelp%
	, % L(lGuiDropFilesIncentive, g_strAppNameText, lDialogFolderLabel, lDialogFileLabel, lDialogApplicationLabel)

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoritesListEvents:
;------------------------------------------------------------

Gui, 1:ListView, f_lvFavoritesList

if (A_GuiEvent = "DoubleClick")
{
	g_intOriginalMenuPosition := LV_GetNext()
	if StrLen(g_objMenuInGui[g_intOriginalMenuPosition].FavoriteType) and InStr("Menu|Group", g_objMenuInGui[g_intOriginalMenuPosition].FavoriteType)
		Gosub, OpenMenuFromGuiHotkey
	else if (g_objMenuInGui[g_intOriginalMenuPosition].FavoriteType = "B")
		Gosub, GuiGotoUpMenu
	else
		gosub, GuiEditFavorite
}
else if (A_GuiEvent = "I") ; Item changed, change Edit button label
{
	g_intFavoriteSelected := LV_GetCount("Selected")
	if (g_intFavoriteSelected > 1)
	{
		GuiControl, , f_lblGuiEditFavorite, % lGuiMove . " (" . g_intFavoriteSelected . ")"
		GuiControl, +gGuiMoveMultipleFavoritesToMenu, f_lblGuiEditFavorite
		GuiControl, +gGuiMoveMultipleFavoritesToMenu, f_picGuiEditFavorite
		GuiControl, , f_lblGuiRemoveFavorite, % lGuiRemoveFavorite . " (" . g_intFavoriteSelected . ")"
		GuiControl, +gGuiRemoveMultipleFavorites, f_lblGuiRemoveFavorite
		GuiControl, +gGuiRemoveMultipleFavorites, f_picGuiRemoveFavorite
		GuiControl, +gGuiMoveMultipleFavoritesUp, f_picMoveFavoriteUp
		GuiControl, +gGuiMoveMultipleFavoritesDown, f_picMoveFavoriteDown
	}
	else
	{
		GuiControl, , f_lblGuiEditFavorite, %lGuiEditFavorite%
		GuiControl, +gGuiEditFavorite, f_lblGuiEditFavorite
		GuiControl, +gGuiEditFavorite, f_picGuiEditFavorite
		GuiControl, , f_lblGuiRemoveFavorite, %lGuiRemoveFavorite%
		GuiControl, +gGuiRemoveFavorite, f_lblGuiRemoveFavorite
		GuiControl, +gGuiRemoveFavorite, f_picGuiRemoveFavorite
		GuiControl, +gGuiMoveFavoriteUp, f_picMoveFavoriteUp
		GuiControl, +gGuiMoveFavoriteDown, f_picMoveFavoriteDown
	}
}

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddFavoriteSelectType:
;------------------------------------------------------------

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide
g_intOriginalMenuPosition := (LV_GetCount() ? (LV_GetNext() ? LV_GetNext() : 0xFFFF) : 1)

Gui, 2:New, , % L(lDialogAddFavoriteSelectTitle, g_strAppNameText, g_strAppVersion)
Gui, 2:+Owner1
Gui, 2:+OwnDialogs
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%

Gui, 2:Add, Text, x10 y+20, %lDialogAdd%:
Gui, 2:Add, Text, x+10 yp section

loop, %g_arrFavoriteTypes0%
	Gui, 2:Add, Radio, % (A_Index = 1 ? " vf_intRadioFavoriteType yp " : (A_Index = 7 or A_Index = 8? "y+15 " : "")) . "xs gFavoriteSelectTypeRadioButtonsChanged", % g_objFavoriteTypesLabels[g_arrFavoriteTypes%A_Index%]

Gui, 2:Add, Button, x+20 y+20 vf_btnAddFavoriteSelectTypeContinue gGuiAddFavoriteSelectTypeContinue default, %lDialogContinue%
Gui, 2:Add, Button, yp vf_btnAddFavoriteSelectTypeCancel gGuiEditFavoriteCancel, %lGuiCancel%
Gui, Add, Text
Gui, 2:Add, Text, % "xs+120 ys vf_lblAddFavoriteTypeHelp w250 h" . g_arrFavoriteTypes0 * 20, % L(lDialogFavoriteSelectType, lDialogContinue)

GuiCenterButtons(L(lDialogAddFavoriteSelectTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnAddFavoriteSelectTypeContinue", "f_btnAddFavoriteSelectTypeCancel")
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
FavoriteSelectTypeRadioButtonsChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

if (g_arrFavoriteTypes%f_intRadioFavoriteType% = "QAP")
	GuiControl, , f_lblAddFavoriteTypeHelp, % L(g_objFavoriteTypesHelp["QAP"], lMenuRecentFolders, lMenuCurrentFolders, lMenuAddThisFolder, lMenuClipboard, lMenuSettings)
else
	GuiControl, , f_lblAddFavoriteTypeHelp, % g_objFavoriteTypesHelp[g_arrFavoriteTypes%f_intRadioFavoriteType%]

if (A_GuiEvent = "DoubleClick")
	Gosub, GuiAddFavoriteSelectTypeContinue

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddFavoriteSelectTypeContinue:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

; GuiControl, , f_lblAddFavoriteTypeHelp, % g_objFavoriteTypesHelp[] ; OUT OK?

g_strAddFavoriteType := g_arrFavoriteTypes%f_intRadioFavoriteType%

Gosub, GuiAddFavorite

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiDropFiles:
;------------------------------------------------------------

Loop, parse, A_GuiEvent, `n
{
    g_strNewLocation = %A_LoopField%
    Break
}

g_intOriginalMenuPosition := (LV_GetCount() ? (LV_GetNext() ? LV_GetNext() : 0xFFFF) : 1)
Gosub, GuiAddFromDropFiles

return
;------------------------------------------------------------


;------------------------------------------------------------
AddThisFolder:
;------------------------------------------------------------

g_strNewLocation := ""

if WindowIsExplorer(g_strTargetClass) or WindowIsTotalCommander(g_strTargetClass) or WindowIsDirectoryOpus(g_strTargetClass)
	or WindowIsDialog(g_strTargetClass, g_strTargetWinId)
{
	if WindowIsDirectoryOpus(g_strTargetClass)
	{
		Gosub, InitDOpusListText
		objDOpusListers := CollectDOpusListersList(g_strDOpusListText) ; list all listers, excluding special folders like Recycle Bin
		
		; From leo @ GPSoftware (http://resource.dopus.com/viewtopic.php?f=3&t=23013):
		; Lines will have active_lister="1" if they represent tabs from the active lister.
		; To get the active tab you want the line with active_lister="1" and tab_state="1".
		; tab_state="1" means it's the selected tab, on the active side of the lister.
		; tab_state="2" means it's the selected tab, on the inactive side of a dual-display lister.
		; Tabs which are not visible (because another tab is selected on top of them) don't get a tab_state attribute at all.

		for intIndex, objLister in objDOpusListers
			if (objLister.active_lister = "1" and objLister.tab_state = "1") ; this is the active tab
			{
				g_strNewLocation := objLister.LocationURL
				break
			}
	}
	else ; Explorer, TotalCommander or dialog boxes
	{
		objPrevClipboard := ClipboardAll ; Save the entire clipboard
		ClipBoard := ""

		; Under Windows 7 and 8.1 (not tested with Windows 10)...
		; With Explorer, the key sequence {F4}{Esc} selects the current location of the window.
		; With dialog boxes, the key sequence {F4}{Esc} generally selects the current location of the window. But, in some
		; dialog boxes, the {Esc} key closes the dialog box. We will check window title to detect this behavior.

		if (g_strTargetClass = "#32770")
			intWaitTimeIncrement := 300 ; time allowed for dialog boxes
		else
			intWaitTimeIncrement := 150 ; time allowed for Explorer

		if (g_blnDiagMode)
			intTries := 8
		else
			intTries := 3

		strAddThisFolderWindowTitle := ""
		Loop, %intTries%
		{
			Sleep, intWaitTimeIncrement * A_Index
			WinGetTitle, strAddThisFolderWindowTitle, A ; to check later if this window is closed unexpectedly
		} Until (StrLen(strAddThisFolderWindowTitle))

		if WindowIsTotalCommander(g_strTargetClass)
		{
			cm_CopySrcPathToClip := 2029
			SendMessage, 0x433, %cm_CopySrcPathToClip%, , , ahk_class TTOTAL_CMD ; 
			WinGetTitle, strWindowActiveTitle, A ; to check if the window was closed unexpectedly
		}
		else ; Explorer or dialog boxes
			Loop, %intTries%
			{
				Sleep, intWaitTimeIncrement * A_Index
				SendInput, {F4}{Esc} ; F4 move the caret the "Go To A Different Folder box" and {Esc} select it content ({Esc} could be replaced by ^a to Select All)
				Sleep, intWaitTimeIncrement * A_Index
				SendInput, ^c ; Copy
				Sleep, intWaitTimeIncrement * A_Index
				intTries := A_Index ; for debug only
				WinGetTitle, strWindowActiveTitle, A ; to check if the window was closed unexpectedly
			} Until (StrLen(ClipBoard) or (strAddThisFolderWindowTitle <> strWindowActiveTitle))

		g_strNewLocation := ClipBoard
		Clipboard := objPrevClipboard ; Restore the original clipboard
		
		if (g_blnDiagMode)
		{
			Diag("Menu", A_ThisLabel)
			Diag("Class", g_strTargetClass)
			Diag("Tries", intTries)
			Diag("AddedFolder", g_strNewLocation)
		}
	}
		
}

g_strNewLocationSpecialName := ""
if g_objClassIdOrPathByDefaultName.HasKey(g_strNewLocation)
{
	; we have a known special folder (there are not yet known like "Biblioth�ques\Images" or "Libraries\Pictures")
	g_strNewLocationSpecialName := g_strNewLocation
	g_strNewLocation := g_objClassIdOrPathByDefaultName[g_strNewLocation]
}

If !StrLen(g_strNewLocation)
	or !(InStr(g_strNewLocation, ":") or InStr(g_strNewLocation, "\\") or  InStr(g_strNewLocation, "{"))
	or (strAddThisFolderWindowTitle <> strWindowActiveTitle)
{
	Gui, 1:+OwnDialogs 
	MsgBox, 52, % L(lDialogAddFolderManuallyTitle, g_strAppNameText, g_strAppVersion), %lDialogAddFolderManuallyPrompt%
	IfMsgBox, Yes
	{
		Gosub, GuiShow
		g_strAddFavoriteType := "Folder"
		Gosub, GuiAddFavorite
	}
}
else
{
	Gosub, GuiShow
	g_intOriginalMenuPosition := 0xFFFF
	Gosub, GuiAddThisFolder
}

objDOpusListers := ""
objPrevClipboard := ""
strAddThisFolderWindowTitle := ""
intWaitTimeIncrement := ""
intTries := ""

return
;------------------------------------------------------------


;========================================================================================================================
; END OF FAVORITES_LIST
;========================================================================================================================


;========================================================================================================================
!_032_FAVORITE_GUI:
;========================================================================================================================

;------------------------------------------------------------
GuiAddFavorite:
GuiAddThisFolder:
GuiAddFromDropFiles:
GuiEditFavorite:
GuiEditFavoriteFromPower:
GuiCopyFavorite:
;------------------------------------------------------------

strGuiFavoriteLabel := A_ThisLabel
g_blnAbordEdit := false

Gosub, GuiFavoriteInit
if (g_blnAbordEdit)
{
	gosub, GuiAddFavoriteCleanup
	return
}

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide
if (strGuiFavoriteLabel = "GuiAddFavorite")
	Gosub, 2GuiClose ; to avoid flashing Gui 1:

Gui, 2:New, , % L(lDialogAddEditFavoriteTitle, (InStr(strGuiFavoriteLabel, "GuiEditFavorite") ? lDialogEdit : (strGuiFavoriteLabel = "GuiCopyFavorite" ? lDialogCopy : lDialogAdd)), g_strAppNameText, g_strAppVersion, g_objEditedFavorite.FavoriteType)
Gui, 2:+Owner1
Gui, 2:+OwnDialogs
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%

g_strTypesForTabWindowOptions := "Folder|Document|Application|Special|Link|FTP"
g_strTypesForTabAdvancedOptions := "Folder|Document|Application|Special|URL|FTP|Group"

Gui, 2:Add, Tab2, vf_intAddFavoriteTab w420 h380 gGuiAddFavoriteTabChanged AltSubmit, % " " . BuildTabsList(g_objEditedFavorite.FavoriteType) . " "
intTabNumber := 0

blnIsGroupMember := InStr(g_objMenuInGui.MenuPath, g_strGroupIndicatorPrefix)

; ------ BUILD TABS ------

Gosub, GuiFavoriteTabBasic

Gosub, GuiFavoriteTabMenuOptions

Gosub, GuiFavoriteTabWindowOptions

Gosub, GuiFavoriteTabAdvancedSettings

; ------ TABS End ------

Gui, 2:Tab

if InStr(strGuiFavoriteLabel, "GuiEditFavorite")
{
	Gui, 2:Add, Button, y420 vf_btnEditFavoriteSave gGuiEditFavoriteSave default, %lDialogOK%
	Gui, 2:Add, Button, yp vf_btnEditFavoriteCancel gGuiEditFavoriteCancel, %lGuiCancel%
	
	GuiCenterButtons(L(lDialogAddEditFavoriteTitle, lDialogEdit, g_strAppNameText, g_strAppVersion, g_objEditedFavorite.FavoriteType), 10, 5, 20, "f_btnEditFavoriteSave", "f_btnEditFavoriteCancel")
}
else if InStr(strGuiFavoriteLabel, "GuiCopyFavorite")
{
	Gui, 2:Add, Button, y400 vf_btnCopyFavoriteCopy gGuiCopyFavoriteSave default, %lDialogCopy%
	Gui, 2:Add, Button, yp vf_btnAddFavoriteCancel gGuiAddFavoriteCancel, %lGuiCancel%
	
	GuiCenterButtons(L(lDialogAddEditFavoriteTitle, lDialogCopy, g_strAppNameText, g_strAppVersion, g_objEditedFavorite.FavoriteType), 10, 5, 20, "f_btnCopyFavoriteCopy", "f_btnAddFavoriteCancel")
}
else
{
	Gui, 2:Add, Button, y400 vf_btnAddFavoriteAdd gGuiAddFavoriteSave default, %lDialogAdd%
	Gui, 2:Add, Button, yp vf_btnAddFavoriteCancel gGuiAddFavoriteCancel, %lGuiCancel%
	
	GuiCenterButtons(L(lDialogAddEditFavoriteTitle, lDialogAdd, g_strAppNameText, g_strAppVersion, g_objEditedFavorite.FavoriteType), 10, 5, 20, "f_btnAddFavoriteAdd", "f_btnAddFavoriteCancel")
}

if InStr("Folder|Document|Application", g_objEditedFavorite.FavoriteType)
	GuiControl, 2:+Default, f_btnSelectFolderLocation
else
	GuiControl, 2:+Default, f_btnAddFavoriteAdd

if InStr("Special|QAP", g_objEditedFavorite.FavoriteType)
	GuiControl, 2:Focus, % "f_drp" . g_objEditedFavorite.FavoriteType
else
{
	GuiControl, 2:Focus, f_strFavoriteShortName
	if InStr(strGuiFavoriteLabel, "GuiEditFavorite") 
		SendInput, ^a
}

Gosub, DropdownParentMenuChanged ; to init the content of menu items

Gui, 2:Add, Text
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

GuiAddFavoriteCleanup:
blnIsGroupMember := ""
strGuiFavoriteLabel := ""
arrTop := ""
g_strNewLocation := ""
g_blnAbordEdit := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
BuildTabsList(strFavoriteType)
;------------------------------------------------------------
{
	global

	; 1 Basic Settings, 2 Menu Options, 3 Window Options, 4 Advanced Settings
	strTabsList := g_arrFavoriteGuiTabs1 . " | " . g_arrFavoriteGuiTabs2
	
	if InStr(g_strTypesForTabWindowOptions, strFavoriteType)
		strTabsList .= " | " . g_arrFavoriteGuiTabs3
	if InStr(g_strTypesForTabAdvancedOptions, strFavoriteType)
		strTabsList .= " | " . g_arrFavoriteGuiTabs4
	
	strTabsList .= " "
	
	return strTabsList
}
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteInit:
;------------------------------------------------------------
; Icon resource in the format "iconfile,index", examnple "shell32.dll,2"
; g_strDefaultIconResource -> default icon for the current type of favorite
; g_strNewFavoriteIconResource -> icon currently displayed in the Add/Edit dialog box

; g_strNewFavoriteHotkey -> actual hotkey in internal format displayed as text in the Add/Edit dialog box

; when edit favorite, keep original values in g_objEditedFavorite
; when add favorite, put initial or default values in g_objEditedFavorite and update them when gui save

g_objEditedFavorite := Object()
g_strDefaultIconResource := ""
g_strNewFavoriteIconResource := ""
strGroupSettings := ",,,,,,," ; ,,, to make sure all fields are re-init
StringSplit, g_arrGroupSettingsGui, strGroupSettings, `,

if InStr(strGuiFavoriteLabel, "GuiEditFavorite") or (strGuiFavoriteLabel = "GuiCopyFavorite")
{
	Gui, 1:ListView, f_lvFavoritesList
	g_intOriginalMenuPosition := LV_GetNext()

	if !(g_intOriginalMenuPosition)
	{
		Oops(lDialogSelectItemToEdit)
		g_blnAbordEdit := true
		return
	}
	
	if (strGuiFavoriteLabel = "GuiCopyFavorite")
	{
		g_objEditedFavorite := Object()
		for strKey, strValue in g_objMenuInGui[g_intOriginalMenuPosition]
			g_objEditedFavorite[strKey] := strValue
	}
	else
		g_objEditedFavorite := g_objMenuInGui[g_intOriginalMenuPosition]
	
	if (g_objEditedFavorite.FavoriteType = "B")
		g_blnAbordEdit := true
	else if InStr("X|K", g_objEditedFavorite.FavoriteType) ; favorite is menu separator or column break
		g_blnAbordEdit := true
	else if (strGuiFavoriteLabel = "GuiCopyFavorite" and InStr("Menu|Group", g_objEditedFavorite.FavoriteType)) ; menu or group cannot be copied
		g_blnAbordEdit := true
	
	if (g_blnAbordEdit = true)
		return

	g_strNewFavoriteIconResource := g_objEditedFavorite.FavoriteIconResource
	g_strNewFavoriteWindowPosition := g_objEditedFavorite.FavoriteWindowPosition
	g_blnNewFavoriteFtpEncoding := g_objEditedFavorite.FavoriteFtpEncoding

	if (strGuiFavoriteLabel = "GuiCopyFavorite")
		g_strNewFavoriteHotkey := "None" ; copied favorite has no hotkey
	else
		g_strNewFavoriteHotkey := g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation]

	if (g_objEditedFavorite.FavoriteType = "Group")
	{
	   ; 1 boolean value (replace existing Explorer windows if true, add to existing Explorer Windows if false)
	   ; 2 restore folders with "Explorer" or "Other" (Directory Opus, Total Commander or QAPconnect)
	   ; 3 delay in milliseconds to insert between each favorite to restore
		strGroupSettings := g_objEditedFavorite.FavoriteGroupSettings . ",,,," ; ,,, to make sure all fields are re-init
		StringSplit, g_arrGroupSettingsGui, strGroupSettings, `,
	}
}
else
{
	if (strGuiFavoriteLabel = "GuiAddThisFolder")
	{
		WinGetPos, intX, intY, intWidth, intHeight, ahk_id %g_strTargetWinId%
		WinGet, intMinMax, MinMax, ahk_id %g_strTargetWinId% ; -1: minimized, 1: maximized, 0: neither minimized nor maximized
		; Boolean,MinMax,Left,Top,Width,Height,Delay (comma delimited)
		; 0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height; for example: "1,0,100,50,640,480,200"
		g_strNewFavoriteWindowPosition := "1," . intMinMax . "," . intX . "," . intY . "," . intWidth . "," . intHeight . ",200"
	}
	else
		g_strNewFavoriteWindowPosition := ",,,,,,," ; to avoid having phantom values

	if InStr("GuiAddThisFolder|GuiAddFromDropFiles", strGuiFavoriteLabel)
	{
		; g_strNewLocation is received from AddThisFolder or GuiDropFiles
		g_objEditedFavorite.FavoriteLocation := g_strNewLocation
		g_objEditedFavorite.FavoriteName := (StrLen(g_strNewLocationSpecialName) ? g_strNewLocationSpecialName : GetDeepestFolderName(g_strNewLocation))
	}
	g_strNewFavoriteHotkey := "None" ; internal name

	if (strGuiFavoriteLabel = "GuiAddFavorite")
		g_objEditedFavorite.FavoriteType := g_strAddFavoriteType
	else if (strGuiFavoriteLabel = "GuiAddThisFolder")
		g_objEditedFavorite.FavoriteType := (StrLen(g_strNewLocationSpecialName) ? "Special" : "Folder")
	else if (strGuiFavoriteLabel = "GuiAddFromDropFiles")
	{
		SplitPath, g_strNewLocation, , , strExtension
		if StrLen(strExtension) and InStr("exe|com|bat", strExtension)
			g_objEditedFavorite.FavoriteType := "Application"
		else if LocationIsDocument(g_strNewLocation)
			g_objEditedFavorite.FavoriteType := "Document"
		else
			g_objEditedFavorite.FavoriteType := "Folder"
	}
	
	if (g_strAddFavoriteType = "FTP")
		g_blnNewFavoriteFtpEncoding := true
}

Gosub, GuiFavoriteIconDefault

intX := ""
intY := ""
intWidth := ""
intHeight := ""
intMinMax := ""
strGroupSettings := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteTabBasic:
;------------------------------------------------------------

Gui, 2:Tab, % ++intTabNumber

Gui, 2:Font, w700
Gui, 2:Add, Text, x20 y40 w400, % lDialogFavoriteType . ": " . g_objFavoriteTypesLabels[g_objEditedFavorite.FavoriteType]
Gui, 2:Font

if (g_objEditedFavorite.FavoriteType = "QAP")
	Gui, 2:Add, Text, x20 y+10 w400, % ReplaceAllInString(L(g_objFavoriteTypesHelp["QAP"], lMenuRecentFolders, lMenuCurrentFolders, lMenuAddThisFolder, lMenuSettings, lGuiOptions), "`n`n", "`n")
else
	Gui, 2:Add, Text, x20 y+10 w400, % "> " . ReplaceAllInString(g_objFavoriteTypesHelp[g_objEditedFavorite.FavoriteType], "`n`n", "`n> ")

if (g_objEditedFavorite.FavoriteType = "QAP")
	Gui, 2:Add, Edit, x20 y+0 vf_strFavoriteShortName hidden, % g_objEditedFavorite.FavoriteName ; not allow to change favorite short name for QAP feature favorites
else
{
	Gui, 2:Add, Text, x20 y+20, % L(lDialogFavoriteShortNameLabel, g_objFavoriteTypesLabels[g_objEditedFavorite.FavoriteType]) . " *"

	Gui, 2:Add, Edit
		, % "x20 y+10 Limit250 vf_strFavoriteShortName w" . 300 - (g_objEditedFavorite.FavoriteType = "Menu" ? 50 : 0)
		, % g_objEditedFavorite.FavoriteName
}

if (g_objEditedFavorite.FavoriteType = "Menu" and InStr(strGuiFavoriteLabel, "GuiEditFavorite"))
	Gui, 2:Add, Button, x+10 yp gGuiOpenThisMenu, %lDialogOpenThisMenu%

if !InStr("Special|QAP", g_objEditedFavorite.FavoriteType)
{
	if !InStr("Menu|Group", g_objEditedFavorite.FavoriteType)
	{
		Gui, 2:Add, Text, x20 y+10, % g_objFavoriteTypesLocationLabels[g_objEditedFavorite.FavoriteType] . " *"
		Gui, 2:Add, Edit, x20 y+10 w300 h20 vf_strFavoriteLocation gEditFavoriteLocationChanged, % g_objEditedFavorite.FavoriteLocation
		if InStr("Folder|Document|Application", g_objEditedFavorite.FavoriteType)
			Gui, 2:Add, Button, x+10 yp gButtonSelectFavoriteLocation vf_btnSelectFolderLocation, %lDialogBrowseButton%
		
		if (strGuiFavoriteLabel = "GuiCopyFavorite")
			g_objEditedFavorite.FavoriteLocation := "" ; to avoid side effect on original favorite hotkey
	}
	
	if (g_objEditedFavorite.FavoriteType = "Application")
	{
		Gui, 2:Add, Text, x20 y+20 vf_lblSelectRunningApplication, %lDialogBrowseOrSelectApplication%
		Gui, 2:Add, DropDownList, x20 y+5 w400 vf_drpRunningApplication gDropdownRunningApplicationChanged
			, % CollectRunningApplications(g_objEditedFavorite.FavoriteLocation)
	}
}
else ; "Special" or "QAP"
{
	Gui, 2:Add, Edit, x20 y+20 hidden section vf_strFavoriteLocation, % g_objEditedFavorite.FavoriteLocation ; hidden because set by DropdownSpecialChanged or DropdownQAPChanged
	Gui, 2:Add, Text, xs ys, % g_objFavoriteTypesLabels[g_objEditedFavorite.FavoriteType] . " *"

	Gui, 2:Add, DropDownList
		, % "x20 y+10 w300 vf_drp" . g_objEditedFavorite.FavoriteType . " gDropdown" . g_objEditedFavorite.FavoriteType . "Changed"
		, % lDialogSelectItemToAdd . "...||" . (g_objEditedFavorite.FavoriteType = "Special" ? g_strSpecialFoldersList : g_strQAPFeaturesList)
	if InStr(strGuiFavoriteLabel, "GuiEditFavorite") or StrLen(g_strNewLocationSpecialName)
		if (g_objEditedFavorite.FavoriteType = "Special")
			GuiControl, ChooseString, f_drpSpecial, % g_objSpecialFolders[g_objEditedFavorite.FavoriteLocation].DefaultName
		else ; QAP
			GuiControl, ChooseString, f_drpQAP, % g_objQAPFeatures[g_objEditedFavorite.FavoriteLocation].LocalizedName
}

if (g_objEditedFavorite.FavoriteType = "FTP")
{
	Gui, 2:Add, Text, x20 y+5, %lGuiLoginName%
	Gui, 2:Add, Text, x180 yp, %lGuiPassword%
	
	Gui, 2:Add, Edit, x20 y+5 w140 h20 vf_strFavoriteLoginName, % g_objEditedFavorite.FavoriteLoginName
	Gui, 2:Add, Edit, x180 yp w140 h20 Password vf_strFavoritePassword, % g_objEditedFavorite.FavoritePassword
	Gui, 2:Add, Text, x20 y+5, %lGuiPasswordNotEncripted%
}

if (g_objEditedFavorite.FavoriteType = "Group")
{
	Gui, 2:Add, Text, x20 y+20, %lGuiGroupSaveRestoreOption%
	Gui, 2:Add, Radio, % "x20 y+10 vf_blnRadioGroupAdd " . (g_arrGroupSettingsGui1 ? "" : "checked"), %lGuiGroupSaveAddWindowsLabel%
	Gui, 2:Add, Radio, % "x20 y+5 vf_blnRadioGroupReplace " . (g_arrGroupSettingsGui1 ? "checked" : ""), %lGuiGroupSaveReplaceWindowsLabel%

	if (g_intActiveFileManager = 2 or g_intActiveFileManager = 3) ; DirectoryOpus or TotalCommander
	{
		Gui, 2:Add, Text, x20 y+20, %lGuiGroupSaveRestoreWith%
		Gui, 2:Add, Radio, % "x20 y+10 vf_blnRadioGroupRestoreWithExplorer " . (g_arrGroupSettingsGui2 = "Windows Explorer" ? "checked" : ""), Windows Explorer
		Gui, 2:Add, Radio, % "x20 y+5 vf_blnRadioGroupRestoreWithOther " . (g_arrGroupSettingsGui2 <> "Windows Explorer" ? "checked" : "")
			, % g_arrActiveFileManagerDisplayNames%g_intActiveFileManager% ; will be selected by default if empty (when Add)
	}
}

if InStr("Folder|Special|FTP", g_objEditedFavorite.FavoriteType) ; when adding folders or FTP sites
	and (g_intActiveFileManager = 2 or g_intActiveFileManager = 3) ; in Directory Opus or TotalCommander
	and (blnIsGroupMember) ; in a group
{
	;  0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height, Delay, RestoreSide; for example: "0,,,,,,,L"
	StringSplit, arrNewFavoriteWindowPosition, g_strNewFavoriteWindowPosition, `,
	
	Gui, 2:Add, Text, x20 y+20, % L(lGuiGroupRestoreSide, (g_intActiveFileManager = 2 ? "Directory Opus" : "Total Commander"))
	Gui, 2:Add, Radio, % "x+10 yp vf_intRadioGroupRestoreSide " . (arrNewFavoriteWindowPosition8 <> "R" ? "checked" : ""), %lDialogWindowPositionLeft% ; if "L" or ""
	Gui, 2:Add, Radio, % "x+10 yp " . (arrNewFavoriteWindowPosition8 = "R" ? "checked" : ""), %lDialogWindowPositionRight%
}

arrNewFavoriteWindowPosition := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteTabMenuOptions:
;------------------------------------------------------------

Gui, 2:Tab, % ++intTabNumber

Gui, 2:Add, Text, x20 y40 vf_lblFavoriteParentMenu
	, % (g_objEditedFavorite.FavoriteType = "Menu" ? lDialogSubmenuParentMenu : lDialogFavoriteParentMenu)
Gui, 2:Add, DropDownList, x20 y+5 w300 vf_drpParentMenu gDropdownParentMenuChanged
	, % RecursiveBuildMenuTreeDropDown(g_objMainMenu, g_objMenuInGui.MenuPath, (g_objEditedFavorite.FavoriteType = "Menu" ? lMainMenuName . " " . g_objEditedFavorite.FavoriteLocation : "")) . "|"

Gui, 2:Add, Text, x20 y+10 vf_lblFavoriteParentMenuPosition, %lDialogFavoriteMenuPosition%
Gui, 2:Add, DropDownList, x20 y+5 w290 vf_drpParentMenuItems AltSubmit

if !(blnIsGroupMember)
{
	Gui, 2:Add, Text, x20 y+20 gGuiPickIconDialog section, %lDialogIcon%
	Gui, 2:Add, Picture, x20 y+5 w32 h32 vf_picIcon gGuiPickIconDialog
	Gui, 2:Add, Text, x+5 yp vf_lblRemoveIcon gGuiRemoveIcon, X
	Gui, 2:Add, Link, x20 ys+57 gGuiPickIconDialog, <a>%lDialogSelectIcon%</a>

	Gui, 2:Add, Text, x20 y+20, %lDialogShortcut%
	Gui, 2:Add, Text, x20 y+5 w280 h23 0x1000 vf_strHotkeyText gButtonChangeFavoriteHotkey, % Hotkey2Text(g_strNewFavoriteHotkey)
	Gui, 2:Add, Button, yp x+10 gButtonChangeFavoriteHotkey, %lOptionsChangeHotkey%
}

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteTabWindowOptions:
;------------------------------------------------------------

; ###_V(A_ThisLabel, g_objEditedFavorite.FavoriteType)
if InStr(g_strTypesForTabWindowOptions, g_objEditedFavorite.FavoriteType)
{
	Gui, 2:Tab, % ++intTabNumber

	;  0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height, Delay, RestoreSide; for example: "1,0,100,50,640,480,200"
	StringSplit, arrNewFavoriteWindowPosition, g_strNewFavoriteWindowPosition, `,

	Gui, 2:Add, Checkbox, % "x20 y40 section vf_chkUseDefaultWindowPosition gCheckboxWindowPositionClicked " . (arrNewFavoriteWindowPosition1 ? "" : "checked"), %lDialogUseDefaultWindowPosition%
	
	Gui, 2:Add, Text, % "y+20 x20 section vf_lblWindowPositionState " . (arrNewFavoriteWindowPosition1 ? "" : "hidden"), %lDialogState%
	
	Gui, 2:Add, Radio, % "y+10 x20 vf_lblWindowPositionMinMax1 gRadioButtonWindowPositionMinMaxClicked" 
		. (arrNewFavoriteWindowPosition1 ? "" : " hidden") . (!arrNewFavoriteWindowPosition2 ? " checked" : ""), %lDialogNormal%
	Gui, 2:Add, Radio, % "y+10 x20 vf_lblWindowPositionMinMax2 gRadioButtonWindowPositionMinMaxClicked"
		. (arrNewFavoriteWindowPosition1 ? "" : " hidden") . (arrNewFavoriteWindowPosition2 = 1 ? " checked" : ""), %lDialogMaximized%
	Gui, 2:Add, Radio, % "y+10 x20 vf_lblWindowPositionMinMax3 gRadioButtonWindowPositionMinMaxClicked"
		. (arrNewFavoriteWindowPosition1 ? "" : " hidden") . (arrNewFavoriteWindowPosition2 = -1 ? " checked" : ""), %lDialogMinimized%

	Gui, 2:Add, Text, % "y+20 x20 vf_lblWindowPositionDelayLabel " . (arrNewFavoriteWindowPosition1 ? "" : "hidden"), %lDialogWindowPositionDelay%
	Gui, 2:Add, Edit, % "yp x+20 w36 center vf_lblWindowPositionDelay " . (arrNewFavoriteWindowPosition1 ? "" : "hidden"), % (arrNewFavoriteWindowPosition7 = "" ? 200 : arrNewFavoriteWindowPosition7)
	Gui, 2:Add, Text, % "x+10 yp vf_lblWindowPositionMillisecondsLabel " . (arrNewFavoriteWindowPosition1 ? "" : "hidden"), %lGuiGroupRestoreDelayMilliseconds%
	Gui, 2:Add, Text, % "y+20 x20 vf_lblWindowPositionMayFail " . (arrNewFavoriteWindowPosition1 ? "" : "hidden"), %lDialogWindowPositionMayFail%
	
	Gui, 2:Add, Text, % "ys x200 section vf_lblWindowPosition " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %lDialogWindowPosition%

	Gui, 2:Add, Text, % "ys+20 xs vf_lblWindowPositionX " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %lDialogWindowPositionX%
	Gui, 2:Add, Text, % "ys+40 xs vf_lblWindowPositionY " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %lDialogWindowPositionY%
	Gui, 2:Add, Text, % "ys+60 xs vf_lblWindowPositionW " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %lDialogWindowPositionW%
	Gui, 2:Add, Text, % "ys+80 xs vf_lblWindowPositionH " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %lDialogWindowPositionH%
	
	Gui, 2:Add, Edit, % "ys+20 xs+72 w36 h17 vf_intWindowPositionX center number limit5 " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %arrNewFavoriteWindowPosition3%
	Gui, 2:Add, Edit, % "ys+40 xs+72 w36 h17 vf_intWindowPositionY center number limit5 " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %arrNewFavoriteWindowPosition4%
	Gui, 2:Add, Edit, % "ys+60 xs+72 w36 h17 vf_intWindowPositionW center number limit5 " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %arrNewFavoriteWindowPosition5%
	Gui, 2:Add, Edit, % "ys+80 xs+72 w36 h17 vf_intWindowPositionH center number limit5 " . (arrNewFavoriteWindowPosition1 and arrNewFavoriteWindowPosition2 = 0 ? "" : "hidden"), %arrNewFavoriteWindowPosition6%
}

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteTabAdvancedSettings:
;------------------------------------------------------------

if InStr(g_strTypesForTabAdvancedOptions, g_objEditedFavorite.FavoriteType)
{
	Gui, 2:Tab, % ++intTabNumber

	Gui, 2:Add, Checkbox, x20 y40 vf_blnUseDefaultSettings gCheckboxUseDefaultSettingsClicked, %lDialogUseDefaultSettings%

	blnShowAdvancedSettings := StrLen(g_objEditedFavorite.FavoriteAppWorkingDir . g_arrGroupSettingsGui3 . g_objEditedFavorite.FavoriteLaunchWith . g_objEditedFavorite.FavoriteArguments)
		or (!g_blnNewFavoriteFtpEncoding and g_objEditedFavorite.FavoriteType = "FTP")

	GuiControl, , f_blnUseDefaultSettings, % !blnShowAdvancedSettings

	if (g_objEditedFavorite.FavoriteType = "Application")
	{
		Gui, 2:Add, Text, x20 y+20 w300 vf_AdvancedSettingsLabel1, %lDialogWorkingDirLabel%
		Gui, 2:Add, Edit, x20 y+5 w300 Limit250 vf_strFavoriteAppWorkingDir, % g_objEditedFavorite.FavoriteAppWorkingDir
		Gui, 2:Add, Button, x+10 yp vf_AdvancedSettingsButton1 gButtonSelectWorkingDir, %lDialogBrowseButton%
	}
	else if (g_objEditedFavorite.FavoriteType = "Group")
	{
		Gui, 2:Add, Text, x20 y+20 vf_AdvancedSettingsLabel2, %lGuiGroupRestoreDelay%
		Gui, 2:Add, Edit, x20 y+5 w50 center number Limit4 vf_intGroupRestoreDelay, %g_arrGroupSettingsGui3%
		Gui, 2:Add, Text, x+10 yp vf_AdvancedSettingsLabel3, %lGuiGroupRestoreDelayMilliseconds%
	}
	else
	{
		Gui, 2:Add, Text, x20 y+20 w300 vf_AdvancedSettingsLabel4, %lDialogLaunchWith%
		Gui, 2:Add, Edit, x20 y+5 w300 Limit250 vf_strFavoriteLaunchWith, % g_objEditedFavorite.FavoriteLaunchWith
		Gui, 2:Add, Button, x+10 yp vf_AdvancedSettingsButton2 gButtonSelectLaunchWith, %lDialogBrowseButton%
	}

	if (g_objEditedFavorite.FavoriteType <> "Group")
	{
		Gui, 2:Add, Text, y+20 x20 w300 vf_AdvancedSettingsLabel5, %lDialogArgumentsLabel%
		Gui, 2:Add, Edit, x20 y+5 w300 Limit250 vf_strFavoriteArguments gFavoriteArgumentChanged, % g_objEditedFavorite.FavoriteArguments
		Gui, 2:Add, Text, x20 y+5 w400 vf_AdvancedSettingsLabel6, %lDialogArgumentsPlaceholders%
		
		Gui, 2:Add, Text, x20 y+10 w400 vf_PlaceholdersCheckLabel, %lDialogArgumentsPlaceholdersCheckLabel%
		Gui, 2:Add, Edit, x20 y+5 w400 vf_strPlaceholdersCheck ReadOnly
		
		gosub, FavoriteArgumentChanged
	}

	if (g_objEditedFavorite.FavoriteType = "FTP")
	{
		Gui, 2:Add, Checkbox, x20 y+5 vf_blnFavoriteFtpEncoding, %lOptionsFtpEncoding%
		GuiControl, , f_blnFavoriteFtpEncoding, % (g_blnNewFavoriteFtpEncoding ? true : false) ; condition in case empty value would be considered as no label
	}

	Gosub, CheckboxUseDefaultSettingsClicked ; init controls hidden
}

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiMoveMultipleFavoritesToMenu:
;------------------------------------------------------------

Gui, 2:New, , % L(lDialogMoveFavoritesTitle, g_strAppNameText, g_strAppVersion)
Gui, 2:Add, Text, % x10 y10 vf_lblFavoriteParentMenu, % L(lDialogFavoritesParentMenuMove, g_intFavoriteSelected)
Gui, 2:Add, DropDownList, x10 w300 vf_drpParentMenu gDropdownParentMenuChanged, % RecursiveBuildMenuTreeDropDown(g_objMainMenu, g_objMenuInGui.MenuPath)

Gui, 2:Add, Text, x20 y+10 vf_lblFavoriteParentMenuPosition, %lDialogFavoriteMenuPosition%
Gui, 2:Add, DropDownList, x20 y+5 w290 vf_drpParentMenuItems AltSubmit

Gui, 2:Add, Button, y+20 vf_btnMoveFavoritesSave gGuiMoveMultipleFavoritesSave, %lGuiMove%
Gui, 2:Add, Button, yp vf_btnMoveFavoritesCancel gGuiEditFavoriteCancel, %lGuiCancel%
GuiCenterButtons(L(lDialogMoveFavoritesTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnMoveFavoritesSave", "f_btnMoveFavoritesCancel")

Gosub, DropdownParentMenuChanged ; to init the content of menu items

GuiControl, 2:Focus, f_drpParentMenu
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonChangeFavoriteHotkey:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

if (g_objEditedFavorite.FavoriteType = "QAP")
	strQAPDefaultHotkey := g_objQAPFeatures[g_objQAPFeaturesCodeByDefaultName[f_drpQAP]].DefaultHotkey

strBackupFavoriteHotkey := g_strNewFavoriteHotkey
g_strNewFavoriteHotkey := SelectHotkey(g_strNewFavoriteHotkey, f_strFavoriteShortName, g_objEditedFavorite.FavoriteType, f_strFavoriteLocation, 3, strQAPDefaultHotkey)
if StrLen(g_strNewFavoriteHotkey)
	GuiControl, 2:, f_strHotkeyText, % Hotkey2Text(g_strNewFavoriteHotkey)
else
	g_strNewFavoriteHotkey := strBackupFavoriteHotkey

strQAPDefaultHotkey = ""
strBackupFavoriteHotkey := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckboxUseDefaultSettingsClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

strAdvancedSettingsControls := "f_strFavoriteAppWorkingDir|f_AdvancedSettingsButton1|f_intGroupRestoreDelay|f_strFavoriteLaunchWith|f_AdvancedSettingsButton2|f_strFavoriteArguments|f_blnFavoriteFtpEncoding"

; show or hide controls
Loop, Parse, strAdvancedSettingsControls, |
	if (g_intActiveFileManager = 3 and A_LoopField = "f_blnFavoriteFtpEncoding") ; 3 TotalCommander
		; hide if TotalCommander is used because URL is never encoded with TC (as hardcoded in OpenFavorite)
		GuiControl, Hide, f_blnFavoriteFtpEncoding
	else
		GuiControl, % (f_blnUseDefaultSettings ? "Hide" : "Show"), %A_LoopField%

; show or hide labels
Loop, 6
	GuiControl, % (f_blnUseDefaultSettings ? "Hide" : "Show"), f_AdvancedSettingsLabel%A_Index%

if (f_blnUseDefaultSettings)
; if use default, reset values to default
{
	strAdvancedSettingsControls := "f_strFavoriteAppWorkingDir|f_intGroupRestoreDelay|f_strFavoriteLaunchWith|f_strFavoriteArguments|f_strPlaceholdersCheck"
	Loop, Parse, strAdvancedSettingsControls, |
		GuiControl, , %A_LoopField% ; empty control to reset default value

	; default value is true, except if TotalCommander is used
	GuiControl, , f_blnFavoriteFtpEncoding, % (g_intActiveFileManager = 3 ? 0 : 1) ; 3 TotalCommander
}

strAdvancedSettingsControls := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddFavoriteTabChanged:
;------------------------------------------------------------

if (f_intAddFavoriteTab = 1) ; if last tab was 1 we need to update the icon
{
	Gui, 2:Submit, NoHide

	Gosub, GuiFavoriteIconDefault
	Gosub, GuiFavoriteIconDisplay
}

return
;------------------------------------------------------------


;------------------------------------------------------------
DropdownParentMenuChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

Loop, % g_objMenusIndex[f_drpParentMenu].MaxIndex()
{
	if (g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteType = "B") ; skip ".." back link to parent menu
		or (g_objEditedFavorite.FavoriteName = g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteName)
			and (g_objMenuInGui.MenuPath = g_objMenusIndex[f_drpParentMenu].MenuPath ; skip edited item itself if not a separator
			and !InStr("X|K", g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteType)) ; but make sure to keep separators
		Continue
	else if (g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteType = "X")
		strDropdownParentMenuItems .= g_strGuiMenuSeparator . g_strGuiMenuSeparator . "|"
	else if (g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteType = "K")
		strDropdownParentMenuItems .= g_strGuiDoubleLine . " " . lMenuColumnBreak . " " . g_strGuiDoubleLine . "|"
	else
		strDropdownParentMenuItems .= g_objMenusIndex[f_drpParentMenu][A_Index].FavoriteName . "|"
}

GuiControl, , f_drpParentMenuItems, % "|" . strDropdownParentMenuItems . g_strGuiDoubleLine . " " . lDialogEndOfMenu . " " . g_strGuiDoubleLine
if (f_drpParentMenu = g_objMenuInGui.MenuPath) and (g_intOriginalMenuPosition <> 0xFFFF)
	GuiControl, Choose, f_drpParentMenuItems, % g_intOriginalMenuPosition - (g_objMenusIndex[f_drpParentMenu][1].FavoriteType = "B" ? 1 : 0)
else
	GuiControl, ChooseString, f_drpParentMenuItems, % g_strGuiDoubleLine . " " . lDialogEndOfMenu . " " . g_strGuiDoubleLine

strDropdownParentMenuItems := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
DropdownRunningApplicationChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, , f_strFavoriteLocation, %f_drpRunningApplication%

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiOpenThisMenu:
;------------------------------------------------------------
Gosub, 2GuiClose

Gui, 1:Default
GuiControl, 1:Focus, f_lvFavoritesList
Gui, 1:ListView, f_lvFavoritesList

Gosub, OpenMenuFromEditForm

return
;------------------------------------------------------------


;------------------------------------------------------------
DropdownSpecialChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, , f_strFavoriteShortName, %f_drpSpecial%
GuiControl, , f_strFavoriteLocation, % g_objClassIdOrPathByDefaultName[f_drpSpecial]

g_strNewFavoriteIconResource := g_objSpecialFolders[g_objClassIdOrPathByDefaultName[f_drpSpecial]].DefaultIcon
g_strDefaultIconResource := g_strNewFavoriteIconResource 

return
;------------------------------------------------------------


;------------------------------------------------------------
DropdownQAPChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, , f_strFavoriteShortName, %f_drpQAP%
GuiControl, , f_strFavoriteLocation, % g_objQAPFeaturesCodeByDefaultName[f_drpQAP]

g_strNewFavoriteIconResource := g_objQAPFeatures[g_objQAPFeaturesCodeByDefaultName[f_drpQAP]].DefaultIcon
g_strDefaultIconResource := g_strNewFavoriteIconResource 

g_strNewFavoriteHotkey := g_objQAPFeatures[g_objQAPFeaturesCodeByDefaultName[f_drpQAP]].DefaultHotkey
GuiControl, , f_strHotkeyText, % Hotkey2Text(g_strNewFavoriteHotkey)

return
;------------------------------------------------------------


;------------------------------------------------------------
EditFavoriteLocationChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

if InStr("Document|Application", g_objEditedFavorite.FavoriteType)
	g_strNewFavoriteIconResource := ""

if !StrLen(f_strFavoriteShortName)
	GuiControl, 2:, f_strFavoriteShortName, % GetDeepestFolderName(f_strFavoriteLocation)

return
;------------------------------------------------------------


;------------------------------------------------------------
FavoriteArgumentChanged:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, % (InStr(f_strFavoriteArguments, "{") ? "Show" : "Hide"), f_PlaceholdersCheckLabel
GuiControl, % (InStr(f_strFavoriteArguments, "{") ? "Show" : "Hide"), f_strPlaceholdersCheck

GuiControl, 2:, f_strPlaceholdersCheck, % ExpandPlaceholders(f_strFavoriteArguments, f_strFavoriteLocation)

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonSelectFavoriteLocation:
ButtonSelectWorkingDir:
ButtonSelectLaunchWith:
;------------------------------------------------------------
Gui, 2:Submit, NoHide
Gui, 2:+OwnDialogs

if (A_ThisLabel = "ButtonSelectFavoriteLocation")
{
	strDefault := f_strFavoriteLocation
	strType := (g_objEditedFavorite.FavoriteType = "Folder" ? "Folder" : "File")
}
else if (A_ThisLabel = "ButtonSelectWorkingDir")
{
	strDefault := f_strFavoriteAppWorkingDir
	strType := "Folder"
}
else ; ButtonSelectLaunchWith
{
	strDefault := f_strFavoriteLaunchWith
	strType := "File"
}

if (strType = "Folder")
	FileSelectFolder, strNewLocation, *%strDefault%, 3, %lDialogAddFolderSelect%
else ; File
	FileSelectFile, strNewLocation, S3, %strDefault%, %lDialogAddFileSelect%

if !(StrLen(strNewLocation))
{
	gosub, ButtonSelectFavoriteLocationCleanup
	return
}

if (A_ThisLabel = "ButtonSelectWorkingDir")
	GuiControl, 2:, f_strFavoriteAppWorkingDir, %strNewLocation%
else if (A_ThisLabel = "ButtonSelectLaunchWith")
	GuiControl, 2:, f_strFavoriteLaunchWith, %strNewLocation%
else
{
	GuiControl, 2:, f_strFavoriteLocation, %strNewLocation%
	if !StrLen(f_strFavoriteShortName)
		GuiControl, 2:, f_strFavoriteShortName, % GetDeepestFolderName(strNewLocation)
}

ButtonSelectFavoriteLocationCleanup:
strNewLocation := ""
strDefault := ""
strType := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiPickIconDialog:
;------------------------------------------------------------
Gui, 2:Submit, NoHide
Gui, 2:+OwnDialogs

if InStr("Document|Application", g_objEditedFavorite.FavoriteType) and !StrLen(f_strFavoriteLocation)
{
	Oops(lPickIconNoLocation)
	return
}

; Source: http://ahkscript.org/boards/viewtopic.php?f=5&t=5108#p29970
VarSetCapacity(strThisIconFile, 1024) ; must be placed before strNewIconFile is initialized because VarSetCapacity erase its content
ParseIconResource(g_strNewFavoriteIconResource, strThisIconFile, intThisIconIndex)
strThisIconFile := PathCombine(A_WorkingDir, strThisIconFile)

WinGet, hWnd, ID, A
if (intThisIconIndex >= 0) ; adjust index for positive index only (not for negative index)
	intThisIconIndex := intThisIconIndex - 1
DllCall("shell32\PickIconDlg", "Uint", hWnd, "str", strThisIconFile, "Uint", 260, "intP", intThisIconIndex)
if (intThisIconIndex >= 0) ; adjust index for positive index only (not for negative index)
	intThisIconIndex := intThisIconIndex + 1

if StrLen(strThisIconFile)
	g_strNewFavoriteIconResource := strThisIconFile . "," . intThisIconIndex

Gosub, GuiFavoriteIconDisplay

strThisIconFile := ""
intThisIconIndex := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiRemoveIcon:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

g_strNewFavoriteIconResource := ""
Gosub, GuiFavoriteIconDefault

Gosub, GuiFavoriteIconDisplay

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteIconDefault:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

if (g_objEditedFavorite.FavoriteType = "Menu")
	; default submenu icon
	g_strDefaultIconResource := g_objIconsFile["iconSubmenu"] . "," . g_objIconsIndex["iconSubmenu"]
else if (g_objEditedFavorite.FavoriteType = "Group")
	; default group icon
	g_strDefaultIconResource := g_objIconsFile["iconGroup"] . "," . g_objIconsIndex["iconGroup"]
else if (g_objEditedFavorite.FavoriteType = "Folder")
	; default folder icon
	g_strDefaultIconResource := g_objIconsFile["iconFolder"] . "," . g_objIconsIndex["iconFolder"]
else if (g_objEditedFavorite.FavoriteType = "URL")
{
	; default browser icon
	GetIcon4Location(g_strTempDir . "\default_browser_icon.html", strThisIconFile, intThisIconIndex)
	g_strDefaultIconResource := strThisIconFile . "," . intThisIconIndex
}
else if (g_objEditedFavorite.FavoriteType = "FTP")
{
	; default FTP icon
	g_strDefaultIconResource := g_objIconsFile["iconFTP"] . "," . g_objIconsIndex["iconFTP"]
}
else if InStr("Document|Application", g_objEditedFavorite.FavoriteType) and StrLen(f_strFavoriteLocation)
{
	; default icon for the selected file in add/edit favorite
	GetIcon4Location(f_strFavoriteLocation, strThisIconFile, intThisIconIndex, blnRadioApplication)
	g_strDefaultIconResource := strThisIconFile . "," . intThisIconIndex
}
else if (g_objEditedFavorite.FavoriteType = "Special")
	g_strDefaultIconResource := g_objSpecialFolders[g_objEditedFavorite.FavoriteLocation].DefaultIcon
else if (g_objEditedFavorite.FavoriteType = "QAP")
	g_strDefaultIconResource := g_objQAPFeatures[g_objEditedFavorite.FavoriteLocation].DefaultIcon
else ; should not
	g_strDefaultIconResource := g_objIconsFile["iconUnknown"] . "," . g_objIconsIndex["iconUnknown"]

if !StrLen(g_strNewFavoriteIconResource) or (g_strNewFavoriteIconResource = g_objIconsFile["iconUnknown"] . "," . g_objIconsIndex["iconUnknown"])
	g_strNewFavoriteIconResource := g_strDefaultIconResource

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiFavoriteIconDisplay:
;------------------------------------------------------------

strExpandedRessourceIcon := EnvVars(g_strNewFavoriteIconResource)
ParseIconResource(strExpandedRessourceIcon, strThisIconFile, intThisIconIndex)
GuiControl, , f_picIcon, *icon%intThisIconIndex% %strThisIconFile%
GuiControl, % (strExpandedRessourceIcon <> EnvVars(g_strDefaultIconResource) ? "Show" : "Hide"), f_lblRemoveIcon

strExpandedRessourceIcon := ""
strThisIconFile := ""
intThisIconIndex := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckboxWindowPositionClicked:
RadioButtonWindowPositionMinMaxClicked:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionState
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionMinMax1
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionMinMax2
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionMinMax3

GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionDelayLabel
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionDelay
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionMillisecondsLabel
GuiControl, % (!f_chkUseDefaultWindowPosition ? "Show" : "Hide"), f_lblWindowPositionMayFail

GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_lblWindowPosition
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_lblWindowPositionX
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_intWindowPositionX
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_lblWindowPositionY
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_intWindowPositionY
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_lblWindowPositionW
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_intWindowPositionW
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_lblWindowPositionH
GuiControl, % (!f_chkUseDefaultWindowPosition and f_lblWindowPositionMinMax1 ? "Show" : "Hide"), f_intWindowPositionH

return
;------------------------------------------------------------


;------------------------------------------------------------
HotkeyChangeMenu:
;------------------------------------------------------------

Gui, 1:ListView, f_lvFavoritesList

g_intOriginalMenuPosition := LV_GetNext()

if InStr("Menu|Group", g_objMenuInGui[g_intOriginalMenuPosition].FavoriteType)
	Gosub, OpenMenuFromGuiHotkey

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiMenusListChanged:
GuiGotoUpMenu:
GuiGotoPreviousMenu:
OpenMenuFromEditForm:
OpenMenuFromGuiHotkey:
;------------------------------------------------------------
intCurrentLastPosition := 0

if (A_ThisLabel = "GuiMenusListChanged")
{
	GuiControlGet, strNewDropdownMenu, , f_drpMenusList

	if (strNewDropdownMenu = g_objMenuInGui.MenuPath) ; user selected the current menu in the dropdown
	{
		gosub, GuiMenusListChangedCleanup
		return
	}
}

/*
###_D(A_ThisLabel . "`n"
	. "intCurrentLastPosition: " . intCurrentLastPosition . "`n"
	. "g_intOriginalMenuPosition: " . g_intOriginalMenuPosition . "`n"
	. "strNewDropdownMenu: " . strNewDropdownMenu . "`n"
	. "g_objMenuInGui.MenuPath: " . g_objMenuInGui.MenuPath . "`n"
	. "g_objMenusIndex[strNewDropdownMenu].MenuPath: " . g_objMenusIndex[strNewDropdownMenu].MenuPath . "`n"
	. "g_objMenuInGui[1].SubMenu.MenuPath: " . g_objMenuInGui[1].SubMenu.MenuPath . "`n"
	. "g_objMenuInGui[g_intOriginalMenuPosition].SubMenu.MenuPath: " . g_objMenuInGui[g_intOriginalMenuPosition].SubMenu.MenuPath . "`n"
	. ": " . "`n"
	. "")
*/

if (A_ThisLabel = "GuiGotoPreviousMenu")
{
	g_objMenuInGui := g_objMenusIndex[g_arrSubmenuStack[1]] ; pull the top menu from the left arrow stack
	g_arrSubmenuStack.Remove(1) ; remove the top menu from the left arrow stack

	intCurrentLastPosition := g_arrSubmenuStackPosition[1] ; pull the focus position in top menu from the left arrow stack
	g_arrSubmenuStackPosition.Remove(1) ; remove the top position from the left arrow stack
}
else
{
	g_arrSubmenuStack.Insert(1, g_objMenuInGui.MenuPath) ; push the current menu to the left arrow stack
	
	if (A_ThisLabel = "GuiMenusListChanged")
		g_objMenuInGui := g_objMenusIndex[strNewDropdownMenu]
	else if (A_ThisLabel = "GuiGotoUpMenu")
		g_objMenuInGui := g_objMenuInGui[1].SubMenu
	else if (A_ThisLabel = "OpenMenuFromEditForm") or (A_ThisLabel = "OpenMenuFromGuiHotkey")
		g_objMenuInGui := g_objMenuInGui[g_intOriginalMenuPosition].SubMenu

	g_arrSubmenuStackPosition.Insert(1, LV_GetNext("Focused"))
}

GuiControl, % (g_arrSubmenuStack.MaxIndex() ? "Show" : "Hide"), f_picPreviousMenu
GuiControl, % (g_objMenuInGui.MenuPath <> lMainMenuName ? "Show" : "Hide"), f_picUpMenu

Gosub, LoadMenuInGui

if (intCurrentLastPosition) ; we went to a previous menu
{
	LV_Modify(0, "-Select")
	LV_Modify(intCurrentLastPosition, "Select Focus Vis")
}

if (A_ThisLabel = "GuiMenusListChanged") ; keep focus on dropdown list
	GuiControl, Focus, f_drpMenusList

GuiMenusListChangedCleanup:
intCurrentLastPosition := ""
strNewDropdownMenu := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddFavoriteCancel:
GuiEditFavoriteCancel:
;------------------------------------------------------------

Gosub, 2GuiClose

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiShow:
GuiShowFromPower:
SettingsHotkey:
;------------------------------------------------------------

; should not be required but safer
GuiControlGet, blnSaveEnabled, Enabled, %lGuiSave%
if (blnSaveEnabled)
{
	gosub, GuiShowCleanup
	return
}

if (A_ThisLabel <> "GuiShowFromPower") ; menu object already set if from Power hotey
	g_objMenuInGui := g_objMainMenu

Gosub, BackupMenusObjects

g_objHotkeysToDisableWhenSave := Object() ; to track hotkeys to turn off when saving favorites with hotkey changed

if (A_ThisLabel = "GuiShowFromPower")
	Gosub, LoadMenuInGuiFromPower
else
	Gosub, LoadMenuInGui
Gui, 1:Show

GuiShowCleanup:
blnSaveEnabled := ""

return
;------------------------------------------------------------


;========================================================================================================================
; END OF FAVORITE_GUI
;========================================================================================================================


;========================================================================================================================
!_034_FAVORITE_GUI_SAVE:
;========================================================================================================================

;------------------------------------------------------------
GuiMoveMultipleFavoritesSave:
;------------------------------------------------------------
Gui, 2:Submit, NoHide
Gui, 2:+OwnDialogs

if (f_drpParentMenu = g_objMenuInGui.MenuPath)
	return

Gui, 1:Default
Gui, ListView, f_lvFavoritesList
g_intOriginalMenuPosition := 0

Loop
{
	g_intOriginalMenuPosition := LV_GetNext(g_intOriginalMenuPosition)
	if (!g_intOriginalMenuPosition)
        break
	if (g_objMenuInGui[g_intOriginalMenuPosition].FavoriteType = "B") ; skip back menu
		continue
	g_objEditedFavorite := g_objMenuInGui[g_intOriginalMenuPosition]
	
	Gosub, GuiMoveOneFavoriteSave
	g_intOriginalMenuPosition -=  1 ; because GuiMoveOneFavoriteSave deleted the previous item
}

gosub, GuiAddFavoriteSaveCleanup ; clean these variables for next use (multiple move or not)

Gosub, BuildMainMenuWithStatus ; update menus
Gosub, GuiEditFavoriteCancel

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddFavoriteSave:
GuiEditFavoriteSave:
GuiMoveOneFavoriteSave:
GuiCopyFavoriteSave:
;------------------------------------------------------------
Gui, 2:Submit, NoHide
Gui, 2:+OwnDialogs

strThisLabel := A_ThisLabel

; original and destination menus values
if InStr("GuiAddFavoriteSave|GuiCopyFavoriteSave", strThisLabel)
{
	strOriginalMenu := ""
	g_intOriginalMenuPosition := 0
}
else ; GuiEditFavoriteSave or GuiMoveOneFavoriteSave
	strOriginalMenu := g_objMenuInGui.MenuPath

; f_drpParentMenu and f_drpParentMenuItems have same field name in 2 gui: GuiAddFavorite and GuiMoveMultipleFavoritesToMenu
strDestinationMenu := f_drpParentMenu

if (!g_intNewItemPos) ; if in GuiMoveOneFavoriteSave g_intNewItemPos may be already set
	g_intNewItemPos := f_drpParentMenuItems + (g_objMenusIndex[strDestinationMenu][1].FavoriteType = "B" ? 1 : 0)

; validation to avoid unauthorized favorite types in groups
if (g_objMenusIndex[strDestinationMenu].MenuType = "Group" and InStr("QAP|Menu|Group", g_objEditedFavorite.FavoriteType))
{
	Oops(lDialogFavoriteNameNotAllowed, ReplaceAllInString(g_objFavoriteTypesLabels[g_objEditedFavorite.FavoriteType], "&", ""), lDialogFavoriteParentMenu)
	if (strThisLabel = "GuiMoveOneFavoriteSave")
		g_intOriginalMenuPosition++
	gosub, GuiAddFavoriteSaveCleanup
	return
}
/*
###_D("g_objEditedFavorite.FavoriteType: " . g_objEditedFavorite.FavoriteType 
	. "`ng_objMenusIndex[strDestinationMenu].MenuPath: " . g_objMenusIndex[strDestinationMenu].MenuPath 
	. "`ng_objMenusIndex[strDestinationMenu].MenuType: " . g_objMenusIndex[strDestinationMenu].MenuType)
*/

; validation (not required for GuiMoveOneFavoriteSave because info in g_objEditedFavorite is not changed)

if (strThisLabel <> "GuiMoveOneFavoriteSave")
{
	if !StrLen(f_strFavoriteShortName)
	{
		Oops(g_objEditedFavorite.FavoriteType = "Menu" ? lDialogSubmenuNameEmpty : lDialogFavoriteNameEmpty)
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if  InStr("Folder|Document|Application|URL|FTP", g_objEditedFavorite.FavoriteType) and !StrLen(f_strFavoriteLocation)
	{
		Oops(lDialogFavoriteLocationEmpty)
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if (g_objEditedFavorite.FavoriteType = "FTP" and SubStr(f_strFavoriteLocation, 1, 6) <> "ftp://")
	{
		Oops(lOopsFtpLocationProtocol)
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if  InStr("Special|QAP", g_objEditedFavorite.FavoriteType) and !StrLen(f_strFavoriteLocation)
	{
		Oops(lDialogFavoriteDropdownEmpty, ReplaceAllInString(g_objFavoriteTypesLabels[g_objEditedFavorite.FavoriteType], "&", ""))
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if InStr("Menu|Group", g_objEditedFavorite.FavoriteType) and InStr(f_strFavoriteShortName, g_strMenuPathSeparator)
	{
		Oops(L(lDialogFavoriteNameNoSeparator, g_strMenuPathSeparator))
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if InStr(f_strFavoriteShortName, g_strGroupIndicatorPrefix)
	{
		Oops(L(lDialogFavoriteNameNoSeparator, g_strGroupIndicatorPrefix))
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

	if InStr(g_strTypesForTabWindowOptions, g_objEditedFavorite.FavoriteType)
	{
		strNewFavoriteWindowPosition := (f_chkUseDefaultWindowPosition ? 0 : 1)
		if (!f_chkUseDefaultWindowPosition)
			strNewFavoriteWindowPosition .= "," . (f_lblWindowPositionMinMax1 ? 0 : (f_lblWindowPositionMinMax2 ? 1 : -1))
				. "," . f_intWindowPositionX . "," . f_intWindowPositionY . "," . f_intWindowPositionW . "," . f_intWindowPositionH . "," . f_lblWindowPositionDelay
		else
			strNewFavoriteWindowPosition .= ",,,,,," ; exact number of comas required for RestoreSide
				
		GuiControlGet, intRadioGroupRestoreSide, , f_intRadioGroupRestoreSide
		if !(ErrorLevel) ; if errorlevel, control does not exist
			strNewFavoriteWindowPosition .= "," . (f_intRadioGroupRestoreSide = 1 ? "L" : "R")
		
		if !ValidateWindowPosition(strNewFavoriteWindowPosition)
		{
			Oops(lOopsInvalidWindowPosition)
			gosub, GuiAddFavoriteSaveCleanup
			return
		}
	}
}

if !FolderNameIsNew((strThisLabel = "GuiMoveOneFavoriteSave" ? g_objEditedFavorite.FavoriteName : f_strFavoriteShortName), g_objMenusIndex[strDestinationMenu])
	and !InStr("X|K", g_objEditedFavorite.FavoriteType) ; same name OK for separators
	; we have the same name in the destination menu
	; if this is the same menu and the same name, this is OK
	if (strDestinationMenu <> strOriginalMenu) or (f_strFavoriteShortName <> g_objEditedFavorite.FavoriteName)
	{
		if (g_objEditedFavorite.FavoriteType = "QAP")
			Oops(lDialogFavoriteNameNotNewQAPfeature, (strThisLabel = "GuiMoveOneFavoriteSave" ? g_objEditedFavorite.FavoriteName : f_strFavoriteShortName))
		else
			Oops(lDialogFavoriteNameNotNew, (strThisLabel = "GuiMoveOneFavoriteSave" ? g_objEditedFavorite.FavoriteName : f_strFavoriteShortName))
		if (strThisLabel = "GuiMoveOneFavoriteSave")
			g_intOriginalMenuPosition++
		gosub, GuiAddFavoriteSaveCleanup
		return
	}

if (InStr(strDestinationMenu, strOriginalMenu . " " . g_strMenuPathSeparator " " . g_objEditedFavorite.FavoriteName) = 1) ; = 1 to check if equal from start only
	and !InStr("K|X", g_objEditedFavorite.FavoriteType) ; no risk with separators
{
	Oops(lDialogMenuNotMoveUnderItself, g_objEditedFavorite.FavoriteName)
	g_intOriginalMenuPosition++ ; will be reduced by GuiMoveMultipleFavoritesSave
	gosub, GuiAddFavoriteSaveCleanup
	return
}

; if adding menu or group, create submenu object

if (InStr("Menu|Group", g_objEditedFavorite.FavoriteType) and (strThisLabel = "GuiAddFavoriteSave"))
{
	objNewMenu := Object() ; object for the new menu or group
	objNewMenu.MenuPath := strDestinationMenu . " " . g_strMenuPathSeparator . " " . f_strFavoriteShortName
		. (g_objEditedFavorite.FavoriteType = "Group" ? " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix : "")
	objNewMenu.MenuType := g_objEditedFavorite.FavoriteType

	; create a navigation entry to navigate to the parent menu
	objNewMenuBack := Object()
	objNewMenuBack.FavoriteType := "B" ; for Back link to parent menu
	objNewMenuBack.FavoriteName := "(" . GetDeepestMenuPath(strDestinationMenu) . ")"
	objNewMenuBack.SubMenu := g_objMenusIndex[strDestinationMenu] ; this is the link to the parent menu
	objNewMenu.Insert(objNewMenuBack)
	
	g_objMenusIndex.Insert(objNewMenu.MenuPath, objNewMenu)
	g_objEditedFavorite.Submenu := objNewMenu
}

; update menu object and hotkeys object except if we move favorites

if (strThisLabel <> "GuiMoveOneFavoriteSave")
{
	g_objEditedFavorite.FavoriteName := f_strFavoriteShortName
	
	; before updating g_objEditedFavorite.FavoriteLocation, check if location was changed and update hotkeys objects
	; ###_V(A_ThisLabel, g_strNewFavoriteHotkey, g_objEditedFavorite.FavoriteLocation, f_strFavoriteLocation, HasHotkey(g_strNewFavoriteHotkey))
	if StrLen(g_objEditedFavorite.FavoriteLocation) and (g_objEditedFavorite.FavoriteLocation <> f_strFavoriteLocation)
	{
		g_objHotkeysByLocation.Remove(g_objEditedFavorite.FavoriteLocation)
		if StrLen(f_strFavoriteLocation) and HasHotkey(g_strNewFavoriteHotkey)
			g_objHotkeysByLocation.Insert(f_strFavoriteLocation, g_strNewFavoriteHotkey) ; if the key already exists, its value is overwritten
	}
	
	if InStr("Menu|Group", g_objEditedFavorite.FavoriteType)
	{
		strMenuLocation := strDestinationMenu . " " . g_strMenuPathSeparator . " " . f_strFavoriteShortName
			. (g_objEditedFavorite.FavoriteType = "Group" ? " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix : "")
		RecursiveUpdateMenuPath(g_objEditedFavorite.Submenu, strMenuLocation)
		
		StringReplace, strMenuLocation, strMenuLocation, %lMainMenuName%%A_Space% ; menu path without main menu localized name
		g_objEditedFavorite.FavoriteLocation := strMenuLocation
	}
	else
		g_objEditedFavorite.FavoriteLocation := f_strFavoriteLocation
	
	Gosub, UpdateHotkeyObjectsFavoriteSave

	g_objEditedFavorite.FavoriteIconResource := g_strNewFavoriteIconResource
	g_objEditedFavorite.FavoriteWindowPosition := strNewFavoriteWindowPosition
	
	if (g_objEditedFavorite.FavoriteType = "Group")
	{
		g_objEditedFavorite.FavoriteGroupSettings := f_blnRadioGroupReplace
		g_objEditedFavorite.FavoriteGroupSettings .= "," . (f_blnRadioGroupRestoreWithOther ? "Other" : "Windows Explorer")
		g_objEditedFavorite.FavoriteGroupSettings .= (f_blnUseDefaultSettings ? "" : "," . f_intGroupRestoreDelay)
	}
	
	g_objEditedFavorite.FavoriteLoginName := f_strFavoriteLoginName
	g_objEditedFavorite.FavoritePassword := f_strFavoritePassword
	g_objEditedFavorite.FavoriteFtpEncoding := f_blnFavoriteFtpEncoding
	
	g_objEditedFavorite.FavoriteArguments := (f_blnUseDefaultSettings ? "" : f_strFavoriteArguments)
	g_objEditedFavorite.FavoriteAppWorkingDir := (f_blnUseDefaultSettings ? "" : f_strFavoriteAppWorkingDir)
	g_objEditedFavorite.FavoriteLaunchWith := (f_blnUseDefaultSettings ? "" : f_strFavoriteLaunchWith)
}

; updating original and destination menu objects (these can be the same)

if (strOriginalMenu <> "")
	g_objMenusIndex[strOriginalMenu].Remove(g_intOriginalMenuPosition)
if (g_intNewItemPos)
	g_objMenusIndex[strDestinationMenu].Insert(g_intNewItemPos, g_objEditedFavorite)
else
	g_objMenusIndex[strDestinationMenu].Insert(g_objEditedFavorite) ; if no item is selected, add to the end of menu

; ###_O("g_objMenusIndex[strDestinationMenu]", g_objMenusIndex[strDestinationMenu], "FavoriteName")

/*
###_D(""
	. "strOriginalMenu: " . strOriginalMenu . "`n"
	. "g_intNewItemPos: " . g_intNewItemPos . "`n"
	. "g_objEditedFavorite.FavoriteType : " . g_objEditedFavorite.FavoriteType . "`n"
	. "g_objEditedFavorite.FavoriteName : " . g_objEditedFavorite.FavoriteName . "`n"
	. "g_objEditedFavorite.FavoriteLocation: " . g_objEditedFavorite.FavoriteLocation . "`n"
	. "g_objEditedFavorite.Submenu.MenuPath: " . g_objEditedFavorite.Submenu.MenuPath . "`n"
	. "g_objEditedFavorite.Submenu.MenuType: " . g_objEditedFavorite.Submenu.MenuType . "`n"
	. "`n"
	. "g_objEditedFavorite.Submenu[1].FavoriteName: " . g_objEditedFavorite.Submenu[1].FavoriteName . "`n"
	. "g_objEditedFavorite.Submenu[1].Submenu.MenuPath: " . g_objEditedFavorite.Submenu[1].Submenu.MenuPath . "`n"
	. "")
*/

; updating listview

Gosub, 2GuiClose

Gui, 1:Default
GuiControl, 1:Focus, lvFavoritesList
Gui, 1:ListView, lvFavoritesList

if (strOriginalMenu = g_objMenuInGui.MenuPath) ; remove original from Listview if original in Gui (can be replaced with modified)
	LV_Delete(g_intOriginalMenuPosition)

if (strDestinationMenu = g_objMenuInGui.MenuPath) ; add modified to Listview if destination in Gui (can replace original deleted)
{
	LV_Modify(0, "-Select")
	if (g_objEditedFavorite.FavoriteType = "Menu")
		strThisLocation := g_strMenuPathSeparator
	else if (g_objEditedFavorite.FavoriteType = "Group")
		strThisLocation := g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix

	else
		strThisLocation := g_objEditedFavorite.FavoriteLocation
	
	if (g_intNewItemPos)
		LV_Insert(g_intNewItemPos, "Select Focus", g_objEditedFavorite.FavoriteName, g_objFavoriteTypesShortNames[g_objEditedFavorite.FavoriteType], strThisLocation)
	else
		LV_Add("Select Focus", g_objEditedFavorite.FavoriteName, g_objFavoriteTypesShortNames[g_objEditedFavorite.FavoriteName], strThisLocation)

	LV_Modify(LV_GetNext(), "Vis")
}

GuiControl, 1:, f_drpMenusList, % "|" . RecursiveBuildMenuTreeDropDown(g_objMainMenu, g_objMenuInGui.MenuPath) . "|" ; required if submenu was added
Gosub, AdjustColumnsWidth

if (strThisLabel <> "GuiMoveOneFavoriteSave")
	Gosub, BuildMainMenuWithStatus ; update menus but not hotkeys

GuiControl, Enable, f_btnGuiSaveFavorites
GuiControl, , f_btnGuiCancel, %lDialogCancelButton%

g_blnMenuReady := true

if (strThisLabel = "GuiMoveOneFavoriteSave")
	g_intNewItemPos++ ; move next favorite after this one in the destination menu (or will be deleted in GuiMoveOneFavoriteSave after the loop)
else
	g_intNewItemPos := "" ; delete it for next use

GuiAddFavoriteSaveCleanup:
if (strThisLabel <> "GuiMoveOneFavoriteSave") ; do not execute at each favorite when moving multiple favorites
	or (A_ThisLabel = "GuiAddFavoriteSaveCleanup") ; but executed it when called at the end of GuiMoveMultipleFavoritesSave
{
	strOriginalMenu := ""
	strDestinationMenu := ""
	strMenuLocation := ""
	strThisLocation := ""
	strNewFavoriteWindowPosition := ""
	strMenuPath := ""
	objMenu := ""
	g_intNewItemPos := "" ; in case we abort save and retry

	; make sure all gui variables are flushed before next fav add or edit
	f_blnRadioGroupAdd := ""
	f_blnRadioGroupReplace := ""
	f_blnRadioGroupRestoreWithExplorer := ""
	f_blnRadioGroupRestoreWithOther := ""
	f_blnUseDefaultSettings := ""
	f_chkUseDefaultWindowPosition := ""
	f_drpParentMenu := ""
	f_drpParentMenuItems := ""
	f_drpQAP := ""
	f_drpRunningApplication := ""
	f_drpSpecial := ""
	f_intGroupExplorerDelay := ""
	f_intGroupRestoreDelay := ""
	f_intWindowPositionH := ""
	f_intWindowPositionW := ""
	f_intWindowPositionX := ""
	f_intWindowPositionY := ""
	f_picIcon := ""
	f_strFavoriteAppWorkingDir := ""
	f_strFavoriteArguments := ""
	f_strFavoriteLaunchWith := ""
	f_strFavoriteLocation := ""
	f_strFavoriteLoginName := ""
	f_strFavoritePassword := ""
	f_strFavoriteShortName := ""
	f_strHotkeyText := ""
}

return
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveUpdateMenuPath(objEditedMenu, strMenuPath)
;------------------------------------------------------------
{
	global g_strMenuPathSeparator
	global g_strGroupIndicatorPrefix
	global g_strGroupIndicatorSuffix
	
	Loop, % objEditedMenu.MaxIndex()
	{
		objEditedMenu.MenuPath := strMenuPath ; update only path regardless .MenuType "Menu" or "Group"
		
		; skip ".." back link to parent menu
		if (objEditedMenu[A_Index].FavoriteType = "B")
			continue
		
		if InStr("Menu|Group", objEditedMenu[A_Index].FavoriteType)
			RecursiveUpdateMenuPath(objEditedMenu[A_Index].SubMenu
				, objEditedMenu.MenuPath . " " . g_strMenuPathSeparator . " " . objEditedMenu[A_Index].FavoriteName
				. (objEditedMenu[A_Index].FavoriteType = "Group" ? " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix : "") ) ; RECURSIVE
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
ValidateWindowPosition(strPosition)
;------------------------------------------------------------
{
	StringSplit, arrPosition, strPosition, `,
	if !(arrPosition1) or (arrPosition2 <> 0) ; no position to validate
		return true
	
	if arrPosition3 is not integer
		blnOK := false
	else if arrPosition4 is not integer
		blnOK := false
	else if arrPosition5 is not integer
		blnOK := false
	else if arrPosition6 is not integer
		blnOK := false
	else if arrPosition7 is not integer
		blnOK := false
	else
		blnOK := true

	if (blnOK)
		blnOK := (arrPosition3 > 0) and (arrPosition4 > 0) and (arrPosition5 > 0) and (arrPosition6 > 0) and (arrPosition7 >= 0)
	
	return blnOK
}
;------------------------------------------------------------


;------------------------------------------------------------
FolderNameIsNew(strCandidateName, objMenu)
;------------------------------------------------------------
{
	Loop, % objMenu.MaxIndex()
		if (strCandidateName = objMenu[A_Index].FavoriteName)
			return False

	return True
}
;------------------------------------------------------------


;========================================================================================================================
; END OF FAVORITE_GUI_SAVE
;========================================================================================================================


;========================================================================================================================
!_036_FAVORITE_GUI_OTHER:
;========================================================================================================================

;------------------------------------------------------------
GuiRemoveMultipleFavorites:
;------------------------------------------------------------

GuiControl, Focus, f_lvFavoritesList
Gui, 1:ListView, f_lvFavoritesList

if (LV_GetNext() = 1 and g_objMenuInGui[1].FavoriteType = "B")
	LV_Modify(1, "-Select") ; deselect back link entry

if LV_GetCount("Selected") > 1
{
	MsgBox, 52, %g_strAppNameText%, % L(lDialogRemoveMultipleFavorites, LV_GetCount("Selected"))
	IfMsgBox, No
		return
}

Loop
	Gosub, GuiRemoveOneFavorite
until !LV_GetNext()

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiRemoveFavorite:
GuiRemoveOneFavorite:
;------------------------------------------------------------

GuiControl, Focus, f_lvFavoritesList
Gui, 1:ListView, f_lvFavoritesList
intItemToRemove := LV_GetNext()
if !(intItemToRemove)
{
	Oops(lDialogSelectItemToRemove)
	gosub, GuiRemoveFavoriteCleanup
	return
}
if (g_objMenuInGui[intItemToRemove].FavoriteType = "B")
{
	gosub, GuiRemoveFavoriteCleanup
	return
}
; remove favorite in object model (if menu, leaving submenu objects unlinked without releasing them)

blnItemIsMenu := (g_objMenuInGui[intItemToRemove].FavoriteType = "Menu")

if (blnItemIsMenu)
{
	MsgBox, 52, % L(lDialogFavoriteRemoveTitle, g_strAppNameText), % L(lDialogFavoriteRemovePrompt, g_objMenuInGui[intItemToRemove].Submenu.MenuPath)
	IfMsgBox, No
	{
		gosub, GuiRemoveFavoriteCleanup
		return
	}
	g_objMenusIndex.Remove(g_objMenuInGui[intItemToRemove].Submenu.MenuPath)
}
g_objMenuInGui.Remove(intItemToRemove)

; refresh menu dropdpown in gui

if (blnItemIsMenu)
	GuiControl, 1:, f_drpMenusList, % "|" . RecursiveBuildMenuTreeDropDown(g_objMainMenu, g_objMenuInGui.MenuPath) . "|"

; remove favorite in gui

LV_Delete(intItemToRemove)
if (A_ThisLabel = "GuiRemoveFavorite")
{
	LV_Modify(intItemToRemove, "Select Focus")
	if !LV_GetNext() ; if last item was deleted, select the new last item
		LV_Modify(LV_GetCount(), "Select Focus")
}
Gosub, AdjustColumnsWidth

GuiControl, Enable, f_btnGuiSaveFavorites
GuiControl, , f_btnGuiCancel, %lGuiCancel%

GuiRemoveFavoriteCleanup:
intItemToRemove := ""
blnItemIsMenu := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiMoveMultipleFavoritesUp:
GuiMoveMultipleFavoritesDown:
;------------------------------------------------------------

GuiControl, Focus, f_lvFavoritesList
Gui, 1:ListView, f_lvFavoritesList

g_blnAbortMultipleMove := false
strSelectedRows := ""
g_intRowToProcess := 0
loop
{
	g_intRowToProcess := LV_GetNext(g_intRowToProcess)
	strSelectedRows .= g_intRowToProcess . "|"
}
until !LV_GetNext(g_intRowToProcess)
StringTrimRight, strSelectedRows, strSelectedRows, 1

Loop
{
	Gosub, % (A_ThisLabel = "GuiMoveMultipleFavoritesUp" ? "GetFirstSelected" : "GetLastSelected") ; will re-init g_intRowToProcess
	if (!g_intRowToProcess) or (g_blnAbortMultipleMove)
		break
	
	g_intSelectedRow := g_intRowToProcess
	Gosub, % (A_ThisLabel = "GuiMoveMultipleFavoritesUp" ? "GuiMoveOneFavoriteUp" : "GuiMoveOneFavoriteDown")
}

if (!g_blnAbortMultipleMove)
	Loop, Parse, strSelectedRows, |
		LV_Modify(A_LoopField  + (A_ThisLabel = "GuiMoveMultipleFavoritesUp" ? -1 : 1), "Select")

LV_Modify(LV_GetNext(0), "Focus") ; give focus to the first selected row

g_blnAbortMultipleMove := ""
strSelectedRows := ""
g_intRowToProcess := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GetFirstSelected:
GetLastSelected:
;------------------------------------------------------------

g_intRowToProcess := 0

if (A_ThisLabel = "GetFirstSelected")
	g_intRowToProcess := LV_GetNext(g_intRowToProcess) ; start from first selected
else
	loop
		g_intRowToProcess := LV_GetNext(g_intRowToProcess) ; start with last selected
	until !LV_GetNext(g_intRowToProcess)

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiMoveFavoriteUp:
GuiMoveFavoriteDown:
GuiMoveOneFavoriteUp:
GuiMoveOneFavoriteDown:
;------------------------------------------------------------

if !InStr(A_ThisLabel, "One")
{
	GuiControl, Focus, f_lvFavoritesList
	Gui, 1:ListView, f_lvFavoritesList
	g_intSelectedRow := LV_GetNext()
}
if (g_intSelectedRow = 0)
{
	Oops(lDialogSelectItemToMove)
	return
}
if (g_intSelectedRow = (InStr(A_ThisLabel, "Up") ? (g_objMenuInGui[1].FavoriteType = "B" ? 2 : 1) ; if Up not higher that first non-back link favorite
	: LV_GetCount())) ; if Down not lower that last
	or (g_objMenuInGui[g_intSelectedRow].FavoriteType = "B") ; cannot move back link
{
	if InStr(A_ThisLabel, "One")
		g_blnAbortMultipleMove := true
	return
}

; --- move in menu object ---

MoveFavoriteInMenuObject(g_objMenuInGui, g_intSelectedRow, (InStr(A_ThisLabel, "Up") ? -1 : 1))

; --- move in Gui ---

Loop, 3
	LV_GetText(arrThis%A_Index%, g_intSelectedRow, A_Index)

Loop, 3
	LV_GetText(arrOther%A_Index%, g_intSelectedRow + (InStr(A_ThisLabel, "Up") ? -1 : 1), A_Index)

LV_Modify(g_intSelectedRow, "-Select")
LV_Modify(g_intSelectedRow, "", arrOther1, arrOther2, arrOther3)
LV_Modify(g_intSelectedRow + (InStr(A_ThisLabel, "Up") ? -1 : 1), , arrThis1, arrThis2, arrThis3)

if !InStr(A_ThisLabel, "One")
	LV_Modify(g_intSelectedRow + (InStr(A_ThisLabel, "Up") ? -1 : 1), "Select Focus Vis")

GuiControl, Enable, f_btnGuiSaveFavorites
GuiControl, , f_btnGuiCancel, %lGuiCancel%

return

;------------------------------------------------------------


;------------------------------------------------------------
MoveFavoriteInMenuObject(objMenu, intItem, intDirection)
; intDirection = +1 to to down or -1 to go up
;------------------------------------------------------------
{
	if (intItem + intDirection > objMenu.MaxIndex())
		or (intItem + intDirection < o.MinIndex())
		return

	objMenu.Insert(intItem + intDirection + (intDirection > 0 ? 1 : 0), objMenu[intItem])
	objMenu.Remove(intItem + (intDirection > 0 ? 0 : 1))
}	
;------------------------------------------------------------


;------------------------------------------------------------
GuiHotkeysManage:
GuiHotkeysManageFromQAPFeature:
;------------------------------------------------------------

if (A_ThisLabel = "GuiHotkeysManageFromQAPFeature")
	Gosub, GuiShow
	
intWidth := 840

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide

Gui, 2:New, , % L(lDialogHotkeysManageTitle, g_strAppNameText, g_strAppVersion)
Gui, 2:+Owner1
Gui, 2:+OwnDialogs
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%

Gui, 2:Font, w600
Gui, 2:Add, Text, x10 y10, % L(lDialogHotkeysManageAbout, g_strAppNameText)
Gui, 2:Font

Gui, 2:Add, Text, x10 y+10 w%intWidth%, % L(lDialogHotkeysManageIntro, lDialogHotkeysManageListSeeAllFavorites, lDialogHotkeysManageListSeeFullHotkeyNames)

Gui, 2:Add, Listview
	, % "vf_lvHotkeysManageList Count32 " . (g_blnUseColors ? "c" . g_strGuiListviewTextColor . " Background" . g_strGuiListviewBackgroundColor : "") 
	. " gHotkeysManageListEvents x10 y+10 w" . intWidth - 40. " h340"
	, Position (hidden)|%lDialogHotkeysManageListHeader%

Gui, 2:Add, Checkbox, vf_blnSeeAllFavorites gCheckboxSeeAllFavoritesClicked, %lDialogHotkeysManageListSeeAllFavorites%
Gui, 2:Add, Checkbox, x+50 yp vf_blnSeeShortHotkeyNames gCheckboxSeeShortHotkeyNames, %lDialogHotkeysManageListSeeShortHotkeyNames%
GuiControl, , f_blnSeeShortHotkeyNames, % (g_intHotkeyReminders = 2) ; 1 = no name, 2 = short names, 3 = full name

Gosub, LoadHotkeysManageList

Gui, 2:Add, Button, x+10 y+30 vf_btnHotkeysManageClose g2GuiClose h33, %lGui2Close%
GuiCenterButtons(L(lDialogHotkeysManageTitle, g_strAppNameText, g_strAppVersion), , , , "f_btnHotkeysManageClose")
Gui, 2:Add, Text, x10, %A_Space%

Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

intWidth := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
HotkeysManageListEvents:
;------------------------------------------------------------

Gui, 2:ListView, f_lvHotkeysList

if (A_GuiEvent = "DoubleClick")
{
	intItemPosition := LV_GetNext()
	LV_GetText(strFavoritePosition, intItemPosition, 1)
	LV_GetText(strMenuPath, intItemPosition, 2)
	LV_GetText(strHotkeyType, intItemPosition, 4)
	
	if (strHotkeyType = lDialogHotkeysManagePopup) ; this is a popup menu hotkey, go to Options, Menu hotkeys
	{
		MsgBox, 35, %g_strAppNameText%!, % L(lDialogChangeHotkeyPopup, lOptionsMouseAndKeyboard, lGuiOptions)
		IfMsgBox, Yes
		{
			Gosub, GuiOptions
			GuiControl, Choose, f_intOptionsTab, 2
		}
	}
	else if (strHotkeyType = lDialogHotkeysManagePower) ; this is Power menu feature, ### go to Options, Menu hotkeys
	{
		MsgBox, 35, %g_strAppNameText%!, % L(lDialogChangeHotkeyPopup, lOptionsPowerMenuFeatures, lGuiOptions)
		IfMsgBox, Yes
		{
			Gosub, GuiOptions
			GuiControl, Choose, f_intOptionsTab, 3
		}
	}
	else
	{
		g_objEditedFavorite := g_objMenusIndex[strMenuPath][strFavoritePosition]
		/*
		###_V(A_ThisLabel
			, strMenuPath . " / " . strFavoritePosition
			, g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation]
			, g_objEditedFavorite.FavoriteName
			, g_objEditedFavorite.FavoriteType
			, g_objEditedFavorite.FavoriteLocation
			, g_objQAPFeatures[g_objEditedFavorite.FavoriteLocation].DefaultHotkey
			, g_objEditedFavorite)
		*/
		
		strBackupFavoriteHotkey := g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation]
		g_strNewFavoriteHotkey := SelectHotkey(g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation]
			, g_objEditedFavorite.FavoriteName
			, g_objEditedFavorite.FavoriteType
			, g_objEditedFavorite.FavoriteLocation, 3
			, g_objQAPFeatures[g_objEditedFavorite.FavoriteLocation].DefaultHotkey)
		; SelectHotkey(strActualHotkey, strFavoriteName, strFavoriteType, strFavoriteLocation, intHotkeyType, strDefaultHotkey := "", strDescription := "")
		; intHotkeyType: 1 Mouse, 2 Keyboard, 3 Mouse or Keyboard
		; returns the new hotkey, "None" if no hotkey or empty string if cancel
		if !StrLen(g_strNewFavoriteHotkey)
			g_strNewFavoriteHotkey := strBackupFavoriteHotkey
		
		Gosub, UpdateHotkeyObjectsHotkeysListSave
	}
}

intItemPosition := ""
strMenuPath := ""
strFavoritePosition := ""
strNewHotkey := ""
strBackupFavoriteHotkey := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
LoadHotkeysManageList:
;------------------------------------------------------------
Gui, 2:Submit, NoHide

Gui, 2:Default
Gui, 2:ListView, f_lvHotkeysManageList
LV_Delete()

intHotkeysManageListWinID := WinExist("A")
if not DllCall("LockWindowUpdate", Uint, intHotkeysManageListWinID)
	Oops("An error occured while locking window display in`n" . L(lDialogHotkeysManageTitle, g_strAppNameText, g_strAppVersion))

; Position (hidden)|Menu|Favorite Name|Type|Hotkey|Favorite Location
loop, 4
	LV_Add(, , , g_arrOptionsPopupHotkeyTitles%A_Index%, lDialogHotkeysManagePopup
		, (f_blnSeeShortHotkeyNames ? g_arrPopupHotkeys%A_Index% : Hotkey2Text(g_arrPopupHotkeys%A_Index%)))

for strQAPFeatureCode in g_objQAPFeaturesDefaultNameByCode
{
	if (g_objQAPFeatures[strQAPFeatureCode].QAPFeaturePowerOrder)
		if HasHotkey(g_objQAPFeatures[strQAPFeatureCode].CurrentHotkey) or f_blnSeeAllFavorites
			LV_Add(, , lDialogHotkeysManagePowerMenu, g_objQAPFeatures[strQAPFeatureCode].LocalizedName, lDialogHotkeysManagePower
				, Hotkey2Text(g_objQAPFeatures[strQAPFeatureCode].CurrentHotkey), strQAPFeatureCode)
}

for strMenuPath, objMenu in g_objMenusIndex
	loop, % objMenu.MaxIndex()
		if StrLen(objMenu[A_Index].FavoriteLocation) and (g_objHotkeysByLocation.HasKey(objMenu[A_Index].FavoriteLocation) or f_blnSeeAllFavorites)
		{
			strThisHotkey := (StrLen(g_objHotkeysByLocation[objMenu[A_Index].FavoriteLocation]) ? g_objHotkeysByLocation[objMenu[A_Index].FavoriteLocation] : lDialogNone)
			LV_Add(, A_Index
				, strMenuPath, objMenu[A_Index].FavoriteName, objMenu[A_Index].FavoriteType
				, (f_blnSeeShortHotkeyNames ? strThisHotkey : Hotkey2Text(strThisHotkey))
				, objMenu[A_Index].FavoriteLocation)
		}

LV_ModifyCol(2, "Sort")
LV_ModifyCol(1, 0)
Loop, % LV_GetCount("Column") - 1
	LV_ModifyCol(A_Index + 1, "AutoHdr")

DllCall("LockWindowUpdate", Uint, 0)  ; Pass 0 to unlock the currently locked window.

strMenuPath := ""
objMenu := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckboxSeeAllFavoritesClicked:
CheckboxSeeShortHotkeyNames:
;------------------------------------------------------------

Gosub, LoadHotkeysManageList

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiAddSeparator:
GuiAddColumnBreak:
;------------------------------------------------------------

GuiControl, Focus, f_lvFavoritesList
Gui, 1:ListView, f_lvFavoritesList

if (LV_GetCount("Selected") > 1)
	or (LV_GetNext() = 1 and g_objMenuInGui[1].FavoriteType = "B")
	return

intInsertPosition := LV_GetCount() ? (LV_GetNext() ? LV_GetNext() : LV_GetCount() + 1) : 1

; --- add in menu object ---

objNewFavorite := Object()
if (A_ThisLabel = "GuiAddSeparator")
{
	objNewFavorite.FavoriteType := "X"
	objNewFavorite.FavoriteName := ""
	objNewFavorite.FavoriteLocation := ""
}
else ; GuiAddColumnBreak
{
	objNewFavorite.FavoriteType := "K"
	objNewFavorite.FavoriteName := ""
	objNewFavorite.FavoriteLocation := ""
}
g_objMenuInGui.Insert(intInsertPosition, objNewFavorite)

; --- add in Gui ---

LV_Modify(0, "-Select")

if (A_ThisLabel = "GuiAddSeparator")
	LV_Insert(intInsertPosition, "Select Focus", g_strGuiMenuSeparator, g_strGuiMenuSeparatorShort, g_strGuiMenuSeparator . g_strGuiMenuSeparator)
else ; GuiAddColumnBreak
	LV_Insert(intInsertPosition, "Select Focus", g_strGuiDoubleLine . " " . lMenuColumnBreak . " " . g_strGuiDoubleLine
		, g_strGuiDoubleLine, g_strGuiDoubleLine . " " . lMenuColumnBreak . " " . g_strGuiDoubleLine)

LV_Modify(LV_GetNext(), "Vis")
Gosub, AdjustColumnsWidth

GuiControl, Enable, f_btnGuiSaveFavorites
GuiControl, , f_btnGuiCancel, %lGuiCancel%

intInsertPosition := ""
objNewFavorite := ""

return
;------------------------------------------------------------


;========================================================================================================================
; END OF FAVORITE_GUI_OTHER
;========================================================================================================================


;========================================================================================================================
!_038_FAVORITE_GUI_SAVE:
;========================================================================================================================

;------------------------------------------------------------
GuiSaveFavorites:
;------------------------------------------------------------

g_blnMenuReady := false

IniDelete, %g_strIniFile%, Favorites

g_intIniLine := 1 ; reset counter before saving to another ini file
RecursiveSaveFavoritesToIniFile(g_objMainMenu)

Loop, % g_objHotkeysToDisableWhenSave.MaxIndex()
	Hotkey, % g_objHotkeysToDisableWhenSave[A_Index], , Off UseErrorLevel ; if used elsewhere, will be reloaded by LoadFavoriteHotkeys
; if (ErrorLevel) do nothing. This can happen when changing a hotkey twice before saving
g_objHotkeysToDisableWhenSave := ""

; clean-up unused hotkeys if favorites were deleted
for strThisLocation, strThisHotkey in g_objHotkeysByLocation
	if RecursiveHotkeyNotNeeded(strThisLocation, g_objMainMenu)
	{
		g_objHotkeysByLocation.Remove(strThisLocation)
		Hotkey, %strThisHotkey%, , Off
	}

Gosub, SaveHotkeysToIni
	
Gosub, LoadFavoriteHotkeys
Gosub, ReloadIniFile
Gosub, BuildMainMenuWithStatus ; only here we load hotkeys, when user save favorites

GuiControl, Disable, %lGuiSave%
GuiControl, , %lGuiCancel%, %lGuiClose%

Gosub, GuiCancel
g_blnMenuReady := true

g_intIniLine := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveSaveFavoritesToIniFile(objCurrentMenu)
;------------------------------------------------------------
{
	global g_strIniFile
	global g_intIniLine
	global g_strEscapePipe
	
	Loop, % objCurrentMenu.MaxIndex()
	{
		; skip ".." back link to parent menu
		blnIsBackMenu := (objCurrentMenu[A_Index].FavoriteType = "B")
		if !(blnIsBackMenu)
		{
			; make sure we do not save a menu separator after a column break - this would confuse the references to menu object index
			if (A_Index > 1)
				if (objCurrentMenu[A_Index].FavoriteType = "X") and (objCurrentMenu[A_Index - 1].FavoriteType = "K")
					continue

			strIniLine := objCurrentMenu[A_Index].FavoriteType . "|" ; 1
			if (objCurrentMenu[A_Index].FavoriteType = "QAP")
				strIniLine .= "|" ; do not save name to ini file, use current language feature name when loading ini file
			else
				strIniLine .= ReplaceAllInString(objCurrentMenu[A_Index].FavoriteName, "|", g_strEscapePipe) . "|" ; 2
			strIniLine .= ReplaceAllInString(objCurrentMenu[A_Index].FavoriteLocation, "|", g_strEscapePipe) . "|" ; 3
			strIniLine .= objCurrentMenu[A_Index].FavoriteIconResource . "|" ; 4
			strIniLine .= ReplaceAllInString(objCurrentMenu[A_Index].FavoriteArguments, "|", g_strEscapePipe) . "|" ; 5
			strIniLine .= objCurrentMenu[A_Index].FavoriteAppWorkingDir . "|" ; 6
			strIniLine .= objCurrentMenu[A_Index].FavoriteWindowPosition . "|" ; 7
			; REMOVED strIniLine .= objCurrentMenu[A_Index].FavoriteHotkey . "|" ; 8
			strIniLine .= objCurrentMenu[A_Index].FavoriteLaunchWith . "|" ; 8
			strIniLine .= ReplaceAllInString(objCurrentMenu[A_Index].FavoriteLoginName, "|", g_strEscapePipe) . "|" ; 9
			strIniLine .= ReplaceAllInString(objCurrentMenu[A_Index].FavoritePassword, "|", g_strEscapePipe) . "|" ; 10
			strIniLine .= objCurrentMenu[A_Index].FavoriteGroupSettings . "|" ; 11
			strIniLine .= objCurrentMenu[A_Index].FavoriteFtpEncoding . "|" ; 12

			IniWrite, %strIniLine%, %g_strIniFile%, Favorites, Favorite%g_intIniLine%
			g_intIniLine++
		}
		
		if InStr("Menu|Group", objCurrentMenu[A_Index].FavoriteType) and !(blnIsBackMenu)
		{
			; ###_V("Going down in:", objCurrentMenu[A_Index].SubMenu.MenuPath, objCurrentMenu[A_Index].FavoriteType)
			RecursiveSaveFavoritesToIniFile(objCurrentMenu[A_Index].SubMenu) ; RECURSIVE
			; ###_V("Going up back in", objCurrentMenu.MenuPath, objCurrentMenu[A_Index].FavoriteType)
		}
	}
		
	IniWrite, Z, %g_strIniFile%, Favorites, Favorite%g_intIniLine% ; end of menu marker
	g_intIniLine++
	
	return
}
;------------------------------------------------------------


;========================================================================================================================
; END OF FAVORITES LIST
;========================================================================================================================


;========================================================================================================================
!_040_GUI_CHANGE_HOTKEY:
return
;========================================================================================================================

; Gui in function, see from daniel2 http://www.autohotkey.com/board/topic/19880-help-making-gui-work-inside-a-function/#entry130557

;------------------------------------------------------------
SelectHotkey(strActualHotkey, strFavoriteName, strFavoriteType, strFavoriteLocation, intHotkeyType, strDefaultHotkey := "", strDescription := "")
; intHotkeyType: 1 Mouse, 2 Keyboard, 3 Mouse or Keyboard
; returns the new hotkey, "None" if no hotkey or empty string if cancel
;------------------------------------------------------------
{
	; safer than declaring individual variables (see "Common source of confusion" in https://www.autohotkey.com/docs/Functions.htm#Locals)
	global

	; ###_V("SelectHotkey", strActualHotkey, strFavoriteName, strFavoriteType, strFavoriteLocation, intHotkeyType, strDefaultHotkey, strDescription)
	SplitHotkey(strActualHotkey, strActualModifiers, strActualKey, strActualMouseButton, strActualMouseButtonsWithDefault)

	intGui2WinID := WinExist("A")

	Gui, 3:New, , % L(lDialogChangeHotkeyTitle, g_strAppNameText, g_strAppVersion)
	Gui, 3:Default
	Gui, +Owner2
	Gui, +OwnDialogs
	
	if (g_blnUseColors)
		Gui, Color, %g_strGuiWindowColor%
	Gui, Font, s10 w700, Verdana
	Gui, Add, Text, x10 y10 w400 center, % L(lDialogChangeHotkeyTitle, g_strAppNameText)
	Gui, Font

	Gui, Add, Text, y+15 x10, %lDialogTriggerFor%
	Gui, Font, s8 w700
	Gui, Add, Text, x+5 yp w300 section, % strFavoriteName . (StrLen(strFavoriteType) ? " (" . strFavoriteType . ")" : "")
	Gui, Font
	if StrLen(strFavoriteLocation)
		Gui, Add, Text, xs y+5 w300, %strFavoriteLocation%
	if StrLen(strDescription)
	{
		StringReplace, strDescription, strDescription, <A> ; remove links from description (already displayed in previous dialog box)
		StringReplace, strDescription, strDescription, </A>
		Gui, Add, Text, xs y+5 w300, %strDescription%
	}

	Gui, Add, CheckBox, y+20 x50 vf_blnShift, %lDialogShift%
	GuiControlGet, arrTop, Pos, f_blnShift
	Gui, Add, CheckBox, y+10 x50 vf_blnCtrl, %lDialogCtrl%
	Gui, Add, CheckBox, y+10 x50 vf_blnAlt, %lDialogAlt%
	Gui, Add, CheckBox, y+10 x50 vf_blnWin, %lDialogWin%
	Gosub, SetModifiersCheckBox

	if (intHotkeyType = 1)
		Gui, Add, DropDownList, % "y" . arrTopY . " x150 w200 vf_drpHotkeyMouse gMouseChanged", %strActualMouseButtonsWithDefault%
	if (intHotkeyType = 3)
	{
		Gui, Add, Text, % "y" . arrTopY . " x150 w60", %lDialogMouse%
		Gui, Add, DropDownList, yp x+10 w200 vf_drpHotkeyMouse gMouseChanged, %strActualMouseButtonsWithDefault%
		Gui, Add, Text, % "y" . arrTopY + 20 . " x150", %lDialogOr%
	}
	if (intHotkeyType <> 1)
	{
		Gui, Add, Text, % "y" . arrTopY + (intHotkeyType = 2 ? 0 : 40) . " x150 w60", %lDialogKeyboard%
		Gui, Add, Hotkey, yp x+10 w130 vf_strHotkeyKey gHotkeyChanged section
		GuiControl, , f_strHotkeyKey, %strActualKey%
	}
	if (intHotkeyType <> 1)
		Gui, Add, Link, y+5 xs w130 gHotkeySpaceTabClicked, %lDialogSpacebarTab% ; space or tab

	Gui, Add, Button, % "x10 y" . arrTopY + 100 . " vf_btnNoneHotkey gSelectNoneHotkeyClicked", %lDialogNone%
	if StrLen(strDefaultHotkey)
	{
		Gui, Add, Button, % "x10 y" . arrTopY + 100 . " vf_btnResetHotkey gButtonResetHotkey", %lGuiResetDefault%
		GuiCenterButtons(L(lDialogChangeHotkeyTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnNoneHotkey", "f_btnResetHotkey")
	}
	else
	{
		Gui, Add, Text, % "x10 y" . arrTopY + 100
		GuiCenterButtons(L(lDialogChangeHotkeyTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnNoneHotkey")
	}
	if StrLen(strFavoriteLocation)
		Gui, Add, Text, x50 y+25 w300 center, % L(lDialogChangeHotkeyNote, strFavoriteLocation)
		
	Gui, Add, Button, y+25 x10 vf_btnChangeHotkeyOK gButtonChangeHotkeyOK, %lDialogOK%
	Gui, Add, Button, yp x+20 vf_btnChangeHotkeyCancel gButtonChangeHotkeyCancel, %lGuiCancel%
	
	GuiCenterButtons(L(lDialogChangeHotkeyTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnChangeHotkeyOK", "f_btnChangeHotkeyCancel")

	Gui, Add, Text
	GuiControl, Focus, f_btnChangeHotkeyOK
	Gui, Show, AutoSize Center

	Gui, 2:+Disabled
	WinWaitClose,  % L(lDialogChangeHotkeyTitle, g_strAppNameText, g_strAppVersion) ; waiting for Gui to close

	if (strNewHotkey <> strActualHotkey)
		strNewHotkey := HotkeyIfAvailable(strNewHotkey, (StrLen(strFavoriteLocation) ? strFavoriteLocation : strFavoriteName))
	
	return strNewHotkey ; returning value
	
	;------------------------------------------------------------

	;------------------------------------------------------------
	MouseChanged:
	;------------------------------------------------------------

	strMouseControl := A_GuiControl ; hotkey var name
	GuiControlGet, strMouseValue, , %strMouseControl%

	if (strMouseValue = lDialogNone) ; this is the translated "None"
	{
		GuiControl, , f_blnShift, 0
		GuiControl, , f_blnCtrl, 0
		GuiControl, , f_blnAlt, 0
		GuiControl, , f_blnWin, 0
	}

	if (intHotkeyType = 3) ; both keyboard and mouse options are available
		; we have a mouse button, empty the hotkey control
		GuiControl, , f_strHotkeyKey, None

	return
	;------------------------------------------------------------
	
	;------------------------------------------------------------
	HotkeyChanged:
	;------------------------------------------------------------
	strHotkeyControl := A_GuiControl ; hotkey var name
	strHotkeyChanged := %strHotkeyControl% ; hotkey content

	if !StrLen(strHotkeyChanged)
		return

	SplitModifiersFromKey(strHotkeyChanged, strHotkeyChangedModifiers, strHotkeyChangedKey)

	if StrLen(strHotkeyChangedModifiers) ; we have a modifier and we don't want it, reset keyboard to none and return
		GuiControl, , %A_GuiControl%, None
	else ; we have a valid key, empty the mouse dropdown and return
		GuiControl, Choose, f_drpHotkeyMouse, 0

	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	SelectNoneHotkeyClicked:
	;------------------------------------------------------------

	GuiControl, , f_strHotkeyKey, %lDialogNone%
	GuiControl, Choose, f_drpHotkeyMouse, %lDialogNone%
	SplitHotkey("None", strActualModifiers, strActualKey, strActualMouseButton, strActualMouseButtonsWithDefault)
	Gosub, SetModifiersCheckBox

	; OUT OK? strModifiers := ""

	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	HotkeySpaceTabClicked:
	;------------------------------------------------------------
	
	if (ErrorLevel = "Space")
		GuiControl, , f_strHotkeyKey, %A_Space%
	else
		GuiControl, , f_strHotkeyKey, %A_Tab%
	GuiControl, Choose, f_drpHotkeyMouse, 0

	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	ButtonResetHotkey:
	;------------------------------------------------------------

	SplitHotkey(strDefaultHotkey, strActualModifiers, strActualKey, strActualMouseButton, strActualMouseButtonsWithDefault)
	GuiControl, , f_strHotkeyKey, %strActualKey%
	GuiControl, Choose, f_drpHotkeyMouse, % GetText4MouseButton(strActualMouseButton)
	Gosub, SetModifiersCheckBox
	
	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	SetModifiersCheckBox:
	;------------------------------------------------------------
	GuiControl, , f_blnShift, % InStr(strActualModifiers, "+") ? 1 : 0
	GuiControl, , f_blnCtrl, % InStr(strActualModifiers, "^") ? 1 : 0
	GuiControl, , f_blnAlt, % InStr(strActualModifiers, "!") ? 1 : 0
	GuiControl, , f_blnWin, % InStr(strActualModifiers, "#") ? 1 : 0
	
	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	ButtonChangeHotkeyOK:
	;------------------------------------------------------------
	
	GuiControlGet, strMouse, , f_drpHotkeyMouse
	GuiControlGet, strKey, , f_strHotkeyKey
	GuiControlGet, blnWin , ,f_blnWin
	GuiControlGet, blnAlt, , f_blnAlt
	GuiControlGet, blnCtrl, , f_blnCtrl
	GuiControlGet, blnShift, , f_blnShift

	if StrLen(strMouse)
		strMouse := GetMouseButton4Text(strMouse) ; get mouse button system name from dropdown localized text
	; else ???
	;	strMouseButton%intIndex% := "" ;  empty mouse button text
	
	strNewHotkey := Trim(strKey . (strMouse = "None" ? "" : strMouse))
	if !StrLen(strNewHotkey)
		strNewHotkey := "None"
	
	if HasHotkey(strNewHotkey)
	{
		; Order of modifiers important to keep modifiers labels in correct order
		if (blnWin)
			strNewHotkey := "#" . strNewHotkey
		if (blnAlt)
			strNewHotkey := "!" . strNewHotkey
		if (blnCtrl)
			strNewHotkey := "^" . strNewHotkey
		if (blnShift)
			strNewHotkey := "+" . strNewHotkey

		if (strNewHotkey = "LButton")
		{
			Oops(lDialogMouseCheckLButton, lDialogShift, lDialogCtrl, lDialogAlt, lDialogWin)
			strNewHotkey := ""
			return
		}
	}

	Gosub, 3GuiClose
	
	return
	;------------------------------------------------------------

	;------------------------------------------------------------
	ButtonChangeHotkeyCancel:
	;------------------------------------------------------------
	
	strHotkey := ""

	Gosub, 3GuiClose
  
	return
	;------------------------------------------------------------

}
;------------------------------------------------------------


;-----------------------------------------------------------
UpdateHotkeyObjectsFavoriteSave:
UpdateHotkeyObjectsHotkeysListSave:
;-----------------------------------------------------------

; if the hotkey changed, add new hotkey and remember the hotkey to turn off
if (g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation] <> g_strNewFavoriteHotkey)
{
	if g_objHotkeysByLocation.HasKey(g_objEditedFavorite.FavoriteLocation)
		; used when favorites are saved, must be before g_objHotkeysByLocation.Insert
		g_objHotkeysToDisableWhenSave.Insert(g_objHotkeysByLocation[g_objEditedFavorite.FavoriteLocation])
	
	if HasHotkey(g_strNewFavoriteHotkey)
		; must be after g_objHotkeysToDisableWhenSave.Insert
		g_objHotkeysByLocation.Insert(g_objEditedFavorite.FavoriteLocation, g_strNewFavoriteHotkey)
	else
		g_objHotkeysByLocation.Remove(g_objEditedFavorite.FavoriteLocation)
}

if (A_ThisLabel = "UpdateHotkeyObjectsHotkeysListSave")
{
	GuiControl, 1:Enable, f_btnGuiSaveFavorites
	Gosub, LoadHotkeysManageList
}

return
;-----------------------------------------------------------


;-----------------------------------------------------------
HotkeyIfAvailable(strHotkey, strLocation)
;-----------------------------------------------------------
{
	global g_arrPopupHotkeys
	global g_objQAPFeatures
	global g_arrOptionsPopupHotkeyTitles
	
	if !StrLen(strHotkey) or (strHotkey = "None")
		return strHotkey
	
	; check popup menu hotkeys
	loop, 4
		if (g_arrPopupHotkeys%A_Index% = strHotkey)
		{
			strExistingLocation := g_arrOptionsPopupHotkeyTitles%A_Index%
			break
		}
	
	; check QAP Features Power menu hotkeys
	for strCode, objThisQAPFeature in g_objQAPFeatures
		if (objThisQAPFeature.CurrentHotkey = strHotkey)
		{
			strExistingLocation := strCode
			break
		}
	
	; check favorites hotkeys
	if !StrLen(strExistingLocation)
		strExistingLocation := GetHotkeyLocation(strHotkey)
	
	if StrLen(strExistingLocation)
	{
		Oops(lOopsHotkeyAlreadyUsed, Hotkey2Text(strHotkey), FormatExistingLocation(strExistingLocation), FormatExistingLocation(strLocation))
		return ""
	}
	else
		return strHotkey
}
;-----------------------------------------------------------


;-----------------------------------------------------------
FormatExistingLocation(strExistingLocation)
;-----------------------------------------------------------
{
	global g_strGroupIndicatorPrefix
	global g_strGroupIndicatorSuffix
	global g_strMenuPathSeparator
	
	if InStr(strExistingLocation, g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix)
		strExisting := lOopsGroup
	else if SubStr(strExistingLocation, 1, 1) = g_strMenuPathSeparator
		strExisting := lMenuMenu
	else if SubStr(strExistingLocation, 1, 1) = "{"
		strExisting := lOopsQAPfeature
	else
		strExisting := lOopsLocation
	
	return strExisting . " """ . strExistingLocation . """"
}
;-----------------------------------------------------------


;------------------------------------------------------------
LoadFavoriteHotkeys:
;------------------------------------------------------------

; RecursiveLoadFavoriteHotkeys(g_objMainMenu) ; recurse for submenus

for strLocation, strHotkey in g_objHotkeysByLocation
{
	Hotkey, %strHotkey%, OpenFavoriteFromHotkey, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkeyFavorite, strHotkey, strLocation)
}

return
;------------------------------------------------------------


;------------------------------------------------------------
SaveHotkeysToIni:
;------------------------------------------------------------

IniDelete, %g_strIniFile%, LocationHotkeys

g_intIniLine := 1
for strLocation, strHotkey in g_objHotkeysByLocation
{
	IniWrite, %strLocation%|%strHotkey%, %g_strIniFile%, LocationHotkeys, Hotkey%g_intIniLine%
	g_intIniLine++
}

strHotkey := ""
strLocation := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveHotkeyNotNeeded(strHotkeyLocation, objCurrentMenu)
;------------------------------------------------------------
{
	Loop, % objCurrentMenu.MaxIndex()
	{
		if InStr("B|X|K", objCurrentMenu[A_Index].FavoriteType) ; skip back link and separators
			continue
		
		if (objCurrentMenu[A_Index].FavoriteType = "Menu")
		{
			blnHotkeyNotNeeded := RecursiveHotkeyNotNeeded(strHotkeyLocation, objCurrentMenu[A_Index].SubMenu) ; RECURSIVE
			if !(blnHotkeyNotNeeded)
				return false ; we need this hotkey, stop recursion
		}
			
		if (objCurrentMenu[A_Index].FavoriteLocation = strHotkeyLocation)
			; ###_V("Hotkey NEEDED", objCurrentMenu[A_Index].FavoriteName, strHotkeyLocation, objCurrentMenu[A_Index].FavoriteLocation)
			return false
	}
	
	; ###_V("Hotkey NOT NEEDED in menu", objCurrentMenu.MenuPath)
	return true
}
;------------------------------------------------------------


;------------------------------------------------------------
GetHotkeyLocation(strHotkey)
;------------------------------------------------------------
{
	global g_objHotkeysByLocation
	
	for strLocation, strThisHotkey in g_objHotkeysByLocation
		if (strHotkey = strThisHotkey)
			; ###_V("GetHotkeyLocation FOUND", strHotkey, strLocation)
			return strLocation
	
	; ###_V("GetHotkeyLocation NOT FOUND", strHotkey)
	return ""
}


;========================================================================================================================
; END OF GUI_CHANGE_HOTKEY:
;========================================================================================================================


;========================================================================================================================
!_050_GUI_CLOSE-CANCEL-BK_OBJECTS:
;========================================================================================================================


;------------------------------------------------------------
GuiClose:
GuiEscape:
;------------------------------------------------------------

GoSub, GuiCancel

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiCancel:
;------------------------------------------------------------

GuiControlGet, blnSaveEnabled, Enabled, f_btnGuiSaveFavorites
if (blnSaveEnabled)
{
	Gui, 1:+OwnDialogs
	MsgBox, 36, % L(lDialogCancelTitle, g_strAppNameText, g_strAppVersion), %lDialogCancelPrompt%
	IfMsgBox, Yes
	{
		g_blnMenuReady := false
		
		Gosub, RestoreBackupMenusObjects

		; restore popup menu
		Gosub, BuildCurrentFoldersMenu
		Gosub, BuildMainMenu ; rebuild menus but not hotkeys
		
		GuiControl, Disable, f_btnGuiSaveFavorites
		GuiControl, , f_btnGuiCancel, %lGuiClose%
		g_blnMenuReady := true
	}
	IfMsgBox, No
	{
		gosub, GuiCancelCleanup
		return
	}
}
Gui, 1:Cancel

GuiCancelCleanup:
blnSaveEnabled := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
2GuiClose:
2GuiEscape:
;------------------------------------------------------------

Gui, 1:-Disabled
Gui, 2:Destroy
WinActivate, ahk_id %g_intGui1WinID%

return
;------------------------------------------------------------


;------------------------------------------------------------
3GuiClose:
3GuiEscape:
;------------------------------------------------------------

Gui, 2:-Disabled
Gui, 3:Destroy
WinActivate, ahk_id %intGui2WinID%

return
;------------------------------------------------------------


;------------------------------------------------------------
BackupMenusObjects:
RestoreBackupMenusObjects:
; in case of Gui Cancel to restore objects to original state
;------------------------------------------------------------

if (A_ThisLabel = "BackupMenusObjects")
{
	objMenusSource := g_objMenusIndex
	g_objMenusBK := Object() ; re-init
}
else ; RestoreBackupMenusObjects
{
	objMenusSource := g_objMenusBK
	g_objMenusIndex := Object() ; re-init
}

for strMenuPath, objMenuSource in objMenusSource
{
	objMenuDest := Object()
	objMenuDest.MenuPath := objMenuSource.MenuPath
	objMenuDest.MenuType := objMenuSource.MenuType

	loop, % objMenuSource.MaxIndex()
	{
		objFavorite := Object()
		objFavorite.FavoriteType := objMenuSource[A_Index].FavoriteType
		objFavorite.FavoriteName := objMenuSource[A_Index].FavoriteName
		objFavorite.FavoriteLocation := objMenuSource[A_Index].FavoriteLocation
		objFavorite.FavoriteIconResource := objMenuSource[A_Index].FavoriteIconResource
		objFavorite.FavoriteArguments := objMenuSource[A_Index].FavoriteArguments
		objFavorite.FavoriteAppWorkingDir := objMenuSource[A_Index].FavoriteAppWorkingDir
		objFavorite.FavoriteWindowPosition := objMenuSource[A_Index].FavoriteWindowPosition
		; REMOVED objFavorite.FavoriteHotkey := objMenuSource[A_Index].FavoriteHotkey
		objFavorite.FavoriteLaunchWith := objMenuSource[A_Index].FavoriteLaunchWith
		; do not backup objMenuSource[A_Index].SubMenu because we have to recreate them
		; after menu/groups objects are recreated during restore
		objMenuDest.Insert(objFavorite)
	}
	
	if (A_ThisLabel = "BackupMenusObjects")
		g_objMenusBK.Insert(strMenuPath, objMenuDest)
	else ; RestoreBackupMenusObjects
		g_objMenusIndex.Insert(strMenuPath, objMenuDest)
}

if (A_ThisLabel = "RestoreBackupMenusObjects")
{
	g_objMainMenu := g_objMenusIndex[lMainMenuName] ; re-connect main menu
	for strMenuPath, objMenuDest in g_objMenusIndex
		loop, % objMenuDest.MaxIndex()
			if InStr("Menu|Group", objMenuDest[A_Index].FavoriteType)
			{
				objSubMenu := Object()
				objSubMenu.MenuPath := lMainMenuName . " " . objMenuDest[A_Index].FavoriteLocation
				objSubMenu.MenuType := objMenuDest[A_Index].FavoriteType
				objMenuDest[A_Index].SubMenu := g_objMenusIndex[objSubMenu.MenuPath] ; re-connect sub menu
			}

	g_objMenusBK := ""
}

; also back hotkey objects

if (A_ThisLabel = "BackupMenusObjects")
{
	g_objHotkeysByLocationBK := Object()
	for strThisLocation, strThisHotkey in g_objHotkeysByLocation
		g_objHotkeysByLocationBK.Insert(strThisLocation, strThisHotkey)
}
else
{
	for strThisLocation, strThisHotkey in g_objHotkeysByLocationBK
		g_objHotkeysByLocation.Insert(strThisLocation, strThisHotkey)
	g_objHotkeysByLocationBK := ""
}

objMenusSource := ""
strMenuPath := ""
objMenuSource := ""
objMenuDest := ""
objFavorite := ""
objSubMenu := ""
strThisLocation := ""
strThisHotkey := ""

return
;------------------------------------------------------------



;========================================================================================================================
; END OF GUI CLOSE-CANCEL-BK_OBJECTS
;========================================================================================================================


;========================================================================================================================
!_060_POPUP_MENU:
;========================================================================================================================

;------------------------------------------------------------
NavigateHotkeyMouse:
NavigateHotkeyKeyboard:
LaunchHotkeyMouse:
LaunchHotkeyKeyboard:
LaunchFromTrayIcon:
LaunchFromPowerMenu:
;------------------------------------------------------------

if !(g_blnMenuReady)
	return

Gosub, SetMenuPosition

g_blnPowerMenu := (A_ThisLabel = "LaunchFromPowerMenu")
if !(g_blnPowerMenu)
	g_strPowerMenu := "" ; delete from previous call to Power key, else keep what was set in OpenPowerMenu

if (A_ThisLabel = "LaunchFromTrayIcon")
{
	SetTargetClassWinIdAndControl(false)
	g_strHokeyTypeDetected := "Launch"
}
else if (A_ThisLabel = "LaunchFromPowerMenu")
	g_strHokeyTypeDetected := "Power"
else
	g_strHokeyTypeDetected := SubStr(A_ThisLabel, 1, InStr(A_ThisLabel, "Hotkey") - 1) ; "Navigate" or "Launch"

; ###_V(A_ThisLabel, g_strTargetClass, g_strTargetWinId)

if (WindowIsDirectoryOpus(g_strTargetClass) or WindowIsTotalCommander(g_strTargetClass) or WindowIsQAPconnect(g_strTargetWinId)
	and InStr(A_ThisLabel, "Mouse") and (g_strHokeyTypeDetected = "Navigate"))
{
	Click ; to make sure the DOpus lister or TC pane under the mouse become active
	Sleep, 20
}

if g_objQAPfeaturesInMenus.HasKey("{Current Folders}") ; we have this QAP feature in at least one menu
	Gosub, BuildCurrentFoldersMenu

if g_objQAPfeaturesInMenus.HasKey("{Clipboard}") ; we have this QAP feature in at least one menu
	Gosub, RefreshClipboardMenu

Gosub, InsertColumnBreaks

Menu, %lMainMenuName%, Show, %g_intMenuPosX%, %g_intMenuPosY% ; at mouse pointer if option 1, 20x20 offset of active window if option 2 and fix location if option 3

return
;------------------------------------------------------------


;------------------------------------------------------------
PowerHotkeyMouse:
PowerHotkeyKeyboard:
;------------------------------------------------------------

g_blnPowerMenu := true
g_strHokeyTypeDetected := "Power"

Menu, g_menuPower, Show

return
;------------------------------------------------------------


;------------------------------------------------------------
SetMenuPosition:
;------------------------------------------------------------

; relative to active window if option g_intPopupMenuPosition = 2
CoordMode, Mouse, % (g_intPopupMenuPosition = 2 ? "Window" : "Screen")
CoordMode, Menu, % (g_intPopupMenuPosition = 2 ? "Window" : "Screen")

if (g_intPopupMenuPosition = 1) ; display menu near mouse pointer location
	MouseGetPos, g_intMenuPosX, g_intMenuPosY
else if (g_intPopupMenuPosition = 2) ; display menu at an offset of 20x20 pixel from top-left of active window area
{
	g_intMenuPosX := 20
	g_intMenuPosY := 20
}
else ; (g_intPopupMenuPosition =  3) - fix position - use the g_intMenuPosX and g_intMenuPosY values from the ini file
{
	g_intMenuPosX := g_arrPopupFixPosition1
	g_intMenuPosY := g_arrPopupFixPosition2
}

return
;------------------------------------------------------------


;------------------------------------------------------------
CanNavigate(strMouseOrKeyboard) ; SEE HotkeyIfWin.ahk to use Hotkey, If, Expression
; "CabinetWClass" and "ExploreWClass" -> Explorer
; "ProgMan" -> Desktop
; "WorkerW" -> Desktop
; "ConsoleWindowClass" -> Console (CMD)
; "#32770" -> Dialog
; "bosa_sdm_" (...) -> Dialog MS Office under WinXP
;------------------------------------------------------------
{
	global ; sets g_strTargetWinId, g_strTargetControl, g_strTargetClass

	; Mouse hotkey (g_arrPopupHotkeys1 is NavigateOrLaunchHotkeyMouse value in ini file)
	SetTargetClassWinIdAndControl(strMouseOrKeyboard = g_arrPopupHotkeys1)

	; ###_V("CanNavigate", g_intActiveFileManager, g_strTargetWinId, WindowIsQAPconnect(g_strTargetWinId))
	blnCanNavigate := WindowIsExplorer(g_strTargetClass) or WindowIsDesktop(g_strTargetClass) or WindowIsConsole(g_strTargetClass)
		or (g_blnChangeFolderInDialog and WindowIsDialog(g_strTargetClass, g_strTargetWinId))
		or (g_intActiveFileManager = 2 and WindowIsDirectoryOpus(g_strTargetClass))
		or (g_intActiveFileManager = 3 and WindowIsTotalCommander(g_strTargetClass))
		or (g_intActiveFileManager = 4 and WindowIsQAPconnect(g_strTargetWinId))
		or WindowIsQuickAccessPopup(g_strTargetClass)

	return blnCanNavigate
}
;------------------------------------------------------------


;------------------------------------------------------------
CanLaunch(strMouseOrKeyboard) ; SEE HotkeyIfWin.ahk to use Hotkey, If, Expression
;------------------------------------------------------------
{
	global

	g_intCounterLaunch++

	; g_arrPopupHotkeys1 is mouse hotkey
	SetTargetClassWinIdAndControl(strMouseOrKeyboard = g_arrPopupHotkeys1)
	strExclusionClassList := (strMouseOrKeyboard = g_arrPopupHotkeys1 ? g_strExclusionMouseClassList : g_strExclusionKeyboardClassList)
	; ###_V("CanLaunch`n`n", g_strExclusionClassList, g_strTargetClass . "|")

	Loop, Parse, strExclusionClassList, |
		if StrLen(A_Loopfield) and InStr(g_strTargetClass, A_LoopField)
			return false
	; if not excluded
	return true
}
;------------------------------------------------------------



;========================================================================================================================
; END OF POPUP MENU
;========================================================================================================================



;========================================================================================================================
!_065_CLASS:
return
;========================================================================================================================

;------------------------------------------------------------
WindowIsExplorer(strClass)
;------------------------------------------------------------
{
	return (strClass = "CabinetWClass") or (strClass = "ExploreWClass")
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsDesktop(strClass)
;------------------------------------------------------------
{
	global g_blnOpenMenuOnTaskbar
	global blnClickOnTrayIcon
	
	blnWindowIsDesktop := (strClass = "ProgMan")
		or (strClass = "WorkerW")
		or (strClass = "Shell_TrayWnd" and (g_blnOpenMenuOnTaskbar or blnClickOnTrayIcon))
		or (strClass = "NotifyIconOverflowWindow")

	blnClickOnTrayIcon := false
	; blnClickOnTrayIcon was turned on by AHK_NOTIFYICON
	; turn it off to avoid further clicks on taskbar to be accepted if g_blnOpenMenuOnTaskbar is off

	return blnWindowIsDesktop
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsTray(strClass)
;------------------------------------------------------------
{
	return (strClass = "Shell_TrayWnd") or (strClass = "NotifyIconOverflowWindow")
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsConsole(strClass)
;------------------------------------------------------------
{
	return (strClass = "ConsoleWindowClass")
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsDialog(strClass, strWinId)
;------------------------------------------------------------
{
	return (strClass = "#32770") and !WindowIsTreeview(strWinId)
	
	; or InStr(strClass, "bosa_sdm_")
	; Removed 2014-09-27  (see http://code.jeanlalonde.ca/folderspopupv3archives/#comment-7912)
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsTreeview(strWinId)
; Disable popup menu in folder select dialog boxes (like those displayed by FileSelectFolder)
; because their Edit1 control does not react as expected in NavigateDialog.
; Signature: contains both SysTreeView321 and SHBrowseForFolder controls (tested on Win7 only)
; but NOT 100% sure this is a unique signature...
;------------------------------------------------------------
{
	global g_strAppNameText
	
	WinGet, strControlsList, ControlList, ahk_id %strWinId%
	blnIsTreeView := InStr(strControlsList, "SysTreeView321") and InStr(strControlsList, "SHBrowseForFolder")
	if (blnIsTreeView)
	{
		TrayTip, %lWindowIsTreeviewTitle%, %lWindowIsTreeviewText%, , 18
		Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
	}
	
	return blnIsTreeView
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsDirectoryOpus(strClass)
;------------------------------------------------------------
{
	return InStr(strClass, "dopus")
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsTotalCommander(strClass)
;------------------------------------------------------------
{
	return InStr(strClass, "TTOTAL_CMD")
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsQAPconnect(strWinId)
;------------------------------------------------------------
{
	global g_strQAPconnectAppFilename
	global g_strQAPconnectCompanionFilename

	if (strWinId = 0)
		return false

	; get path and filename of the app controling window strWinId
	; first get process ID
    intPID := 0
    DllCall("GetWindowThreadProcessId", "UInt", strWinId, "UInt *", intPID)
	; get filename of process
    hProcess := DllCall("OpenProcess", "UInt", 0x400 | 0x10, "Int", False, "UInt", intPID)
    intPathLength = 260*2
    VarSetCapacity(strFCAppFile, intPathLength, 0)
    DllCall("Psapi.dll\GetModuleFileNameExW", "UInt", hProcess, "Int", 0, "Str", strFCAppFile, "UInt", intPathLength)
    DllCall("CloseHandle", "UInt", hProcess)
	
	; get filename only and compare with QAPconnect filename or QAPconnect target filename (see QAPconnect doc)
	SplitPath, strFCAppFile, strFCAppFile
	return (strFCAppFile = g_strQAPconnectAppFilename) or (strFCAppFile = g_strQAPconnectCompanionFilename)
}
;------------------------------------------------------------


;------------------------------------------------------------
WindowIsQuickAccessPopup(strClass)
; enabled only when compiled
;------------------------------------------------------------
{
	return (strClass = "JeanLalonde.ca")
}
;------------------------------------------------------------


;========================================================================================================================
; END OF CLASS
;========================================================================================================================



;========================================================================================================================
!_070_MENU_ACTIONS:
;========================================================================================================================

;------------------------------------------------------------
OpenPowerMenu:
; remember the power menu item to execute and open the popup menu to choose on what favorite execute this action
;------------------------------------------------------------

g_strPowerMenu := A_ThisMenuItem

gosub, OpenPowerMenuTrayTip
gosub, LaunchFromPowerMenu

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenPowerMenuHotkey:
;------------------------------------------------------------

; search power menu code in g_objQAPFeatures to set g_strPowerMenu with localized name and gosub LaunchFromPowerMenu
g_strPowerMenu := ""
for intOrder, strCode in g_objQAPFeaturesPowerCodeByOrder
	if (g_objQAPFeatures[strCode].CurrentHotkey = A_ThisHotkey)
	{
		g_strPowerMenu := g_objQAPFeatures[strCode].LocalizedName
		break
	}

if (g_strPowerMenu = lMenuPowerNavigateDialog)
{
	SetTargetClassWinIdAndControl(false)
	; ###_V(A_ThisLabel, g_strPowerMenu, lMenuPowerNavigateDialog)
	if !WindowIsDialog(g_strTargetClass, g_strTargetWinId)
	{
		Oops(lMenuPowerNavigateDialogOops)
		gosub, OpenPowerMenuHotkeyCleanup
		return
	}
}
	
if StrLen(g_strPowerMenu)
{
	gosub, OpenPowerMenuTrayTip
	gosub, LaunchFromPowerMenu
}
else
	Oops("QAP feature could not be found...")

OpenPowerMenuHotkeyCleanup:
intOrder := ""
strCode := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenPowerMenuTrayTip:
;------------------------------------------------------------

if (g_strPowerMenu = lMenuCopyLocation)
	strMessage := lPowerMenuTrayTipCopyLocation
else if (g_strPowerMenu = lMenuPowerNewWindow)
	strMessage := lPowerMenuTrayTipNewWindow
else if (g_strPowerMenu = lMenuPowerEditFavorite)
	strMessage := lPowerMenuTrayTipEditFavorite
else if (g_strPowerMenu = lMenuPowerNavigateDialog)
	strMessage := lPowerMenuTrayTipNavigateDialog

TrayTip, %g_strAppNameText%, %strMessage%, , 17
Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)

strMessage := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenGroupOfFavorites:
;------------------------------------------------------------

objThisGroupFavorite := g_objThisFavorite
; ###_V("objThisGroupFavorite", objThisGroupFavorite.FavoriteGroupSettings)

; g_arrGroupSettingsOpen1: boolean value (replace existing Explorer windows if true, add to existing Explorer Windows if false)
; g_arrGroupSettingsOpen2: restore folders with "Explorer" or "Other" (Directory Opus, Total Commander or QAPconnect)
; g_arrGroupSettingsOpen3: delay in milliseconds to insert between each favorite to restore (in addition to default 200 ms)
strGroupSettings := objThisGroupFavorite.FavoriteGroupSettings
StringSplit, g_arrGroupSettingsOpen, strGroupSettings, `,

if (g_arrGroupSettingsOpen1)
	gosub, OpenGroupOfFavoritesCloseExplorers
	
objThisGroupFavoritesList := g_objMenusIndex[lMainMenuName . " " . objThisGroupFavorite.FavoriteLocation]

g_blnFirstTotalCommanderRight := true ; used only with TotalCommander but set it anyway

loop, % objThisGroupFavoritesList.MaxIndex() - 1 ; skip first item backlink
{
	g_objThisFavorite := objThisGroupFavoritesList[A_Index + 1] ; skip first item backlink
	; ###_O("g_objThisFavorite", g_objThisFavorite)
	
	Sleep, % g_arrGroupSettingsOpen3 + 200 ; add 200 ms as minimal default delay
	
	g_blnFirstItemOfGroup := (A_Index = 1)

	gosub, OpenFavoriteFromGroup
}

OpenGroupOfFavoritesCleanup:
objThisGroupFavorite := ""
objThisGroupFavoritesList := ""
strGroupSettings := ""
g_arrGroupSettingsOpen := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenGroupOfFavoritesCloseExplorers:
;------------------------------------------------------------

intSleepTime := 67 ; for visual effect only...
Tooltip, %lGuiGroupClosing%

if (g_arrGroupSettingsOpen2 = "Other")
{
	if (g_intActiveFileManager = 2)
	{
		WinGet, arrIDs, List, ahk_class dopus.lister
		Loop, %arrIDs%
		{
			WinClose, % "ahk_id " . arrIDs%A_Index%
			Sleep, %intSleepTime%
		}
	}
	else if (g_intActiveFileManager = 3)
	{
		WinGet, arrIDs, List, ahk_class TTOTAL_CMD
		Loop, %arrIDs%
		{
			WinClose, % "ahk_id " . arrIDs%A_Index%
			Sleep, %intSleepTime%
		}
	}
}
else ; g_arrGroupSettingsOpen2 = "Windows Explorer" or ""
{
	strWindowsId := ""
	for objExplorer in ComObjCreate("Shell.Application").Windows
	{
		; do not close in this loop as it mess up the handlers
		strType := ""
		try strType := objExplorer.Type ; Gets the type name of the contained document object. "Document HTML" for IE windows. Should be empty for file Explorer windows.
		strWindowID := ""
		try strWindowID := objExplorer.HWND ; Try to get the handle of the window. Some ghost Explorer in the ComObjCreate may return an empty handle
		if !StrLen(strType) and StrLen(strWindowID) ; strType must be empty and strWindowID must not be empty
			strWindowsId .= objExplorer.HWND . "|"
	}
	StringTrimRight, strWindowsId, strWindowsId, 1 ; remove last | separator
	Loop, Parse, strWindowsId, |
	{
		WinClose, ahk_id %A_LoopField%
		Sleep, %intSleepTime%
	}
}

Tooltip ; clear tooltip

intSleepTime := ""
strWindowsId := ""
objExplorer := ""
arrIDs := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavorite:
OpenFavoriteGroup:
OpenFavoriteFromGroup:
OpenFavoriteFromHotkey:
OpenRecentFolder:
OpenCurrentFolder:
OpenClipboard:
;------------------------------------------------------------

; if (A_ThisLabel = "OpenFavoriteFromGroup")
;	###_O("objThisGroupFavoritesList", objThisGroupFavoritesList)
; ###_V(A_ThisLabel . "-1", A_ThisMenu, A_ThisMenuItem, A_ThisHotkey, g_strPowerMenu, g_blnPowerMenu, g_strHokeyTypeDetected)

g_strOpenFavoriteLabel := A_ThisLabel

if (A_ThisLabel = "OpenFavoriteFromGroup") ; object already set by OpenGroupOfFavorites
	g_strHokeyTypeDetected := "Launch" ; all favorites in group are for Launch (no Navigate)
else
	gosub, OpenFavoriteGetFavoriteObject ; define g_objThisFavorite

if !IsObject(g_objThisFavorite) ; OpenFavoriteGetFavoriteObject was aborted
{
	gosub, OpenFavoriteCleanup
	return
}

if (g_objThisFavorite.FavoriteType = "Group") and !(g_blnPowerMenu)
{
	gosub, OpenGroupOfFavorites
	
	gosub, OpenFavoriteCleanup
	return
}

if InStr("Folder|Document|Application", g_objThisFavorite.FavoriteType) ; for these favorites, file/folder must exist
	and (g_strPowerMenu <> lMenuPowerEditFavorite)
	if !FileExist(PathCombine(A_WorkingDir, EnvVars(g_objThisFavorite.FavoriteLocation)))
	{
		Gui, 1:+OwnDialogs
		MsgBox, 0, % L(lDialogFavoriteDoesNotExistTitle, g_strAppNameText)
			, % L(lDialogFavoriteDoesNotExistPrompt, PathCombine(A_WorkingDir, EnvVars(g_objThisFavorite.FavoriteLocation)))
		gosub, OpenFavoriteCleanup
		return
	}

; preparation for power menu features before setting the full location
if (g_blnPowerMenu)
	if (g_strPowerMenu = lMenuPowerNewWindow)
		g_strHokeyTypeDetected := "Launch"
	else if (g_strPowerMenu = lMenuPowerNavigateDialog)
		g_strHokeyTypeDetected := "Navigate" ;  if we get here, we know it is a dialog box

gosub, SetTargetName ; sets g_strTargetAppName, can change g_strHokeyTypeDetected to "Launch"

gosub, OpenFavoriteGetFullLocation ; sets g_strFullLocation

if !StrLen(g_strFullLocation) ; OpenFavoriteGetFullLocation was aborted
{
	gosub, OpenFavoriteCleanup
	return
}

blnShiftPressed := GetKeyState("Shift") ; ### use this approach? if yes, do not take into account if keyboard shortcut

; if (A_ThisLabel = "OpenFavoriteFromGroup")
; ###_V(A_ThisLabel . "-2", g_strHokeyTypeDetected, g_strTargetAppName, g_strTargetWinId, g_strTargetControl, g_strTargetClass, g_strFullLocation)
; ###_O("g_strOpenFavoriteLabel: " A_ThisLabel . "`ng_strHokeyTypeDetected: " . g_strHokeyTypeDetected . "`nShift: " . (blnShiftPressed ? "PRESSED" : "not pressed") . "`ng_strFullLocation: " . g_strFullLocation . "`ng_strTargetAppName: " . g_strTargetAppName, g_objThisFavorite)

; Boolean,MinMax,Left,Top,Width,Height (comma delimited)
; 0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height; for example: "1,0,100,50,640,480"
strFavoriteWindowPosition := g_objThisFavorite.FavoriteWindowPosition
StringSplit, g_arrFavoriteWindowPosition, strFavoriteWindowPosition, `,

; === ACTIONS ===

; --- Power Menu actions ---

if (g_blnPowerMenu)
{
	if (g_strPowerMenu = lMenuPowerEditFavorite)
	{
		g_objMenuInGui := g_objMenusIndex[A_ThisMenu]
		g_intOriginalMenuPosition := A_ThisMenuItemPos + (A_ThisMenu = lMainMenuName ? 0 : 1)
			+ NumberOfColumnBreaksBeforeThisItem(g_objMenusIndex[A_ThisMenu], A_ThisMenuItemPos)
		g_objEditedFavorite := g_objMenuInGui[g_intOriginalMenuPosition]
		gosub, GuiShowFromPower
		gosub, GuiEditFavoriteFromPower
		gosub, OpenFavoriteCleanup
		return
	}
	
	if (g_strPowerMenu = lMenuCopyLocation) ; EnvVars expanded
	{
		if !InStr("Group|QAP", g_objThisFavorite.FavoriteType) ; for these types, there is no path to copy
		{
			Clipboard := g_strFullLocation
			TrayTip, %g_strAppNameText%, %lCopyLocationCopiedToClipboard%, , 17
			Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
		}		
		gosub, OpenFavoriteCleanup
		return
	}
	
	if (g_strPowerMenu = lMenuPowerNewWindow) and (g_objThisFavorite.FavoriteType = "Group")
	; cannot open group in new window
	{
		gosub, OpenFavoriteCleanup
		return
	}
}

; --- Document or Link ---
; --- Launch with ---

if InStr("Document|URL", g_objThisFavorite.FavoriteType)
	or StrLen(g_objThisFavorite.FavoriteLaunchWith)
{
	Run, %g_strFullLocation%, , , intPid
	; intPid may not be set for some doc types; could help if document is launch with a FavoriteLaunchWith
	if (intPid)
	{
		g_strNewWindowId := "ahk_pid " . intPid
		gosub, OpenFavoriteWindowResize
	}

	gosub, OpenFavoriteCleanup
	return
}

; --- Menu type ---

if (g_objThisFavorite.FavoriteType = "Menu")
{
	Menu, %lMainMenuName% %g_strFullLocation%, Show

	gosub, OpenFavoriteCleanup
	return
}

; --- Application ---

if (g_objThisFavorite.FavoriteType = "Application")
{
	; ###_V("Application", g_strFullLocation, g_objThisFavorite.FavoriteAppWorkingDir)
	Run, %g_strFullLocation%, % g_objThisFavorite.FavoriteAppWorkingDir, , intPid
	if (intPid)
	{
		g_strNewWindowId := "ahk_pid " . intPid
		gosub, OpenFavoriteWindowResize
	}

	gosub, OpenFavoriteCleanup
	return
}

; --- QAP Command ---

if InStr("OpenFavorite|OpenFavoriteFromHotkey", g_strOpenFavoriteLabel) and (g_objThisFavorite.FavoriteType = "QAP") and StrLen(g_objQAPFeatures[g_objThisFavorite.FavoriteLocation].QAPFeatureCommand)
{
	; ###_O(g_objQAPFeatures[g_objThisFavorite.FavoriteLocation].QAPFeatureCommand, g_objThisFavorite)
	Gosub, % g_objQAPFeatures[g_objThisFavorite.FavoriteLocation].QAPFeatureCommand
	
	gosub, OpenFavoriteCleanup
	return
}

; --- Navigate Folder ---

if (InStr("Folder|FTP", g_objThisFavorite.FavoriteType) and g_strHokeyTypeDetected = "Navigate")
{
	; ###_O("Navigate Folder: " . g_strFullLocation . "`nIn target: " . g_strTargetAppName, g_objThisFavorite)
	gosub, OpenFavoriteNavigate%g_strTargetAppName%
	
	gosub, OpenFavoriteCleanup
	return
}

; --- Navigate Special Folder ---

if (g_objThisFavorite.FavoriteType = "Special") and (g_strHokeyTypeDetected = "Navigate")
{
	; ###_O("Navigate Special: " . g_strFullLocation . "`nIn target: " . g_strTargetAppName, g_objThisFavorite)
	gosub, OpenFavoriteNavigate%g_strTargetAppName%
	
	gosub, OpenFavoriteCleanup
	return
}

; --- New window ---

if (g_strHokeyTypeDetected = "Launch")
	or !StrLen(g_strTargetClass) or (g_strTargetWinId = 0) ; for situations where the target window could not be detected
{
	; ###_O("OpenFavorite: " . g_strFullLocation . "`nNew Window in target: " . g_strTargetAppName, g_objThisFavorite, g_objThisFavorite.FavoriteWindowPosition)
	
	gosub, OpenFavoriteInNewWindow%g_strTargetAppName%
	gosub, OpenFavoriteWindowResize
}

OpenFavoriteCleanup:
g_objThisFavorite := ""
strFavoriteWindowPosition := ""
g_arrFavoriteWindowPosition := ""
g_blnPowerMenu := ""
g_strPowerMenu := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
SetTargetName:
;------------------------------------------------------------

if WindowIsExplorer(g_strTargetClass)
	g_strTargetAppName := "Explorer"
else if WindowIsDesktop(g_strTargetClass)
	g_strTargetAppName := "Desktop"
else if WindowIsTray(g_strTargetClass)
	g_strTargetAppName := "Tray"
else if WindowIsConsole(g_strTargetClass)
	g_strTargetAppName := "Console"
else if WindowIsDialog(g_strTargetClass, g_strTargetWinId)
	g_strTargetAppName := "Dialog"
else if WindowIsTreeview(g_strTargetWinId)
	g_strTargetAppName := "Treeview"
else if WindowIsDirectoryOpus(g_strTargetClass) and (g_intActiveFileManager = 2)
	g_strTargetAppName := "DirectoryOpus"
else if WindowIsTotalCommander(g_strTargetClass) and (g_intActiveFileManager = 3)
	g_strTargetAppName := "TotalCommander"
else if WindowIsQAPconnect(g_strTargetWinId) and (g_intActiveFileManager = 4)
	g_strTargetAppName := "QAPconnect"
else if WindowIsQuickAccessPopup(g_strTargetClass)
	g_strTargetAppName := "QuickAccessPopup"
else
	g_strTargetAppName := "Unknown"

if (g_strTargetAppName = "Desktop")
    g_strHokeyTypeDetected := "Launch"

if (g_strHokeyTypeDetected = "Launch")
	if (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup" and g_arrGroupSettingsOpen2 = "Windows Explorer")
		g_strTargetAppName := "Explorer"
	else if InStr("Desktop|Dialog|Console|Unknown", g_strTargetAppName) ; these targets cannot launch in a new window
		or (g_intActiveFileManager > 1) ; use file managers DirectoryOpus, TotalCommander or QAPconnect
		if (g_intActiveFileManager = 2)
			g_strTargetAppName := "DirectoryOpus"
		else if (g_intActiveFileManager = 3)
			g_strTargetAppName := "TotalCommander"
		else if (g_intActiveFileManager = 4)
			g_strTargetAppName := "QAPconnect"
		else
			g_strTargetAppName := "Explorer"

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteGetFavoriteObject:
;------------------------------------------------------------

if (g_blnDisplayNumericShortcuts)
	StringTrimLeft, strThisMenuItem, A_ThisMenuItem, 3 ; remove "&1 " from menu item
else
	strThisMenuItem :=  A_ThisMenuItem

if (g_strOpenFavoriteLabel = "OpenFavoriteGroup")
{
	strThisMenuItem :=  SubStr(A_ThisMenuItem, 1, InStr(A_ThisMenuItem, g_strGroupIndicatorPrefix) - 2) ; remove indicator with nb of group members
	strThisMenuItem .=  " " . g_strGroupIndicatorPrefix . g_strGroupIndicatorSuffix ; add empty indicators to retrieve fav name in objects
}

if InStr("OpenFavorite|OpenFavoriteGroup", g_strOpenFavoriteLabel)
{
	intMenuItemPos := A_ThisMenuItemPos + (A_ThisMenu = lMainMenuName ? 0 : 1)
			+ NumberOfColumnBreaksBeforeThisItem(g_objMenusIndex[A_ThisMenu], A_ThisMenuItemPos)
	g_objThisFavorite := g_objMenusIndex[A_ThisMenu][intMenuItemPos]
}
else if (g_strOpenFavoriteLabel = "OpenFavoriteFromHotkey")
{
	blnLocationFound := false
	strThisHotkeyLocation := GetHotkeyLocation(A_ThisHotkey)
	
	for strMenuPath, objMenu in g_objMenusIndex
	{
		loop, % objMenu.MaxIndex()
			if (objMenu[A_Index].FavoriteLocation = strThisHotkeyLocation)
			{
				g_objThisFavorite := objMenu[A_Index]
				blnLocationFound := true
				break
			}
		if (blnLocationFound)
			break
	}
	if !(blnLocationFound) ; should not happen
	{
		Oops(lOopsHotkeyNotInMenus, strThisHotkeyLocation, A_ThisHotkey)
		
		gosub, OpenFavoriteGetFavoriteObjectCleanup
		return
	}
	if CanNavigate(A_ThisHotkey)
		g_strHokeyTypeDetected := "Navigate"
	else if CanLaunch(A_ThisHotkey)
		g_strHokeyTypeDetected := "Launch"
	else
	{
		gosub, OpenFavoriteGetFavoriteObjectCleanup
		return ; active window is on exclusion list
	}
}
else if (g_strOpenFavoriteLabel = "OpenCurrentFolder")
{
	; ###_O(strThisMenuItem . " / " . g_objCurrentFoldersLocationUrlByName[strThisMenuItem], g_objCurrentFoldersLocationUrlByName)
	If (InStr(g_objCurrentFoldersLocationUrlByName[strThisMenuItem], "::") = 1) ; A_ThisMenuItem can include the numeric shortcut
	{
		strThisMenuItem := SubStr(g_objCurrentFoldersLocationUrlByName[strThisMenuItem], 3) ; remove "::" from beginning
		strFavoriteType := "Special"
	}
	else if InStr(g_objCurrentFoldersLocationUrlByName[strThisMenuItem], "ftp://") ; possible with DOpus listers
		strFavoriteType := "FTP"
	else
		strFavoriteType := "Folder"
	
	g_objThisFavorite := Object() ; temporary favorite object
	g_objThisFavorite.FavoriteName := strThisMenuItem
	g_objThisFavorite.FavoriteLocation := strThisMenuItem
	g_objThisFavorite.FavoriteType := strFavoriteType
}
else ; OpenRecentFolder or OpenClipboard
{
	if InStr(strThisMenuItem, "http://") = 1 or InStr(strThisMenuItem, "https://") = 1 or InStr(strThisMenuItem, "www.") = 1
		strFavoriteType := "URL"
	else
	{
		SplitPath, strThisMenuItem, , , strExtension
		if StrLen(strExtension) and InStr("exe.com.bat", strExtension)
			strFavoriteType := "Application" ; application
		else
			strFavoriteType := (LocationIsDocument(EnvVars(strThisMenuItem)) ? "Document" : "Folder")
	}
	
	g_objThisFavorite := Object() ; temporary favorite object
	g_objThisFavorite.FavoriteName := strThisMenuItem
	g_objThisFavorite.FavoriteLocation := strThisMenuItem
	g_objThisFavorite.FavoriteType := strFavoriteType
}

OpenFavoriteGetFavoriteObjectCleanup:
strThisMenuItem := ""
strFavoriteType := ""
intMenuItemPos := ""
blnLocationFound := ""
strThisHotkeyLocation := ""
strMenuPath := ""
objMenu := ""


return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteGetFullLocation:
;------------------------------------------------------------

g_strFullLocation := g_objThisFavorite.FavoriteLocation

; ###_V(A_ThisLabel, g_strTargetAppName, g_strFullLocation)
if (g_objThisFavorite.FavoriteType = "FTP")
{
	; ftp://username:password@ftp.domain.ext/public_ftp/incoming/
	if (g_strTargetAppName = "TotalCommander")
		or !(g_objThisFavorite.FavoriteFtpEncoding) ; do not encode
	{
		; must NOT encode username and password with UriEncode
		strLoginName := g_objThisFavorite.FavoriteLoginName
		strPassword := g_objThisFavorite.FavoritePassword
	}
	else
	{
		; must encode username and password with UriEncode
		strLoginName := UriEncode(g_objThisFavorite.FavoriteLoginName)
		strPassword := UriEncode(g_objThisFavorite.FavoritePassword)
	}
	
	StringReplace, g_strFullLocation, g_strFullLocation, % "ftp://"
		, % "ftp://" . strLoginName . (StrLen(strPassword) ? ":" . strPassword : "") . (StrLen(strLoginName) ? "@" : "")
}
else
	if InStr("Folder|Document|Application", g_objThisFavorite.FavoriteType) ; not for URL, Special Folder and others
		; expand system variables
		; make the location absolute based on the current working directory
		g_strFullLocation := PathCombine(A_WorkingDir, EnvVars(g_strFullLocation))
	else if (g_objThisFavorite.FavoriteType = "Special")
		g_strFullLocation := GetSpecialFolderLocation(g_strHokeyTypeDetected, g_strTargetAppName, g_objThisFavorite) ; can change values of g_strHokeyTypeDetected and g_strTargetAppName
	; else URL or QAP (no need to expand or make absolute), keep g_strFullLocation as in g_objThisFavorite.FavoriteLocation

if StrLen(g_objThisFavorite.FavoriteLaunchWith) ; always empty for Application favorites
{
	strFullLaunchWith := PathCombine(A_WorkingDir, EnvVars(g_objThisFavorite.FavoriteLaunchWith))
	if !FileExist(strFullLaunchWith) and (g_strPowerMenu <> lMenuPowerEditFavorite)
		Oops(lOopsLaunchWithNotFound, strFullLaunchWith) ; leave g_strFullLocation as-is
	else
		g_strFullLocation := strFullLaunchWith . " """ . g_strFullLocation . """" ; enclose document path in double-quotes
}

if StrLen(g_objThisFavorite.FavoriteArguments)
	g_strFullLocation .= " " . ExpandPlaceholders(g_objThisFavorite.FavoriteArguments, g_strFullLocation) ; let user enter double-quotes as required by his arguments

OpenFavoriteGetFullLocationCleanup:
strArguments := ""
strOutFileName := ""
strOutDir := ""
strOutExtension := ""
strOutNameNoExt := ""
strOutDrive := ""
strLoginName := ""
strPassword := ""
strFullLaunchWith := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GetSpecialFolderLocation(ByRef strHokeyTypeDetected, ByRef strTargetName, objFavorite)
;------------------------------------------------------------
{
	global g_objSpecialFolders

	strLocation := objFavorite.FavoriteLocation ; make sure FavoriteLocation was not expanded by EnvVars
	objSpecialFolder := g_objSpecialFolders[strLocation]
	
	if (strTargetName = "Explorer")
		strUse := objSpecialFolder.Use4NavigateExplorer
	else if (strTargetName = "Dialog")
		strUse := objSpecialFolder.Use4Dialog
	else if (strTargetName = "Console")
		strUse := objSpecialFolder.Use4Console
	else if (strTargetName = "DirectoryOpus")
		strUse := objSpecialFolder.Use4DOpus
	else if (strTargetName = "TotalCommander")
		strUse := objSpecialFolder.Use4TC
	else if (strTargetName = "QAPconnect")
		strUse := objSpecialFolder.Use4FPc
	else
		strUse := objSpecialFolder.Use4NewExplorer

	if (strUse = "NEW") ; re-assign values as if it was a new window request to be open in *Explorer*
	{
		strUse := objSpecialFolder.Use4NewExplorer
		strHokeyTypeDetected := "Launch"
		strTargetName := "Explorer"
	}
	
	if (strUse = "CLS")
	{
		if (SubStr(strLocation, 1, 1) = "{")
			if (strTargetName = "TotalCommander")
				strLocation := "::" . strLocation
			else
				strLocation := "shell:::" . strLocation
		else ; expand strLocation
			strLocation := EnvVars(strLocation)			
	}
	else if (strUse = "AHK")
	{
		strAHKConstant := objSpecialFolder.AHKConstant ; for example "A_Desktop"
		strLocation := %strAHKConstant% ; the contant value, for example "C:\Users\jlalonde\Desktop"
	}
	else if (strUse = "DOA")
		strLocation := "/" . objSpecialFolder.DOpusAlias
	else if (strUse = "SCT")
		strLocation := "shell:" . objSpecialFolder.ShellConstantText
	else if (strUse = "TCC")
		strLocation := objSpecialFolder.TCCommand
	else
	{
		Oops(lOopsCouldNotOpenSpecialFolder, strTargetName, strLocation)
		strLocation := ""
	}
	; ###_O("GetSpecialFolderLocation`n`nstrLocation: " . strLocation . "`nstrTargetName: " . strTargetName . "`nstrUse: " . strUse, objSpecialFolder)
	
	return strLocation
}
;------------------------------------------------------------


;------------------------------------------------------------
NumberOfColumnBreaksBeforeThisItem(objMenu, strThisMenuItemPos)
;------------------------------------------------------------
{
	intNumberOfColumnBreaks := 0
	Loop
	{
		if (A_Index - intNumberOfColumnBreaks > strThisMenuItemPos)
			break
		else if (objMenu[A_Index].FavoriteType = "K")
			intNumberOfColumnBreaks++
	}
	
	return intNumberOfColumnBreaks
}
;------------------------------------------------------------



;========================================================================================================================
; END OF MENU ACTIONS
;========================================================================================================================



;========================================================================================================================
!_074_NAVIGATE:
;========================================================================================================================

;------------------------------------------------------------
OpenFavoriteNavigateExplorer:
; Excerpt and adapted from RMApp_Explorer_Navigate(FullPath, hwnd="") by Learning One
; http://ahkscript.org/boards/viewtopic.php?f=5&t=526&start=20#p4673
; http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx
; http://msdn.microsoft.com/en-us/library/aa752094
;------------------------------------------------------------

if !Regexmatch(g_strFullLocation, "#.*\\") ; prevent the hash bug in Shell.Application - when a hash in path is followed by a backslash like in "c:\abc#xyz\abc")
{
	intCountMatch := 0
	For pExplorer in ComObjCreate("Shell.Application").Windows
	{
		if (pExplorer.hwnd = g_strTargetWinId)
		{
			intCountMatch++
			if IsInteger(g_strFullLocation) ; ShellSpecialFolderConstant
			{
				try pExplorer.Navigate2(g_strFullLocation)
				catch, objErr
					Oops(lNavigateSpecialError, g_strFullLocation)
			}
			else
			{
				try pExplorer.Navigate(g_strFullLocation)
				catch, objErr
					; Note: If an error occurs in Navigate, the error message is given by Navigate itself and this script does not
					; receive an error notification. From my experience, the following line would never be executed.
					Oops(lNavigateFileError, g_strFullLocation)
			}
		}
	}
	if !(intCountMatch) ; open a new window
	; for Explorer add-ons like Clover (verified - it now opens the folder in a new tab), others?
	; also when g_strTargetWinId is DOpus window and DOpus is not used
		if IsInteger(g_strFullLocation) ; ShellSpecialFolderConstant
			ComObjCreate("Shell.Application").Explore(g_strFullLocation)
		else
			SendInput, {F4}{Esc}{Raw}%g_strFullLocation%`n
			; if I receive bug reports from Clover users, insert delays or fall back to; Run, Explorer "%g_strFullLocation%"
}
else
	; Workaround for the hash (aka Sharp / "#") bug in Shell.Application - occurs only when navigating in the current Explorer window
	; see http://stackoverflow.com/questions/22868546/navigate-shell-command-not-working-when-the-path-includes-an-hash
	; and http://ahkscript.org/boards/viewtopic.php?f=5&t=526&p=25287#p25274
	SendInput, {F4}{Esc}{Raw}%g_strFullLocation%`n

intCountMatch := ""
pExplorer := ""
objErr := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteNavigateDirectoryOpus:
;------------------------------------------------------------

if (WinExist("A") <> g_strTargetWinId) ; in case that some window just popped out, and initialy active window lost focus
	WinActivate, ahk_id %g_strTargetWinId% ; we'll activate initialy active window

RunDOpusRt("/aCmd Go", g_strFullLocation) ; navigate the current lister

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteNavigateTotalCommander:
;------------------------------------------------------------

; ###_V(A_ThisLabel, g_strTotalCommanderPath, g_strFullLocation)

if g_strFullLocation is integer
{
	SendMessage, 0x433, %g_strFullLocation%, , , ahk_class TTOTAL_CMD
	Sleep, 100 ; wait to improve SendMessage reliability
	WinActivate, ahk_class TTOTAL_CMD
}
else
{
	if (WinExist("A") <> g_strTargetWinId) ; in case that some window just popped out, and initialy active window lost focus
	{
		WinActivate, ahk_id %g_strTargetWinId% ; we'll activate initialy active window
		Sleep, 200
	}
	Run, %g_strTotalCommanderPath% /O /S "/L=%g_strFullLocation%" ; /O existing file list, /S source-dest /L=source (active pane) - change folder in the active pane/tab
}

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteNavigateQAPconnect:
;------------------------------------------------------------

if InStr(g_strFullLocation, " ")
	g_strFullLocation := """" . g_strFullLocation . """"
StringReplace, strQAPconnectParamString, g_strQAPconnectCommandLine, % "%Path%", %g_strFullLocation%
StringReplace, strQAPconnectParamString, strQAPconnectParamString, % "%NewTabSwitch%"

; ###_V(A_ThisLabel, g_strFullLocation, strQAPconnectParamString, g_strQAPconnectWindowID, g_strQAPconnectAppPath, g_strQAPconnectCommandLine, g_strQAPconnectNewTabSwitch, g_strQAPconnectAppFilename, g_strTargetWinId)

if (WinExist("A") <> g_strTargetWinId) ; in case that some window just popped out, and initialy active window lost focus
{
	WinActivate, ahk_id %g_strTargetWinId% ; we'll activate initialy active window
	Sleep, 200
}
Run, %g_strQAPconnectAppPath% %strQAPconnectParamString%

strQAPconnectParamString :=""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteNavigateConsole:
;------------------------------------------------------------

; ###_V("OpenFavoriteNavigateConsole", g_strTargetWinId, g_strFullLocation)

if (WinExist("A") <> g_strTargetWinId) ; in case that some window just popped out, and initialy active window lost focus
	WinActivate, ahk_id %g_strTargetWinId% ; we'll activate initialy active window
SendInput, {Raw}CD /D %g_strFullLocation%
Sleep, 200
SendInput, {Enter}

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteNavigateDialog:
;------------------------------------------------------------

if ControlIsVisible("ahk_id " . g_strTargetWinId, "Edit1")
	strEditControl := "Edit1"
	; in standard dialog windows, "Edit1" control is the right choice
Else if ControlIsVisible("ahk_id " . g_strTargetWinId, "Edit2")
	strEditControl := "Edit2"
	; but sometimes in MS office, if condition above fails, "Edit2" control is the right choice 
Else ; if above fails - just return and do nothing.
{
	gosub, OpenFavoriteNavigateDialogCleanUp
	return
}

;===In this part (if we reached it), we'll send strLocation to control and restore control's initial text after navigating to specified folder===

ControlGetText, strPrevControlText, %strEditControl%, ahk_id %g_strTargetWinId% ; we'll get and store control's initial text first

if !ControlSetTextR(strEditControl, g_strFullLocation, "ahk_id " . g_strTargetWinId) ; set control's text to strLocation
{
	gosub, OpenFavoriteNavigateDialogCleanUp
	return ; abort if control is not set
}
if !ControlSetFocusR(strEditControl, "ahk_id " . g_strTargetWinId) ; focus control
{
	gosub, OpenFavoriteNavigateDialogCleanUp
	return
}
if (WinExist("A") <> g_strTargetWinId) ; in case that some window just popped out, and initialy active window lost focus
	WinActivate, ahk_id %g_strTargetWinId% ; we'll activate initialy active window

;=== Avoid accidental hotkey & hotstring triggereing while doing SendInput - can be done simply by #UseHook, but do it if user doesn't have #UseHook in the script ===

If (A_IsSuspended)
	blnWasSuspended := True
if (!blnWasSuspended)
	Suspend, On
SendInput, {End}{Space}{Backspace}{Enter} ; silly but necessary part - go to end of control, send dummy space, delete it, and then send enter
if (!blnWasSuspended)
	Suspend, Off

Sleep, 100 ; give some time to control after sending {Enter} to it
ControlGetText, strControlTextAfterNavigation, %strEditControl%, ahk_id %g_strTargetWinId% ; sometimes controls automatically restore their initial text
if (strControlTextAfterNavigation <> strPrevControlText)
	ControlSetTextR(strEditControl, strPrevControlText, "ahk_id " . g_strTargetWinId) ; we'll set control's text to its initial text

if (WinExist("A") <> g_strTargetWinId) ; sometimes initialy active window loses focus, so we'll activate it again
	WinActivate, ahk_id %g_strTargetWinId%

OpenFavoriteNavigateDialogCleanUp:
; ###_V(A_ThisLabel, g_strTargetWinId, strEditControl, strPrevControlText, strControlTextAfterNavigation)
strEditControl := ""
strPrevControlText := ""
blnWasSuspended := ""
strControlTextAfterNavigation := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ControlIsVisible(strWinTitle, strControlClass)
/*
Adapted from ControlIsVisible(WinTitle,ControlClass) by Learning One
http://ahkscript.org/boards/viewtopic.php?f=5&t=526&start=20#p4673
*/
;------------------------------------------------------------
{
	; used in Navigator
	ControlGet, blnIsControlVisible, Visible, , %strControlClass%, %strWinTitle%

	return blnIsControlVisible
}
;------------------------------------------------------------


;------------------------------------------------------------
ControlSetTextR(strControl, strNewText := "", strWinTitle := "", intTries := 3)
/*
Adapted from from RMApp_ControlSetTextR(Control, NewText="", WinTitle="", Tries=3) by Learning One
http://ahkscript.org/boards/viewtopic.php?f=5&t=526&start=20#p4673
*/
;------------------------------------------------------------
{
	; used in Navigator. More reliable ControlSetText
	Loop, %intTries%
	{
		ControlSetText, %strControl%, %strNewText%, %strWinTitle% ; set
		Sleep, % (100 * A_Index) ; JL added "* A_Index"
		ControlGetText, strCurControlText, %strControl%, %strWinTitle% ; check
		if (strCurControlText = strNewText) ; if OK
			return True
	}

	return false
}
;------------------------------------------------------------


;------------------------------------------------------------
ControlSetFocusR(strControl, strWinTitle := "", intTries := 3)
/*
Adapted from RMApp_ControlSetFocusR(Control, WinTitle="", Tries=3) by Learning One
http://ahkscript.org/boards/viewtopic.php?f=5&t=526&start=20#p4673
*/
;------------------------------------------------------------
{
	; used in Navigator. More reliable ControlSetFocus
	Loop, %intTries%
	{
		ControlFocus, %strControl%, %strWinTitle% ; focus control
		Sleep, % (100 * A_Index) ; JL added "* A_Index"
		ControlGetFocus, strFocusedControl, %strWinTitle% ; check
		if (strFocusedControl = strControl) ; if OK
			return True
	}

	return false
}
;------------------------------------------------------------



;========================================================================================================================
; END OF NAVIGATE
;========================================================================================================================



;========================================================================================================================
!_075_NEW_WINDOW:
;========================================================================================================================

;------------------------------------------------------------
OpenFavoriteInNewWindowExplorer:
;------------------------------------------------------------

if (g_arrFavoriteWindowPosition1)
{
	; get new window ID
	; when run -> pid? if not scan Explorer ids
	gosub, SetExplorersIDs ;  refresh the list of existing Explorer windows g_strExplorerIDs
	strExplorerIDsBefore := g_strExplorerIDs ;  save the list before launching this new Explorer
}

Run, % "Explorer """ . g_strFullLocation . """" ; there was a bug prior to v3.3.1 because the lack of double-quotes

if (g_arrFavoriteWindowPosition1)
{
	g_strNewWindowId := ""
	Loop
	{
		if (A_Index > 25)
		{
			TrayTip, % L(lTrayTipInstalledTitle, g_strAppNameText), % L(lDialogErrorMoving, g_strFullLocation), , 2 ; with sound
			Sleep, 20 ; tip from Lexikos for Windows 10 "Just sleep for any amount of time after each call to TrayTip" (http://ahkscript.org/boards/viewtopic.php?p=50389&sid=29b33964c05f6a937794f88b6ac924c0#p50389)
			Break
		}
		Sleep, %g_arrFavoriteWindowPosition7%
		gosub, SetExplorersIDs ;  refresh the list of existing Explorer windows g_strExplorerIDs
		; ###_V("strExplorerIDsBefore", strExplorerIDsBefore, g_strExplorerIDs)
		Loop, Parse, g_strExplorerIDs, |
			if !InStr(strExplorerIDsBefore, A_LoopField . "|")
			{
				g_strNewWindowId  := "ahk_id " . A_LoopField
				break
			}
		If StrLen(g_strNewWindowId)
			Break ; we have a new window
	}
	; ###_V("g_strNewWindowId ", g_strNewWindowId)
}

strExplorerIDsBefore := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
SetExplorersIDs:
;------------------------------------------------------------
g_strExplorerIDs := ""
for objExplorer in ComObjCreate("Shell.Application").Windows
{
	strType := ""
	try strType := objExplorer.Type ; Gets the type name of the contained document object. "Document HTML" for IE windows. Should be empty for file Explorer windows.
	strWindowID := ""
	try strWindowID := objExplorer.HWND ; Try to get the handle of the window. Some ghost Explorer in the ComObjCreate may return an empty handle
	if !StrLen(strType) and StrLen(strWindowID) ; strType must be empty and strWindowID must not be empty
		g_strExplorerIDs .= objExplorer.HWND . "|"
}

objExplorer := ""
strType := ""
strWindowID := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteInNewWindowDirectoryOpus:
;------------------------------------------------------------

; RunDOpusRt("/acmd Go ", objIniExplorersInGroup[intDOIndexPane].Name, " NEWTAB") ; open in a new tab of pane 1
; RunDOpusRt("/acmd Go ", objIniExplorersInGroup[intDOIndexPane].Name, " OPENINRIGHT") ; open in a first tab of pane 2
; RunDOpusRt("/acmd Go ", objIniExplorersInGroup[intDOIndexPane].Name, " OPENINRIGHT NEWTAB") ; open in a new tab of pane 2

if (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup")
{
	if (g_blnFirstItemOfGroup) ; force left in new lister
		strTabParameter := "NEW=nodual"
	else
	{
		; 0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height, Delay, RestoreSide; for example: "0,,,,,,,L"
		strFavoriteWindowPosition := g_objThisFavorite.FavoriteWindowPosition
		StringSplit, arrFavoriteWindowPosition, strFavoriteWindowPosition, `,
		if StrLen(arrFavoriteWindowPosition8)
			strTabParameter := "NEWTAB " . (arrFavoriteWindowPosition8 = "L" ? "OPENINLEFT" : "OPENINRIGHT")
		else
			strTabParameter := g_strDirectoryOpusNewTabOrWindow
	}
}
else
{
	strTabParameter := g_strDirectoryOpusNewTabOrWindow
	arrFavoriteWindowPosition8 := ""
}

; ###_V("", g_strFullLocation, strTabParameter)
RunDOpusRt("/acmd Go ", g_strFullLocation, " " . strTabParameter) ; open in a new lister or tab, left or right
WinWait, ahk_class dopus.lister, , 10
WinActivate, ahk_class dopus.lister
g_strNewWindowId := "ahk_class dopus.lister"

strTabParameter := ""
strFavoriteWindowPosition := ""
arrFavoriteWindowPosition := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteInNewWindowTotalCommander:
;------------------------------------------------------------

; ###_V(A_ThisLabel, g_strTotalCommanderPath, g_strTotalCommanderNewTabOrWindow)
if (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup")
{
	; 0 for use default / 1 for remember, -1 Minimized / 0 Normal / 1 Maximized, Left (X), Top (Y), Width, Height, Delay, RestoreSide; for example: "0,,,,,,,L"
	strFavoriteWindowPosition := g_objThisFavorite.FavoriteWindowPosition
	StringSplit, arrFavoriteWindowPosition, strFavoriteWindowPosition, `,
	if !StrLen(arrFavoriteWindowPosition8)
		arrFavoriteWindowPosition8 := "L"
}
	
if g_strFullLocation is integer
{
	if !WinExist("ahk_class TTOTAL_CMD") ; open a first instance
		or InStr(g_strTotalCommanderNewTabOrWindow, "/N") ; or open a new instance
		or (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup" and g_blnFirstItemOfGroup)
	{
		Run, %g_strTotalCommanderPath%
		WinWaitActive, ahk_class TTOTAL_CMD, , 10
		Sleep, 200 ; wait additional time to improve SendMessage reliability in OpenFavoriteNavigateTotalCommander
	}
	
	if (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup")
	{
		if (arrFavoriteWindowPosition8 = "L")
			intTCCommandFocus := 4001 ; cm_FocusLeft
		else
			intTCCommandFocus := 4002 ; cm_FocusRight
		Sleep, 100 ; wait to improve SendMessage reliability
		SendMessage, 0x433, %intTCCommandFocus%, , , ahk_class TTOTAL_CMD
	}
	
	if !InStr(g_strTotalCommanderNewTabOrWindow, "/N") ; open the folder in a new tab
	{
		intTCCommandOpenNewTab := 3001 ; cm_OpenNewTab
		Sleep, 100 ; wait to improve SendMessage reliability
		SendMessage, 0x433, %intTCCommandOpenNewTab%, , , ahk_class TTOTAL_CMD
	}
	Sleep, 100 ; wait to improve SendMessage reliability in OpenFavoriteNavigateTotalCommander
	gosub, OpenFavoriteNavigateTotalCommander
	; Since g_strFullLocation is integer, OpenFavoriteNavigateTotalCommander is doing:
	; SendMessage, 0x433, %intTCCommand%, , , ahk_class TTOTAL_CMD
	; Sleep, 100 ; wait to improve SendMessage reliability
	; WinActivate, ahk_class TTOTAL_CMD
}
else ; normal folder
{
	if (g_strOpenFavoriteLabel = "OpenFavoriteFromGroup")
	{
		if (g_blnFirstItemOfGroup)
		{
			strTabParameter := "/N" ; /N new window
			strSideParameter := "L" ; /L= left pane of the new window
		}
		else
		{
			if (arrFavoriteWindowPosition8 = "R" and g_blnFirstTotalCommanderRight)
			{
				strTabParameter := "/O" ; change folder in existing initial folder
				g_blnFirstTotalCommanderRight := false
			}
			else
				strTabParameter := "/O /T" ; new tab of existing file list
			strSideParameter := arrFavoriteWindowPosition8 ; "L" or "R"
		}
	}
	else
	{
		strTabParameter := g_strTotalCommanderNewTabOrWindow
		strSideParameter := "L" ; /L= left pane of the new window
		arrFavoriteWindowPosition8 := ""
	}

	; ###_V("", g_strFullLocation, strTabParameter, strSideParameter)
	; g_strTotalCommanderNewTabOrWindow in ini file should contain "/O /T" to open in an new tab of the existing file list (default), or "/N" to open in a new file list
	Run, %g_strTotalCommanderPath% %strTabParameter% /S "/%strSideParameter%=%g_strFullLocation%"
	WinWaitActive, ahk_class TTOTAL_CMD, , 10
}
g_strNewWindowId := "ahk_class TTOTAL_CMD"

intTCCommandOpenNewTab := ""
intTCCommandFocus := ""
strTabParameter := ""
strSideParameter := ""
strFavoriteWindowPosition := ""
arrFavoriteWindowPosition := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteInNewWindowQAPconnect:
;------------------------------------------------------------

; old Run, %g_strQAPconnectPath% %g_strFullLocation% /new
if InStr(g_strFullLocation, " ")
	g_strFullLocation := """" . g_strFullLocation . """"
StringReplace, strQAPconnectParamString, g_strQAPconnectCommandLine, % "%Path%", %g_strFullLocation%
StringReplace, strQAPconnectParamString, strQAPconnectParamString, % "%NewTabSwitch%", %g_strQAPconnectNewTabSwitch%
; ###_V(A_ThisLabel, g_strQAPconnectPath, g_strFullLocation, g_strQAPconnectWindowID, g_strQAPconnectAppPath, g_strQAPconnectCommandLine, g_strQAPconnectNewTabSwitch, strQAPconnectParamString, g_strQAPconnectAppFilename)

; Run, % g_strQAPconnectAppPath . " """ . strQAPconnectParamString . """"
Run, %g_strQAPconnectAppPath% %strQAPconnectParamString%

; ###_V(A_ThisLabel, g_strQAPconnectPath, g_strFullLocation, g_strQAPconnectWindowID, g_strNewWindowId, intPid)
if StrLen(g_strQAPconnectWindowID)
; g_strQAPconnectWindowID is read in the QAPconnect.ini file for the connected file manager.
; It must contain at least some characters of the connected app title, and enough to be specific to this window.
; It is used here to wait for the FM window as identified in QAPconnect.ini. And it is copied to g_strNewWindowId
{
	intPreviousTitleMatchMode := A_TitleMatchMode ; save current match mode
	SetTitleMatchMode, RegEx ; change match mode to RegEx
	; with RegEx, for example, ahk_class IEFrame searches for any window whose class name contains IEFrame anywhere
	; (because by default, regular expressions find a match anywhere in the target string).
	WinWaitActive, ahk_exe %g_strQAPconnectAppFilename%, , 10 ; wait for the window as identified in QAPconnect.ini
	SetTitleMatchMode, %intPreviousTitleMatchMode% ; restore previous match mode
	g_strNewWindowId := g_strQAPconnectWindowID
}
else
	g_strNewWindowId := ""

intPreviousTitleMatchMode := ""
strQAPconnectParamString := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
OpenFavoriteWindowResize:
;------------------------------------------------------------

; ###_V(A_ThisLabel, g_strNewWindowId, g_strQAPconnectWindowID)

if (g_arrFavoriteWindowPosition1 and StrLen(g_strNewWindowId))
{
	intPreviousTitleMatchMode := A_TitleMatchMode
	SetTitleMatchMode, RegEx ; with RegEx: for example, ahk_class IEFrame searches for any window whose class name contains IEFrame anywhere (because by default, regular expressions find a match anywhere in the target string).
	; ###_V(A_ThisLabel, g_strNewWindowId, g_arrFavoriteWindowPosition1, g_arrFavoriteWindowPosition2, g_arrFavoriteWindowPosition3, g_arrFavoriteWindowPosition4, g_arrFavoriteWindowPosition5, g_arrFavoriteWindowPosition6, g_arrFavoriteWindowPosition7)
	Sleep, % g_arrFavoriteWindowPosition7 * (g_blnFirstItemOfGroup ? 2 : 1)
	if (g_arrFavoriteWindowPosition2 = -1) ; Minimized
		WinMinimize, %g_strNewWindowId%
	else if (g_arrFavoriteWindowPosition2 = 1) ; Maximized
		WinMaximize, %g_strNewWindowId%
	else ; Normal
	{
		; see WinRestore doc PostMessage, 0x112, 0xF120,,, %g_strNewWindowId% ; 0x112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE
		WinRestore, %g_strNewWindowId%
		Sleep, %g_arrFavoriteWindowPosition7%
		WinMove, %g_strNewWindowId%,
			, %g_arrFavoriteWindowPosition3% ; left
			, %g_arrFavoriteWindowPosition4% ; top
			, %g_arrFavoriteWindowPosition5% ; width
			, %g_arrFavoriteWindowPosition6% ; height
	}
	SetTitleMatchMode, %intPreviousTitleMatchMode%
}

intPreviousTitleMatchMode := ""

return
;------------------------------------------------------------


;========================================================================================================================
; END OF NEW WINDOW
;========================================================================================================================


;========================================================================================================================
!_076_TRAY_MENU_ACTIONS:
;========================================================================================================================

;------------------------------------------------------------
ShowSettingsIniFile:
;------------------------------------------------------------

Run, %g_strIniFile%

return
;------------------------------------------------------------


;------------------------------------------------------------
ShowQAPconnectIniFile:
;------------------------------------------------------------

Run, %g_strQAPconnectIniPath%

return
;------------------------------------------------------------


;------------------------------------------------------------
RunAtStartup:
;------------------------------------------------------------
; Startup code adapted from Avi Aryan Ryan in Clipjump

Menu, Tray, Togglecheck, %lMenuRunAtStartup%
IfExist, %A_Startup%\%g_strAppNameFile%.lnk
	FileDelete, %A_Startup%\%g_strAppNameFile%.lnk
else
	FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%g_strAppNameFile%.lnk, %A_WorkingDir%

return
;------------------------------------------------------------


;------------------------------------------------------------
SuspendHotkeys:
;------------------------------------------------------------

if (A_IsSuspended)
	Suspend, Off
else
	Suspend, On

Menu, Tray, % (A_IsSuspended ? "check" : "uncheck"), %lMenuSuspendHotkeys%

return
;------------------------------------------------------------


;------------------------------------------------------------
Check4Update:
;------------------------------------------------------------

strUrlCheck4Update := "http://quickaccesspopup.com/latest/latest-version-4.php"
strAppLandingPage := "http://quickaccesspopup.com"
strBetaLandingPage := "http://quickaccesspopup.com/latest/check4update-beta-redirect.html"
strAlphaLandingPage := "http://quickaccesspopup.com/latest/check4update-alpha-redirect.html"

IniRead, strLatestSkippedProd, %g_strIniFile%, Global, LatestVersionSkippedProd, 0.0
IniRead, strLatestSkippedBeta, %g_strIniFile%, Global, LatestVersionSkippedBeta, 0.0
IniRead, strLatestUsedProd, %g_strIniFile%, Global, LastVersionUsedProd, 0.0
IniRead, strLatestUsedBeta, %g_strIniFile%, Global, LastVersionUsedBeta, 0.0

IniRead, intStartups, %g_strIniFile%, Global, Startups, 1

if (g_blnDiagMode)
{
	Diag("Check4Update strAppLandingPage", strAppLandingPage)
	Diag("Check4Update strBetaLandingPage", strBetaLandingPage)
}

Gui, 1:+OwnDialogs

if (A_ThisMenuItem <> lMenuUpdate)
{
	if Time2Donate(intStartups, g_blnDonor)
	{
		MsgBox, 36, % l(lDonateCheckTitle, intStartups, g_strAppNameText), % l(lDonateCheckPrompt, g_strAppNameText, intStartups)
		IfMsgBox, Yes
			Gosub, GuiDonate
	}
	IniWrite, % (intStartups + 1), %g_strIniFile%, Global, Startups
}

blnSetup := (FileExist(A_ScriptDir . "\_do_not_remove_or_rename.txt") = "" ? 0 : 1)

strLatestVersions := Url2Var(strUrlCheck4Update
	. "?v=" . g_strCurrentVersion
	. "&os=" . GetOSVersion()
	. "&is64=" . A_Is64bitOS
    . "&setup=" . (blnSetup)
				+ (2 * (g_blnDonor ? 1 : 0))
				+ (4 * (g_intActiveFileManager = 2 ? 1 : 0)) ; DirectoryOpus
				+ (8 * (g_intActiveFileManager = 3 ? 1 : 0)) ; TotalCommander
				+ (16 * (g_intActiveFileManager = 4 ? 1 : 0)) ; QAPconnect
    . "&lsys=" . A_Language
    . "&lfp=" . g_strLanguageCode)
if !StrLen(strLatestVersions)
	if (A_ThisMenuItem = lMenuUpdate)
	{
		Oops(lUpdateError)
		gosub, Check4UpdateCleanup
		return ; an error occured during ComObjCreate
	}

strLatestVersions := SubStr(strLatestVersions, InStr(strLatestVersions, "[[") + 2) 
strLatestVersions := SubStr(strLatestVersions, 1, InStr(strLatestVersions, "]]") - 1) 
strLatestVersions := Trim(strLatestVersions, "`n`l") ; remove en-of-line if present
Loop, Parse, strLatestVersions, , 0123456789.| ; strLatestVersions should only contain digits, dots and one pipe (|) between prod and beta versions
	; if we get here, the content returned by the URL above is wrong
	if (A_ThisMenuItem <> lMenuUpdate)
	{
		gosub, Check4UpdateCleanup
		return ; return silently
	}
	else
	{
		Oops(lUpdateError) ; return with an error message
		gosub, Check4UpdateCleanup
		return
	}

StringSplit, arrLatestVersions, strLatestVersions, |
strLatestVersionProd := arrLatestVersions1
strLatestVersionBeta := arrLatestVersions2
strLatestVersionAlpha := arrLatestVersions3

Gui, 1:+OwnDialogs

if (strLatestUsedAlpha <> "0.0")
{
	if FirstVsSecondIs(strLatestVersionAlpha, g_strCurrentVersion) = 1
	{
		SetTimer, Check4UpdateChangeButtonNames, 50

		MsgBox, 3, % l(lUpdateTitle, g_strAppNameText) ; do not add Alpha to keep buttons rename working
			, % l(lUpdatePromptAlpha, g_strAppNameText, g_strCurrentVersion, strLatestVersionAlpha)
		IfMsgBox, Yes
			Run, %strAlphaLandingPage%
		IfMsgBox, Cancel ; Remind me
			IniWrite, 0.0, %g_strIniFile%, Global, LatestVersionSkippedAlpha
		IfMsgBox, No
		{
			IniWrite, %strLatestVersionAlpha%, %g_strIniFile%, Global, LatestVersionSkippedAlpha
			MsgBox, 4, % l(lUpdateTitle, g_strAppNameText . " Alpha"), %lUpdatePromptAlphaContinue%
			IfMsgBox, No
				IniWrite, 0.0, %g_strIniFile%, Global, LastVersionUsedAlpha
		}
	}
}

if (strLatestUsedBeta <> "0.0")
{
	if FirstVsSecondIs(strLatestVersionBeta, g_strCurrentVersion) = 1
	{
		SetTimer, Check4UpdateChangeButtonNames, 50

		MsgBox, 3, % l(lUpdateTitle, g_strAppNameText) ; do not add BETA to keep buttons rename working
			, % l(lUpdatePromptBeta, g_strAppNameText, g_strCurrentVersion, strLatestVersionBeta)
		IfMsgBox, Yes
			Run, %strBetaLandingPage%
		IfMsgBox, Cancel ; Remind me
			IniWrite, 0.0, %g_strIniFile%, Global, LatestVersionSkippedBeta
		IfMsgBox, No
		{
			IniWrite, %strLatestVersionBeta%, %g_strIniFile%, Global, LatestVersionSkippedBeta
			MsgBox, 4, % l(lUpdateTitle, g_strAppNameText . " BETA"), %lUpdatePromptBetaContinue%
			IfMsgBox, No
				IniWrite, 0.0, %g_strIniFile%, Global, LastVersionUsedBeta
		}
	}
}

if (FirstVsSecondIs(strLatestSkippedProd, strLatestVersionProd) >= 0 and (A_ThisMenuItem <> lMenuUpdate))
{
	gosub, Check4UpdateCleanup
	return
}

if FirstVsSecondIs(strLatestVersionProd, g_strCurrentVersion) = 1
{
	SetTimer, Check4UpdateChangeButtonNames, 50

	MsgBox, 3, % l(lUpdateTitle, g_strAppNameText)
		, % l(lUpdatePrompt, g_strAppNameText, g_strCurrentVersion, strLatestVersionProd)
	IfMsgBox, Yes
		Run, %strAppLandingPage%
	IfMsgBox, No
		IniWrite, %strLatestVersionProd%, %g_strIniFile%, Global, LatestVersionSkipped ; do not add "Prod" to ini variable for backward compatibility
	IfMsgBox, Cancel ; Remind me
		IniWrite, 0.0, %g_strIniFile%, Global, LatestVersionSkipped ; do not add "Prod" to ini variable for backward compatibility
}
else if (A_ThisMenuItem = lMenuUpdate)
{
	MsgBox, 4, % l(lUpdateTitle, g_strAppNameText), % l(lUpdateYouHaveLatest, g_strAppVersion, g_strAppNameText)
	IfMsgBox, Yes
	{
		if (g_blnDiagMode)
		{
			Diag("Check4Update lMenuUpdate g_strCurrentBranch", g_strCurrentBranch)
			Diag("Check4Update lMenuUpdate strAppLandingPage", strAppLandingPage)
			Diag("Check4Update lMenuUpdate strBetaLandingPage", strBetaLandingPage)
		}
		Run, %strAppLandingPage%
	}
}

Check4UpdateCleanup:
strLatestSkippedProd := ""
strLatestSkippedBeta := ""
strLatestUsedProd := ""
strLatestUsedBeta := ""
intStartups := ""

return 
;------------------------------------------------------------


;------------------------------------------------------------
FirstVsSecondIs(strFirstVersion, strSecondVersion)
;------------------------------------------------------------
{
	StringSplit, arrFirstVersion, strFirstVersion, `.
	StringSplit, arrSecondVersion, strSecondVersion, `.
	if (arrFirstVersion0 > arrSecondVersion0)
		intLoop := arrFirstVersion0
	else
		intLoop := arrSecondVersion0

	Loop %intLoop%
		if (arrFirstVersion%A_index% > arrSecondVersion%A_index%)
			return 1 ; greater
		else if (arrFirstVersion%A_index% < arrSecondVersion%A_index%)
			return -1 ; smaller
		
	return 0 ; equal
}
;------------------------------------------------------------


;------------------------------------------------------------
Check4UpdateChangeButtonNames:
;------------------------------------------------------------

IfWinNotExist, % l(lUpdateTitle, g_strAppNameText)
    return  ; Keep waiting.
SetTimer, Check4UpdateChangeButtonNames, Off
WinActivate 
ControlSetText, Button3, %lUpdateButtonRemind%

return
;------------------------------------------------------------


;------------------------------------------------------------
Time2Donate(intStartups, g_blnDonor)
;------------------------------------------------------------
{
	return !Mod(intStartups, 20) and (intStartups > 40) and !(g_blnDonor)
}
;------------------------------------------------------------



;========================================================================================================================
; END OF TRAY MENU ACTIONS
;========================================================================================================================



;========================================================================================================================
!_078_ABOUT-DONATE-HELP:
;========================================================================================================================

;------------------------------------------------------------
GuiAbout:
;------------------------------------------------------------

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide

Gui, 2:New, , % L(lAboutTitle, g_strAppNameText, g_strAppVersion)
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%
Gui, 2:+Owner1
Gui, 2:Font, s12 w700, Verdana
Gui, 2:Add, Link, y10 w380, % L(lAboutText1, g_strAppNameText, g_strAppVersion, A_PtrSize * 8) ;  ; A_PtrSize * 8 = 32 or 64
Gui, 2:Font, s8 w400, Verdana
Gui, 2:Add, Link, w380, % L(lAboutText2, g_strAppNameText)
Gui, 2:Add, Link, w380, % L(lAboutText3, chr(169))
Gui, 2:Font, s10 w400, Verdana
Gui, 2:Add, Link, w380, % L(lAboutText4)
Gui, 2:Font, s8 w400, Verdana

Gui, 2:Add, Button, y+20 vf_btnAboutDonate gGuiDonate, %lDonateButton%
Gui, 2:Add, Button, yp vf_btnAboutClose g2GuiClose, %lGui2Close%
GuiCenterButtons(L(lAboutTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnAboutDonate", "f_btnAboutClose")

GuiControl, Focus, f_btnAboutClose
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiDonate:
;------------------------------------------------------------

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide

Gui, 2:New, , % L(lDonateTitle, g_strAppNameText, g_strAppVersion)
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%
Gui, 2:+Owner1
Gui, 2:Font, s12 w700, Verdana
Gui, 2:Add, Link, y10 w420, % L(lDonateText1, g_strAppNameText)
Gui, 2:Font, s8 w400, Verdana
Gui, 2:Add, Link, x175 w185 y+10, % L(lDonateText2, "http://code.jeanlalonde.ca/support-freeware/")
loop, 2
{
	Gui, 2:Add, Button, % (A_Index = 1 ? "y+10 Default vbtnDonateDefault " : "") . " xm w150 gButtonDonate" . A_Index, % lDonatePlatformName%A_Index%
	Gui, 2:Add, Link, x+10 w235 yp, % lDonatePlatformComment%A_Index%
}

Gui, 2:Font, s10 w700, Verdana
Gui, 2:Add, Link, xm y+20 w420, %lDonateText3%
Gui, 2:Font, s8 w400, Verdana
Gui, 2:Add, Link, xm y+10 w420 Section, % L(lDonateText4, g_strAppNameText)

strDonateReviewUrlLeft1 := "http://download.cnet.com/FoldersPopup/3000-2344_4-76062382.html"
strDonateReviewUrlLeft2 := "http://www.portablefreeware.com/index.php?id=2557"
strDonateReviewUrlLeft3 := "http://www.softpedia.com/get/System/OS-Enhancements/FoldersPopup.shtml"
strDonateReviewUrlRight1 := "http://fileforum.betanews.com/detail/Folders-Popup/1385175626/1"
strDonateReviewUrlRight2 := "http://www.filecluster.com/System-Utilities/Other-Utilities/Download-FoldersPopup.html"
strDonateReviewUrlRight3 := "http://freewares-tutos.blogspot.fr/2013/12/folders-popup-un-logiciel-portable-pour.html"

loop, 3
	Gui, 2:Add, Link, % (A_Index = 1 ? "ys+20" : "y+5") . " x25 w150", % "<a href=""" . strDonateReviewUrlLeft%A_Index% . """>" . lDonateReviewNameLeft%A_Index% . "</a>"

loop, 3
	Gui, 2:Add, Link, % (A_Index = 1 ? "ys+20" : "y+5") . " x175 w150", % "<a href=""" . strDonateReviewUrlRight%A_Index% . """>" . lDonateReviewNameRight%A_Index% . "</a>"

Gui, 2:Add, Link, y+10 x130, <a href="http://code.jeanlalonde.ca/support-freeware/">%lDonateText5%</a>

Gui, 2:Font, s8 w400, Verdana
Gui, 2:Add, Button, x175 y+20 g2GuiClose vf_btnDonateClose, %lGui2Close%
GuiCenterButtons(L(lDonateTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnDonateClose")

GuiControl, Focus, btnDonateDefault
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

strDonateReviewUrlLeft1 := ""
strDonateReviewUrlLeft2 := ""
strDonateReviewUrlLeft3 := ""
strDonateReviewUrlRight1 := ""
strDonateReviewUrlRight2 := ""
strDonateReviewUrlRight3 := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
ButtonDonate1:
ButtonDonate2:
ButtonDonate3:
;------------------------------------------------------------

strDonatePlatformUrl1 := "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=AJNCXKWKYAXLCV"
strDonatePlatformUrl2 := "http://www.shareit.com/product.html?productid=300628012"
strDonatePlatformUrl3 := "http://code.jeanlalonde.ca/?flattrss_redirect&id=19&md5=e1767c143c9bde02b4e7f8d9eb362b71"

StringReplace, strButton, A_ThisLabel, ButtonDonate
Run, % strDonatePlatformUrl%strButton%

return
;------------------------------------------------------------


;------------------------------------------------------------
GuiHelp:
;------------------------------------------------------------

g_intGui1WinID := WinExist("A")
Gui, 1:Submit, NoHide

Gui, 2:New, , % L(lHelpTitle, g_strAppNameText, g_strAppVersion)
if (g_blnUseColors)
	Gui, 2:Color, %g_strGuiWindowColor%
Gui, 2:+Owner1
intWidth := 600
Gui, 2:Font, s12 w700, Verdana
Gui, 2:Add, Text, x10 y10, %g_strAppNameText%
Gui, 2:Font, s10 w400, Verdana
Gui, 2:Add, Link, x10 w%intWidth%, %lHelpTextLead%

Gui, 2:Font, s8 w600, Verdana
Gui, 2:Add, Tab2, vf_intHelpTab w640 h350 AltSubmit, %A_Space%%lHelpTabGettingStarted% | %lHelpTabAddingFavorite% | %lHelpTabQAPFeatures% | %lHelpTabTipsAndTricks%%A_Space%

Gui, 2:Font, s8 w400, Verdana
Gui, 2:Tab, 1
Gui, 2:Add, Link, w%intWidth%, % L(lHelpText11, Hotkey2Text(g_arrPopupHotkeys1), Hotkey2Text(g_arrPopupHotkeys2))
Gui, 2:Add, Link, w%intWidth%, % lHelpText12
Gui, 2:Add, Link, w%intWidth%, % L(lHelpText13, Hotkey2Text(g_arrPopupHotkeys3), Hotkey2Text(g_arrPopupHotkeys4))
Gui, 2:Add, Link, w%intWidth%, % lHelpText14
Gui, 2:Add, Button, y+25 vf_btnNext1 gNextHelpButtonClicked, %lDialogTabNext%
GuiCenterButtons(L(lHelpTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnNext1")

Gui, 2:Tab, 2
Gui, 2:Add, Link, w%intWidth%, % lHelpText21
Gui, 2:Add, Link, w%intWidth%, % lHelpText22
Gui, 2:Add, Link, w%intWidth%, % L(lHelpText23, Hotkey2Text(g_arrPopupHotkeys1), Hotkey2Text(g_arrPopupHotkeys2))
Gui, 2:Add, Button, y+25 vf_btnNext2 gNextHelpButtonClicked, %lDialogTabNext%
GuiCenterButtons(L(lHelpTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnNext2")

Gui, 2:Tab, 3
Gui, 2:Add, Link, w%intWidth%, % lHelpText31
Gui, 2:Add, Link, w%intWidth%, % lHelpText32
Gui, 2:Add, Link, w%intWidth%, % L(lHelpText33, Hotkey2Text(g_objHotkeysByLocation["{Settings}"]))
Gui, 2:Add, Button, y+25 vf_btnNext3 gNextHelpButtonClicked, %lDialogTabNext%
GuiCenterButtons(L(lHelpTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnNext3")

Gui, 2:Tab, 4
Gui, 2:Add, Link, w%intWidth%, % lHelpText41
Gui, 2:Add, Link, y+5 w%intWidth%, % lHelpText42
Gui, 2:Add, Link, y+5 w%intWidth%, % lHelpText43
Gui, 2:Add, Link, y+5 w%intWidth%, % lHelpText44
Gui, 2:Add, Link, y+5 w%intWidth%, % lHelpText45

Gui, 2:Tab
GuiControlGet, arrTabPos, Pos, f_intHelpTab
Gui, 2:Add, Button, % "x180 y" . arrTabPosY + arrTabPosH + 10. " vf_btnHelpDonate gGuiDonate", %lDonateButton%
Gui, 2:Add, Button, x+80 yp g2GuiClose vf_btnHelpClose, %lGui2Close%
GuiCenterButtons(L(lHelpTitle, g_strAppNameText, g_strAppVersion), 10, 5, 20, "f_btnHelpDonate", "f_btnHelpClose")

GuiControl, Focus, btnHelpClose
Gui, 2:Show, AutoSize Center
Gui, 1:+Disabled

return
;------------------------------------------------------------


;------------------------------------------------------------
NextHelpButtonClicked:
;------------------------------------------------------------

Gui, 2:Submit, NoHide

GuiControl, Choose, f_intHelpTab, % f_intHelpTab + 1 ; f_intHelpTab is number of current tab

return
;------------------------------------------------------------



;========================================================================================================================
; END OF ABOUT-DONATE-HELP
;========================================================================================================================



;========================================================================================================================
!_080_THIRD-PARTY:
;========================================================================================================================


;------------------------------------------------------------
CheckActiveFileManager:
;------------------------------------------------------------

loop, 2
{
	intFileManager := A_Index + 1 ; 2 DirectoryOpus or 3 TotalCommander
	Gosub, CheckOneFileManager
	if (g_intActiveFileManager = intFileManager)
	{
		Gosub, CheckActiveFileManagerCleanUp
		return
	}
}

; if no other file manager was selected
g_intActiveFileManager := 1
IniWrite, 1, %g_strIniFile%, Global, ActiveFileManager

CheckActiveFileManagerCleanUp:
intFileManager := ""
strCheckOneFileManager := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckOneFileManager:
;------------------------------------------------------------

strFileManagerSystemName := g_arrActiveFileManagerSystemNames%intFileManager%

strFileManagerDisplayName := g_arrActiveFileManagerDisplayNames%intFileManager%
if (intFileManager = 2) ; DirectoryOpus
	strCheckPath := A_ProgramFiles . "\GPSoftware\Directory Opus\dopus.exe"
else ; 3 TotalCommander
	strCheckPath := GetTotalCommanderPath()

if FileExist(strCheckPath)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDialogThirdPartyDetected, g_strAppNameText, strFileManagerDisplayName)
	IfMsgBox, Yes
	{
		g_intActiveFileManager := intFileManager
		IniWrite, %g_intActiveFileManager%, %g_strIniFile%, Global, ActiveFileManager
		g_str%strFileManagerSystemName%Path := strCheckPath
		Gosub, SetActiveFileManager
		IniWrite, % g_str%strFileManagerSystemName%Path, %g_strIniFile%, Global, %strFileManagerSystemName%Path
		g_bln%strFileManagerSystemName%UseTabs := true
		IniWrite, % g_bln%strFileManagerSystemName%UseTabs, %g_strIniFile%, Global, %strFileManagerSystemName%UseTabs
		
		if (g_intActiveFileManager = 2) ; DirectoryOpus
			g_strDirectoryOpusNewTabOrWindow := "NEWTAB" ; open new folder in a new lister tab
		else ; 3 TotalCommander
			g_strTotalCommanderNewTabOrWindow := "/O /T" ; to open in a new tab
		IniWrite, % g_str%strFileManagerSystemName%NewTabOrWindow, %g_strIniFile%, Global, %strFileManagerSystemName%NewTabOrWindow
	}
}

strFileManagerSystemName := ""
strFileManagerDisplayName := ""
strCheckPath := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GetTotalCommanderPath()
; ### used - do not remove
;------------------------------------------------------------
{
	RegRead, strPath, HKEY_CURRENT_USER, Software\Ghisler\Total Commander\, InstallDir
	If !StrLen(strPath)
		RegRead, strPath, HKEY_LOCAL_MACHINE, Software\Ghisler\Total Commander\, InstallDir

	if FileExist(strPath . "\TOTALCMD64.EXE")
		strPath := strPath . "\TOTALCMD64.EXE"
	else
		strPath := strPath . "\TOTALCMD.EXE"
	return strPath
}
;------------------------------------------------------------


;------------------------------------------------------------
LoadIniQAPconnectValues:
;------------------------------------------------------------

/* QAPconnect.ini sample:
[EF Commander Free (v9.50)]
; http://www.softpedia.com/get/File-managers/EF-Commander-Free.shtml
AppPath=..\EF Commander Free\EFCommanderFreePortable.exe
CommandLine=/O /A=%Path%
NewTabSwitch=
CompanionPath=EFCWT.EXE
*/

IniRead, g_strQAPconnectAppPath, %g_strQAPconnectIniPath%, %g_strQAPconnectFileManager%, AppPath, %A_Space% ; empty by default
g_strQAPconnectAppPath := PathCombine(A_WorkingDir, EnvVars(g_strQAPconnectAppPath))
IniRead, g_strQAPconnectCommandLine, %g_strQAPconnectIniPath%, %g_strQAPconnectFileManager%, CommandLine, %A_Space% ; empty by default
IniRead, g_strQAPconnectNewTabSwitch, %g_strQAPconnectIniPath%, %g_strQAPconnectFileManager%, NewTabSwitch, %A_Space% ; empty by default
IniRead, g_strQAPconnectCompanionPath, %g_strQAPconnectIniPath%, %g_strQAPconnectFileManager%, CompanionPath, %A_Space% ; empty by default
if StrLen(g_strQAPconnectCompanionPath)
	g_strQAPconnectCompanionPath := PathCombine(A_WorkingDir, EnvVars(g_strQAPconnectCompanionPath))
SplitPath, g_strQAPconnectCompanionPath, g_strQAPconnectCompanionFilename

; ###_V(A_ThisLabel, g_strQAPconnectAppPath, g_strQAPconnectCommandLine, g_strQAPconnectNewTabSwitch, g_strQAPconnectCompanionPath)

return
;------------------------------------------------------------


;------------------------------------------------------------
SetActiveFileManager:
;------------------------------------------------------------

if (g_intActiveFileManager = 4) ; QAPconnect
{
	SplitPath, g_strQAPconnectAppPath, g_strQAPconnectAppFilename
	g_strQAPconnectWindowID := "ahk_exe " . g_strQAPconnectAppFilename ; ahk_exe worked with filename only, not with full exe path
	
	; ###_V(A_ThisLabel, g_strQAPconnectAppPath, g_strQAPconnectAppFilename, g_strQAPconnectWindowID, g_strQAPconnectCompanionPath)
}
else ; DirectoryOpus or TotalCommander
{
	strActiveFileManagerSystemName := g_arrActiveFileManagerSystemNames%g_intActiveFileManager%
	IniRead, g_str%strActiveFileManagerSystemName%NewTabOrWindow, %g_strIniFile%, Global, %strActiveFileManagerSystemName%NewTabOrWindow, %A_Space% ; should be already intialized here, empty if error

	if (g_intActiveFileManager = 2) ; DirectoryOpus
	{
		g_strDOpusTempFilePath := g_strTempDir . "\dopus-list.txt"
		StringReplace, g_strDirectoryOpusRtPath, g_strDirectoryOpusPath, \dopus.exe, \dopusrt.exe
	}

	; additional icon for DirectoryOpus and TotalCommander
	g_objIconsFile[strActiveFileManagerSystemName] := g_str%strActiveFileManagerSystemName%Path
	g_objIconsIndex[strActiveFileManagerSystemName] := 1
}

strActiveFileManagerSystemName := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
RunDOpusRt(strCommand, strLocation := "", strParam := "")
; put A_Space at the beginning of strParam if required - some param (like ",paths") must have no space 
;------------------------------------------------------------
{
	global g_strDirectoryOpusRtPath
	
	if FileExist(g_strDirectoryOpusRtPath)
		Run, % """" . g_strDirectoryOpusRtPath . """ " . strCommand . " """ . strLocation . """" . strParam
}
;------------------------------------------------------------



;========================================================================================================================
; END OF THIRD-PARTY
;========================================================================================================================



;========================================================================================================================
!_090_VARIOUS_FUNCTIONS:
return
;========================================================================================================================

;------------------------------------------------
L(strMessage, objVariables*)
;------------------------------------------------
{
	Loop
	{
		if InStr(strMessage, "~" . A_Index . "~")
			StringReplace, strMessage, strMessage, ~%A_Index%~, % objVariables[A_Index], A
 		else
			break
	}
	
	return strMessage
}
;------------------------------------------------


;------------------------------------------------
Oops(strMessage, objVariables*)
;------------------------------------------------
{
	global g_strAppNameText
	global g_strAppVersion
	
	Gui, 1:+OwnDialogs
	MsgBox, 48, % L(lOopsTitle, g_strAppNameText, g_strAppVersion), % L(strMessage, objVariables*)
}
; ------------------------------------------------


;------------------------------------------------------------
GetOSVersion()
;------------------------------------------------------------
{
	if (GetOSVersionInfo().MajorVersion = 10)
		return "WIN_10"
	else
		return A_OSVersion
}
;------------------------------------------------------------


;------------------------------------------------------------
OSVersionIsWorkstation()
;------------------------------------------------------------
{
	return (GetOSVersionInfo() and (GetOSVersionInfo().ProductType = 1))
}
;------------------------------------------------------------


;------------------------------------------------------------
GetOSVersionInfo()
; by shajul (http://www.autohotkey.com/board/topic/54639-getosversion/?p=414249)
; reference: http://msdn.microsoft.com/en-ca/library/windows/desktop/ms724833(v=vs.85).aspx
;------------------------------------------------------------
{
	static Ver

	If !Ver
	{
		VarSetCapacity(OSVer, 284, 0)
		NumPut(284, OSVer, 0, "UInt")
		If !DllCall("GetVersionExW", "Ptr", &OSVer)
		   return 0 ; GetSysErrorText(A_LastError)
		Ver := Object()
		Ver.MajorVersion      := NumGet(OSVer, 4, "UInt")
		Ver.MinorVersion      := NumGet(OSVer, 8, "UInt")
		Ver.BuildNumber       := NumGet(OSVer, 12, "UInt")
		Ver.PlatformId        := NumGet(OSVer, 16, "UInt")
		Ver.ServicePackString := StrGet(&OSVer+20, 128, "UTF-16")
		Ver.ServicePackMajor  := NumGet(OSVer, 276, "UShort")
		Ver.ServicePackMinor  := NumGet(OSVer, 278, "UShort")
		Ver.SuiteMask         := NumGet(OSVer, 280, "UShort")
		Ver.ProductType       := NumGet(OSVer, 282, "UChar") ; 1 = VER_NT_WORKSTATION, 2 = VER_NT_DOMAIN_CONTROLLER, 3 = VER_NT_SERVER
		Ver.EasyVersion       := Ver.MajorVersion . "." . Ver.MinorVersion . "." . Ver.BuildNumber
	}
	return Ver
}
;------------------------------------------------------------


;------------------------------------------------------------
SplitHotkey(strHotkey, ByRef strModifiers, ByRef strKey, ByRef strMouseButton, ByRef strMouseButtonsWithDefault)
;------------------------------------------------------------
{
	; safer that declaring individual variables (see "Common source of confusion" in https://www.autohotkey.com/docs/Functions.htm#Locals)
	global

	if (strHotkey = "None") ; do not compare with lDialogNone because it is translated
	{
		strModifiers := ""
		strKey := ""
		strMouseButton := "None" ; do not use lDialogNone because it is translated
		StringReplace, strMouseButtonsWithDefault, lDialogMouseButtonsText, % lDialogNone . "|", % lDialogNone . "||" ; use lDialogNone because this is displayed
	}
	else 
	{
		SplitModifiersFromKey(strHotkey, strModifiers, strKey)

		if InStr(g_strMouseButtons, "|" . strKey . "|") ;  we have a mouse button
		{
			strMouseButton := strKey
			strKey := ""
			StringReplace, strMouseButtonsWithDefault, lDialogMouseButtonsText, % GetText4MouseButton(strMouseButton) . "|", % GetText4MouseButton(strMouseButton) . "||" ; with default value
		}
		else ; we have a key
			strMouseButtonsWithDefault := lDialogMouseButtonsText ; no default value
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
Hotkey2Text(strHotkey, blnShort := false)
;------------------------------------------------------------
{
	SplitHotkey(strHotkey, strModifiers, strOptionsKey, strMouseButto, strMouseButtonsWithDefault)

	return HotkeySections2Text(strModifiers, strMouseButto, strOptionsKey, blnShort)
}
;------------------------------------------------------------


;------------------------------------------------------------
HotkeySections2Text(strModifiers, strMouseButton, strKey, blnShort := false)
;------------------------------------------------------------
{
	if (strMouseButton = "None") ; do not compare with lDialogNone because it is translated
		or !StrLen(strModifiers . strMouseButton . strKey) ; if all parameters are empty
		str := lDialogNone ; use lDialogNone because this is displayed
	else
	{
		str := ""
		loop, parse, strModifiers
		{
			if (A_LoopField = "!")
				str := str . lDialogAlt . "+"
			if (A_LoopField = "^")
				str := str . (blnShort ? lDialogCtrlShort : lDialogCtrl) . "+"
			if (A_LoopField = "+")
				str := str . lDialogShift . "+"
			if (A_LoopField = "#")
				str := str . (blnShort ? lDialogWinShort : lDialogWin) . "+"
		}
		if StrLen(strMouseButton)
			str := str . GetText4MouseButton(strMouseButton)
		if StrLen(strKey)
		{
			StringUpper, strKey, strKey
			str := str . strKey
		}
	}

	return str
}
;------------------------------------------------------------


;------------------------------------------------------------
GetText4MouseButton(strSource)
; Returns the string in g_arrMouseButtonsText at the same position of strSource in g_arrMouseButtons
;------------------------------------------------------------
{
	; safer that declaring individual variables (see "Common source of confusion" in https://www.autohotkey.com/docs/Functions.htm#Locals)
	global

	loop, %g_arrMouseButtons0%
	{
		if (strSource = g_arrMouseButtons%A_Index%)
			return g_arrMouseButtonsText%A_Index%
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
GetMouseButton4Text(strSource)
; Returns the string in g_arrMouseButtons at the same position of strSource in g_arrMouseButtonsText
;------------------------------------------------------------
{
	global

	loop, %g_arrMouseButtonsText0%
		if (strSource = g_arrMouseButtonsText%A_Index%)
			return g_arrMouseButtons%A_Index%
}
;------------------------------------------------------------


;------------------------------------------------------------
SplitModifiersFromKey(strHotkey, ByRef strModifiers, ByRef strKey)
;------------------------------------------------------------
{
	intModifiersEnd := GetFirstNotModifier(strHotkey)
	StringLeft, strModifiers, strHotkey, %intModifiersEnd%
	StringMid, strKey, strHotkey, % (intModifiersEnd + 1)
}
;------------------------------------------------------------


;------------------------------------------------------------
GetFirstNotModifier(strHotkey)
;------------------------------------------------------------
{
	intPos := 0
	loop, Parse, strHotkey
		if (A_LoopField = "^") or (A_LoopField = "!") or (A_LoopField = "+") or (A_LoopField = "#")
			intPos := intPos + 1
		else
			return intPos
	return intPos
}
;------------------------------------------------------------


;------------------------------------------------------------
EnvVars(str)
; from Lexikos http://www.autohotkey.com/board/topic/40115-func-envvars-replace-environment-variables-in-text/#entry310601
;------------------------------------------------------------
{
    if sz:=DllCall("ExpandEnvironmentStrings", "uint", &str
                    , "uint", 0, "uint", 0)
    {
        VarSetCapacity(dst, A_IsUnicode ? sz*2:sz)
        if DllCall("ExpandEnvironmentStrings", "uint", &str
                    , "str", dst, "uint", sz)
            return dst
    }
    return src
}
;------------------------------------------------------------


;------------------------------------------------
Diag(strName, strData)
;------------------------------------------------
{
	global g_strDiagFile
	
	FormatTime, strNow, %A_Now%, yyyyMMdd@HH:mm:ss
	loop
	{
		FileAppend, %strNow%.%A_MSec%`t%strName%`t%strData%`n, %g_strDiagFile%
		if ErrorLevel
			Sleep, 20
	}
	until !ErrorLevel or (A_Index > 50) ; after 1 second (20ms x 50), we have a problem
}
;------------------------------------------------


;------------------------------------------------------------
ParseIconResource(strIconResource, ByRef strIconFile, ByRef intIconIndex, strDefaultType := "")
;------------------------------------------------------------
{
	global g_objIconsFile ; ok
	global g_objIconsIndex ; ok
	
	if !StrLen(strDefaultType)
		strDefaultType := "iconUnknown"
	
	if StrLen(strIconResource)
		If InStr(strIconResource, ",") ; this is icongroup files
		{
			intIconResourceCommaPosition := InStr(strIconResource, ",", , 0) ; search reverse
			StringLeft, strIconFile, strIconResource, % intIconResourceCommaPosition - 1
			StringRight, intIconIndex, strIconResource, % StrLen(strIconResource) - intIconResourceCommaPosition
		}
		else
		{
			strIconFile := strIconResource
			intIconIndex := 1
		}
	else
	{
		strIconFile := g_objIconsFile[strDefaultType]
		intIconIndex := g_objIconsIndex[strDefaultType]
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
GetIcon4Location(strLocation, ByRef strDefaultIcon, ByRef intDefaultIcon, blnRadioApplication := false)
; get icon, extract from kiu http://www.autohotkey.com/board/topic/8616-kiu-icons-manager-quickly-change-icon-files/
;------------------------------------------------------------
{
	global g_blnDiagMode
	global g_objIconsFile
	global g_objIconsIndex
	
	if !StrLen(strLocation)
	{
		if (blnRadioApplication)
		{
			strDefaultIcon := g_objIconsFile["iconApplication"]
			intDefaultIcon := g_objIconsIndex["iconApplication"]
		}
		else
		{
			strDefaultIcon := g_objIconsFile["iconUnknown"]
			intDefaultIcon := g_objIconsIndex["iconUnknown"]
		}
		return
	}
	
	SplitPath, strLocation, , , strExtension
	RegRead, strHKeyClassRoot, HKEY_CLASSES_ROOT, .%strExtension%
	RegRead, strRegistryIconResource, HKEY_CLASSES_ROOT, %strHKeyClassRoot%\DefaultIcon
	
	if (g_blnDiagMode)
	{
		Diag("BuildOneMenuIcon", strLocation)
		Diag("strHKeyClassRoot", strHKeyClassRoot)
		Diag("strRegistryIconResource", strRegistryIconResource)
	}
	
	if (strRegistryIconResource = "%1") ; use the file itself (for executable)
	{
		strDefaultIcon := strLocation
		intDefaultIcon := 1
		return
	}
	
	if !StrLen(strHKeyClassRoot)
	{
		strDefaultIcon := g_objIconsFile["iconUnknown"]
		intDefaultIcon := g_objIconsIndex["iconUnknown"]
	}
	else
		ParseIconResource(strRegistryIconResource, strDefaultIcon, intDefaultIcon)

	if (g_blnDiagMode)
	{
		Diag("strDefaultIcon", strDefaultIcon)
		Diag("intDefaultIcon", intDefaultIcon)
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
GuiCenterButtons(strWindow, intInsideHorizontalMargin := 10, intInsideVerticalMargin := 0, intDistanceBetweenButtons := 20, arrControls*)
; This is a variadic function. See: http://ahkscript.org/docs/Functions.htm#Variadic
;------------------------------------------------------------
{
	Gui, Show, Hide ; why?
	WinGetPos, , , intWidth, , %strWindow%

	intMaxControlWidth := 0
	intMaxControlHeight := 0
	for intIndex, strControl in arrControls
	{
		GuiControlGet, arrControlPos, Pos, %strControl%
		if (arrControlPosW > intMaxControlWidth)
			intMaxControlWidth := arrControlPosW
		if (arrControlPosH > intMaxControlHeight)
			intMaxControlHeight := arrControlPosH
	}
	
	intMaxControlWidth := intMaxControlWidth + intInsideHorizontalMargin
	intButtonsWidth := (arrControls.MaxIndex() * intMaxControlWidth) + ((arrControls.MaxIndex()  - 1) * intDistanceBetweenButtons)
	intLeftMargin := (intWidth - intButtonsWidth) // 2

	for intIndex, strControl in arrControls
		GuiControl, Move, %strControl%
			, % "x" . intLeftMargin + ((intIndex - 1) * intMaxControlWidth) + ((intIndex - 1) * intDistanceBetweenButtons)
			. " w" . intMaxControlWidth
			. " h" . intMaxControlHeight + intInsideVerticalMargin
}
;------------------------------------------------------------


;------------------------------------------------------------
RecursiveBuildMenuTreeDropDown(objMenu, strDefaultMenuName, strSkipMenuName := "")
; recursive function
;------------------------------------------------------------
{
	strList := objMenu.MenuPath
	if (objMenu.MenuPath = strDefaultMenuName)
		strList .= "|" ; default value

	Loop, % objMenu.MaxIndex()
		if InStr("Menu|Group", objMenu[A_Index].FavoriteType) ; this is a menu or a group
			if (objMenu[A_Index].Submenu.MenuPath <> strSkipMenuName) ; skip to avoid moving a submenu under itself (in GuiEditFavorite)
				strList .= "|" . RecursiveBuildMenuTreeDropDown(objMenu[A_Index].Submenu, strDefaultMenuName, strSkipMenuName) ; recursive call
	return strList
}
;------------------------------------------------------------


;------------------------------------------------------------
LocationIsDocument(strLocation)
;------------------------------------------------------------
{
    FileGetAttrib, strAttributes, %strLocation%
    return !InStr(strAttributes, "D") ; not a folder
}
;------------------------------------------------------------


;------------------------------------------------------------
GetDeepestFolderName(strLocation)
;------------------------------------------------------------
{
	SplitPath, strLocation, , , , strDeepestName, strDrive
	if !StrLen(strDeepestName) ; we are probably at the root of a drive
		return strDrive
	else
		return strDeepestName
}
;------------------------------------------------------------


;------------------------------------------------------------
GetDeepestMenuPath(strPath)
;------------------------------------------------------------
{
	global g_strMenuPathSeparator ; only used for menu, not for group
	
	return Trim(SubStr(strPath, InStr(strPath, g_strMenuPathSeparator, , 0) + 1, 9999))
}
;------------------------------------------------------------


;------------------------------------------------------------
CollectRunningApplications(strDefaultPath)
;------------------------------------------------------------
{
	objApps := Object()

	Winget, strIDs, list
	
	Loop, %strIDs%
	{
		WinGet, strPath, ProcessPath, % "ahk_id " . strIDs%A_index%
		if !objApps.HasKey(strPath)
			objApps.Insert(strPath, "")
	}
	for strPath in objApps
	{
		strPaths .= strPath . "|"
		if (strPath = strDefaultPath)
			strPaths .= "|"
	}

	return strPaths
}
;------------------------------------------------------------


;------------------------------------------------------------
ReplaceAllInString(strThis, strFrom, strTo)
;------------------------------------------------------------
{
	StringReplace, strThis, strThis, %strFrom%, %strTo%, A
	return strThis
}
;------------------------------------------------------------


;------------------------------------------------------------
Url2Var(strUrl)
;------------------------------------------------------------
{
	objWebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	/*
	if (A_LastError)
		; an error occurred during ComObjCreate (A_LastError probably is E_UNEXPECTED = -2147418113 #0x8000FFFFL)
		BUT DO NOT ABORT because the following commands will be executed even if an error occurred in ComObjCreate (!)
	*/
	objWebRequest.Open("GET", strUrl)
	objWebRequest.Send()

	return objWebRequest.ResponseText()
}
;------------------------------------------------------------


;------------------------------------------------------------
NameIsInObject(strName, obj)
;------------------------------------------------------------
{
	loop, % obj.MaxIndex()
		if (strName = obj[A_Index].Name)
			return true
		
	return false
}
;------------------------------------------------------------


;------------------------------------------------------------
HasHotkey(strCandidateHotkey)
;------------------------------------------------------------
{
	return StrLen(strCandidateHotkey) and (strCandidateHotkey <> "None")
}
;------------------------------------------------------------


;------------------------------------------------
UriDecode(str)
; by polyethene
; http://www.autohotkey.com/board/topic/17367-url-encoding-and-decoding-of-special-characters/?p=112822
;------------------------------------------------
{
	Loop
		If RegExMatch(str, "i)(?<=%)[\da-f]{1,2}", hex)
			StringReplace, str, str, `%%hex%, % Chr("0x" . hex), All
		Else
			Break
	return str
}
;------------------------------------------------


;------------------------------------------------------------
ComUnHTML(html)
; convert HTML entities to text (like "&apos;") - author unknown
; http://www.autohotkey.com/board/topic/47356-unhtm-remove-html-formatting-from-a-string-updated/page-2#entry467499
;------------------------------------------------------------
{
	oHTML := ComObjCreate("HtmlFile")
	oHTML.write(html)
	return oHTML.documentElement.innerText
}
;------------------------------------------------------------


;------------------------------------------------------------
ExpandPlaceholders(strArguments, strLocation)
; {LOC} (full location), {NAME} (file name), {DIR} (directory), {EXT} (extension), {NOEXT} (file name without extension) or {DRIVE} (drive)
;------------------------------------------------------------
{
	SplitPath, strLocation, strOutFileName, strOutDir, strOutExtension, strOutNameNoExt, strOutDrive
	
	strExpanded := strArguments
	StringReplace, strExpanded, strExpanded, {LOC}, %strLocation%, All
	StringReplace, strExpanded, strExpanded, {NAME}, %strOutFileName%, All
	StringReplace, strExpanded, strExpanded, {DIR}, %strOutDir%, All
	StringReplace, strExpanded, strExpanded, {EXT}, %strOutExtension%, All
	StringReplace, strExpanded, strExpanded, {NOEXT}, %strOutNameNoExt%, All
	StringReplace, strExpanded, strExpanded, {DRIVE}, %strOutDrive%, All
	
	return strExpanded
}
;------------------------------------------------------------


;------------------------------------------------------------
SetTargetClassWinIdAndControl(blnMouseElseKeyboard)
; set g_strTargetClass, g_strTargetWinId and g_strTargetControl
;------------------------------------------------------------
{
	global
	
	if (blnMouseElseKeyboard)
	{
		MouseGetPos, , , g_strTargetWinId, g_strTargetControl
		WinGetClass g_strTargetClass, % "ahk_id " . g_strTargetWinId
		; TrayTip, Navigate Mouse, %strMouseOrKeyboard% = %g_strMouseNavigateHotkey% (%g_intCounter%)`n%g_strTargetWinId%`n%g_strTargetClass%`n%g_strTargetControl%
	}
	else ; Keyboard
	{
		g_strTargetWinId := WinExist("A")
		g_strTargetControl := ""
		WinGetClass g_strTargetClass, % "ahk_id " . g_strTargetWinId
		; TrayTip, Navigate Keyboard, %strMouseOrKeyboard% = %g_strKeyboardNavigateHotkey% (%g_intCounter%)`n%g_strTargetWinId%`n%g_strTargetClass%
	}
}
;------------------------------------------------------------



;========================================================================================================================
; END OF VARIOUS_FUNCTIONS
;========================================================================================================================

;========================================================================================================================
!_095_ONMESSAGE_FUNCTIONS:
return
;========================================================================================================================


;------------------------------------------------
WM_MOUSEMOVE(wParam, lParam)
; "hook" for image buttons cursor
; see http://www.autohotkey.com/board/topic/70261-gui-buttons-hover-cant-change-cursor-to-hand/
;------------------------------------------------
{
	Global objCursor
	Global lGuiFullTitle

	WinGetTitle, strCurrentWindow, A
	if (strCurrentWindow <> lGuiFullTitle)
		return

	MouseGetPos, , , , strControl ; Static1, StaticN, Button1, ButtonN
	if InStr(strControl, "Static")
	{
		StringReplace, intControl, strControl, Static
		; 3-23, 25-26
		if (intControl < 3) or (intControl = 24) or (intControl > 26)
			return
	}
	else if !InStr(strControl, "Button")
		return

	DllCall("SetCursor", "UInt", objCursor)

	return
}
;------------------------------------------------


;------------------------------------------------------------
WM_LBUTTONDBLCLK(wParam, lParam, msg, hwnd)
; To prevent double-click on image static controls to copy their path to the clipboard
; see http://www.autohotkey.com/board/topic/94962-doubleclick-on-gui-pictures-puts-their-path-in-your-clipboard/#entry682595
;------------------------------------------------------------
{
    WinGetClass class, ahk_id %hwnd%
    if (class = "Static") {
        if !A_Gui
            return 0  ; Just prevent Clipboard change.
        ; Send a WM_COMMAND message to the Gui to trigger the control's g-label.
        Gui +LastFound
        id := DllCall("GetDlgCtrlID", "ptr", hwnd) ; Requires AutoHotkey v1.1.
        static STN_DBLCLK := 1
        PostMessage 0x111, id | (STN_DBLCLK << 16), hwnd
        ; Return a value to prevent the default handling of this message.
        return 0
    }
}
;------------------------------------------------------------


;------------------------------------------------------------
AHK_NOTIFYICON(wParam, lParam) 
; Adapted from Lexikos http://www.autohotkey.com/board/topic/11250-mouseover-trayicon-triggering-an-event/#entry153388
; To popup menu when left click on the tray icon - See the OnMessage command in the init section
;------------------------------------------------------------
{
	global blnClickOnTrayIcon
	
	if (lParam = 0x202) ; WM_LBUTTONUP
	{
		blnClickOnTrayIcon := true
		; SetTimer, LaunchHotkeyMouse, -1
		SetTimer, LaunchFromTrayIcon, -1
		return 0
	}
} 
;------------------------------------------------------------


;------------------------------------------------------------
ReplyQAPisRunning(wParam, lParam) 
;------------------------------------------------------------
{
	return true
} 
;------------------------------------------------------------


;------------------------------------------------------------
AdjustColumnsWidth:
;------------------------------------------------------------

Loop, % LV_GetCount("Column")
	LV_ModifyCol(A_Index, "AutoHdr") ; adjust column width

/*
FOLLOWING NOT REQUIRED ANYMORE
when using option AutoHdr ("If applied to the last column, it will be made at least as wide as all the remaining space in the ListView.")

; See http://www.autohotkey.com/board/topic/6073-get-listview-column-width-with-sendmessage/
Loop, %intNbColAuto%
{
	intColZeroBased := A_Index - 1 ; column index, zero-based
	SendMessage, 0x1000+29, %intColZeroBased%, 0, SysListView321, ahk_id %g_strAppHwnd%
	intColSum += ErrorLevel ; column width
}

LV_ModifyCol(intNbColAuto + 1, g_intListW - intColSum - 21) ; adjust column width (-21 is for vertical scroll bar width)

intColSum := ""
*/

return
;------------------------------------------------------------


;------------------------------------------------------------
NextMenuShortcut(ByRef intShortcut)
;------------------------------------------------------------
{
	if (intShortcut < 10)
		strShortcut := intShortcut ; 0 .. 9
	else
		strShortcut := Chr(intShortcut + 55) ; Chr(10 + 55) = "A" .. Chr(35 + 55) = "Z"
	
	intShortcut := intShortcut + 1
	return strShortcut
}
;------------------------------------------------------------


;------------------------------------------------------------
IsInteger(str)
;------------------------------------------------------------
{
	if str is integer
		return true
	else
		return false
}
;------------------------------------------------------------


;------------------------------------------------------------
PathCombine(strAbsolutePath, strRelativePath)
; see http://www.autohotkey.com/board/topic/17922-func-relativepath-absolutepath/page-3#entry117355
; and http://stackoverflow.com/questions/29783202/combine-absolute-path-with-a-relative-path-with-ahk/
;------------------------------------------------------------
{
    VarSetCapacity(strCombined, (A_IsUnicode ? 2 : 1) * 260, 1) ; MAX_PATH
    DllCall("Shlwapi.dll\PathCombine", "UInt", &strCombined, "UInt", &strAbsolutePath, "UInt", &strRelativePath)
    Return, strCombined
}
;------------------------------------------------------------


;------------------------------------------------------------
UriEncode(str)
; from GoogleTranslate by Mikhail Kuropyatnikov
; http://www.autohotkey.net/~sumon/GoogleTranslate.ahk
; edited to encode also "@" see http://stackoverflow.com/questions/32341476/valid-url-for-an-ftp-site-with-username-containing/
;------------------------------------------------------------
{ 
   b_Format := A_FormatInteger 
   data := "" 
   SetFormat,Integer,H 
   SizeInBytes := StrPutVar(str,var,"utf-8")
   Loop, %SizeInBytes%
   {
   ch := NumGet(var,A_Index-1,"UChar")
   If (ch=0)
      Break
   if ((ch>0x7f) || (ch<0x30) || (ch=0x3d) || (ch=0x40))
      s .= "%" . ((StrLen(c:=SubStr(ch,3))<2) ? "0" . c : c)
   Else
      s .= Chr(ch)
   }   
   SetFormat,Integer,%b_format% 
   return s 
} 
;------------------------------------------------------------


;------------------------------------------------------------
StrPutVar(string, ByRef var, encoding)
;------------------------------------------------------------
{
    ; Ensure capacity.
    SizeInBytes := VarSetCapacity( var, StrPut(string, encoding)
        ; StrPut returns char count, but VarSetCapacity needs bytes.
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
    ; Copy or convert the string.
    StrPut(string, &var, encoding)
   Return SizeInBytes 
}
;------------------------------------------------------------


