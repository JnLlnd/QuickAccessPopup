;===============================================
/*

Quick Access Popup
Written using AutoHotkey_L v1.1.09.03+ (http://ahkscript.org/)
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

TO-DO

LATER
-----
HELP
* Update links to QAP website in Help
* Update links to QAP reviews in Donate

LANGUAGE
* Replace or update occurences of "FoldersPopup" in language files

GUI
* update CleanUpBeforeExit to save current position

QAP FEATURES MENUS
* Does not support Folders in Explorer and Group menus for TC and FPc users

Version 6.0.2 alpha (2015-05-??)


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
^^^^^^^^^^^^^^^^^ description of the variable content, with name section from general to specific

typeNameOfVariable
^^^^ type of variable, str for strings, int for integers (any size), dbl for reals (not used in this app),
     arr for arrays, obj for objects, menu for menus, etc.
  
g_typNameOfVariable
^ g_ for global, nothing for local

*/ 
;========================================================================================================================
; --- COMPILER DIRECTIVES ---
;========================================================================================================================

; Doc: http://fincs.ahk4.net/Ahk2ExeDirectives.htm
; Note: prefix comma with `

;@Ahk2Exe-SetName Quick Access Popup
;@Ahk2Exe-SetDescription Quick Access Popup - Freeware launcher for Windows.
;@Ahk2Exe-SetVersion 6.0.1 alpha
;@Ahk2Exe-SetOrigFilename QuickAccessPopup.exe


;========================================================================================================================
; INITIALIZATION
;========================================================================================================================

#NoEnv
#SingleInstance force
#KeyHistory 0
ListLines, Off
DetectHiddenWindows, On
ComObjError(False) ; we will do our own error handling

; avoid error message when shortcut destination is missing
; see http://ahkscript.org/boards/viewtopic.php?f=5&t=4477&p=25239#p25236
DllCall("SetErrorMode", "uint", SEM_FAILCRITICALERRORS := 1)

; By default, the A_WorkingDir is A_ScriptDir.
; When the shortcut is created by Inno Setup, the working is set to the folder under {userappdata}.
; In portable mode, the user can set the working directory in his own Windows shortcut.
; If user enable "Run at startup", the "Start in:" shortcut option is set to the current A_WorkingDir.

; If A_WorkingDir equals A_ScriptDir and the file _do_not_remove_or_rename.txt is found in A_WorkingDir
; it means that QAP has been installed with the setup program but that it was launched directly in the
; Program Files directory instead of using the Start menu or Startup shortcuts. In this situation, we
; know that the working directory has not been set properly. The following lines will fix it.
if (A_WorkingDir = A_ScriptDir) and FileExist(A_WorkingDir . "\_do_not_remove_or_rename.txt")
	SetWorkingDir, %A_AppData%\QuickAccessPopup

; Force A_WorkingDir to A_ScriptDir if uncomplied (development environment)
;@Ahk2Exe-IgnoreBegin
; Start of code for development environment only - won't be compiled
; see http://fincs.ahk4.net/Ahk2ExeDirectives.htm
SetWorkingDir, %A_ScriptDir%
; to test user data directory: SetWorkingDir, %A_AppData%\QuickAccessPopup

ListLines, On
; / End of code for developement enviuronment only - won't be compiled
;@Ahk2Exe-IgnoreEnd

OnExit, CleanUpBeforeExit ; must be positioned before InitFileInstall to ensure deletion of temporary files

Gosub, InitFileInstall

Gosub, InitLanguageVariables

; --- Global variables

g_strAppNameFile := "QuickAccessPopup"
g_strAppNameText := "Quick Access Popup"
g_strCurrentVersion := "6.0.1" ; "major.minor.bugs" or "major.minor.beta.release"
g_strCurrentBranch := "alpha" ; "prod", "beta" or "alpha", always lowercase for filename
g_strAppVersion := "v" . g_strCurrentVersion . (g_strCurrentBranch <> "prod" ? " " . g_strCurrentBranch : "")

g_blnDiagMode := False
g_strDiagFile := A_WorkingDir . "\" . g_strAppNameFile . "-DIAG.txt"
g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . ".ini"

g_blnMenuReady := false

g_objMenuInGui := Object() ; object of menu currently in Gui
g_objMenuIndex := Object() ; index of menu path used in Gui menu dropdown list
g_arrSubmenuStack := Object()
g_arrSubmenuStackPosition := Object()

g_objIconsFile := Object()
g_objIconsIndex := Object()

g_strMenuPathSeparator := ">"
g_strGuiMenuSeparator := "----------------"
g_strGuiMenuColumnBreak := "==="

g_objGuiControls := Object()

g_strMouseButtons := ""
g_arrMouseButtons := ""
g_arrMouseButtonsText := ""

g_objClassIdOrPathByDefaultName := Object() ; used by InitSpecialFolders and CollectExplorers
g_objSpecialFolders := Object()
g_strSpecialFoldersList := ""

g_blnUseDirectoryOpus := ""
g_blnUseTotalCommander := ""
g_blnUseFPconnect := ""
g_strDirectoryOpusRtPath := ""
g_strFPconnectPath := ""
g_strFPconnectAppFilename := ""
g_strFPconnectTargetFilename := ""



; if the app runs from a zip file, the script directory is created under the system Temp folder
if InStr(A_ScriptDir, A_Temp) ; must be positioned after g_strAppNameFile is created
{
	Oops(lOopsZipFileError, g_strAppNameFile)
	ExitApp
}

;@Ahk2Exe-IgnoreBegin
; Start of code for developement environment only - won't be compiled
if (A_ComputerName = "JEAN-PC") ; for my home PC
	g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . "-HOME.ini"
else if InStr(A_ComputerName, "STIC") ; for my work hotkeys
	g_strIniFile := A_WorkingDir . "\" . g_strAppNameFile . "-WORK.ini"
; / End of code for developement environment only - won't be compiled
;@Ahk2Exe-IgnoreEnd

; Keep gosubs in this order
Gosub, InitSystemArrays
Gosub, InitLanguages
Gosub, InitLanguageArrays
Gosub, InitSpecialFolders
Gosub, InitGuiControls
Gosub, LoadIniFile

###_D(1) ; ### REMOVE WHEN SCRIOPT PERSISTENT
ExitApp ; ### REMOVE WHEN SCRIOPT PERSISTENT

return


;========================================================================================================================
; INITIALIZATION
;========================================================================================================================

;-----------------------------------------------------------
InitFileInstall:
;-----------------------------------------------------------

g_strTempDir := A_WorkingDir . "\_temp"
FileCreateDir, %g_strTempDir%

FileInstall, FileInstall\QuickAccessPopup_LANG_DE.txt, %g_strTempDir%\QuickAccessPopup_LANG_DE.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_FR.txt, %g_strTempDir%\QuickAccessPopup_LANG_FR.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_NL.txt, %g_strTempDir%\QuickAccessPopup_LANG_NL.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_KO.txt, %g_strTempDir%\QuickAccessPopup_LANG_KO.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_SV.txt, %g_strTempDir%\QuickAccessPopup_LANG_SV.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_IT.txt, %g_strTempDir%\QuickAccessPopup_LANG_IT.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_ES.txt, %g_strTempDir%\QuickAccessPopup_LANG_ES.txt, 1
FileInstall, FileInstall\QuickAccessPopup_LANG_PT-BR.txt, %g_strTempDir%\QuickAccessPopup_LANG_PT-BR.txt, 1

FileInstall, FileInstall\default_browser_icon.html, %g_strTempDir%\default_browser_icon.html, 1

FileInstall, FileInstall\about-32.png, %g_strTempDir%\about-32.png
FileInstall, FileInstall\add_property-48.png, %g_strTempDir%\add_property-48.png
FileInstall, FileInstall\delete_property-48.png, %g_strTempDir%\delete_property-48.png
FileInstall, FileInstall\channel_mosaic-48.png, %g_strTempDir%\channel_mosaic-48.png
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

; Hotkeys: ini names, hotkey variables name, default values, gosub label and Gui hotkey titles
strHotkeyNames := "LaunchHotkeyMouse|LaunchHotkeyKeyboard|NavigateHotkeyMouse|NavigateHotkeyKeyboard|PowerHotkeyMouse|PowerHotkeyKeyboard|SettingsHotkey"
StringSplit, g_arrHotkeyNames, strHotkeyNames, |
strHotkeyDefaults := "MButton|#a|+MButton|+#a|!MButton|!#a|+^s"
StringSplit, g_arrHotkeyDefaults, strHotkeyDefaults, |

g_strMouseButtons := "None|LButton|MButton|RButton|XButton1|XButton2|WheelUp|WheelDown|WheelLeft|WheelRight|"
; leave last | to enable default value on the last item
StringSplit, g_arrMouseButtons, g_strMouseButtons, |

; Icon files and index tested on Win 7 and Win 8.1. Not tested on Win 10.
strIconsMenus := "lMenuDesktop|lMenuDocuments|lMenuPictures|lMenuMyComputer|lMenuNetworkNeighborhood|lMenuControlPanel|lMenuRecycleBin"
	. "|menuRecentFolders|menuGroupDialog|menuGroupExplorer|lMenuSpecialFolders|lMenuGroup|lMenuFoldersInExplorer"
	. "|lMenuRecentFolders|lMenuSettings|lMenuAddThisFolder|lDonateMenu|Submenu|Network|UnknownDocument|Folder"
	. "|menuGroupSave|menuGroupLoad|lMenuDownloads|Templates|MyMusic|MyVideo|History|Favorites|Temporary|Winver"
	. "|Fonts|Application|Clipboard"
strIconsFile := "imageres|imageres|imageres|imageres|imageres|imageres|imageres"
			. "|imageres|imageres|imageres|imageres|shell32|imageres"
			. "|imageres|imageres|imageres|imageres|shell32|imageres|shell32|shell32"
			. "|shell32|shell32|imageres|shell32|imageres|imageres|shell32|shell32|shell32|winver"
			. "|shell32|shell32|shell32"
strIconsIndex := "106|189|68|105|115|23|50"
			. "|113|176|203|203|99|176"
			. "|113|110|217|208|298|29|1|4"
			. "|297|46|176|55|104|179|240|87|153|1"
			. "|39|304|261"

StringSplit, arrIconsFile, strIconsFile, |
StringSplit, arrIconsIndex, strIconsIndex, |

Loop, Parse, strIconsMenus, |
{
	g_objIconsFile[A_LoopField] := A_WinDir . "\System32\" . arrIconsFile%A_Index% . (arrIconsFile%A_Index% = "winver" ? ".exe" : ".dll")
	g_objIconsIndex[A_LoopField] := arrIconsIndex%A_Index%
}
; example: g_objIconsFile["lMenuPictures"] and g_objIconsIndex["lMenuPictures"]

strHotkeyNames := ""
strHotkeyDefaults := ""
strIconsMenus := ""
strIconsFile := ""
strIconsIndex := ""
arrIconsFile := ""
arrIconsIndex := ""

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
StringSplit, g_arrOptionsTitles, lOptionsTitles, |
strOptionsLanguageCodes := "EN|FR|DE|NL|KO|SV|IT|ES|PT-BR"
StringSplit, g_arrOptionsLanguageCodes, strOptionsLanguageCodes, |
StringSplit, g_arrOptionsLanguageLabels, lOptionsLanguageLabels, |

loop, %g_arrOptionsLanguageCodes0%
	if (g_arrOptionsLanguageCodes%A_Index% = g_strLanguageCode)
		{
			g_strLanguageLabel := g_arrOptionsLanguageLabels%A_Index%
			break
		}

lOptionsMouseButtonsText := lOptionsMouseNone . "|" . lOptionsMouseButtonsText ; use lOptionsMouseNone because this is displayed
StringSplit, g_arrMouseButtonsText, lOptionsMouseButtonsText, |

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
/*
NOTES
- Total Commander commands: cm_OpenDesktop (2121), cm_OpenDrives (2122), cm_OpenControls (2123), cm_OpenFonts (2124), cm_OpenNetwork (2125), cm_OpenPrinters (2126), cm_OpenRecycled (2127)
- DOpus see http://resource.dopus.com/viewtopic.php?f=3&t=23691
*/

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
	; OK     OK      OK     OK     OK      OK
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
	, lMenuFonts, "Fonts"
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
InitSpecialFolderObject("{7be9d83c-a729-4d97-b5a7-1b7313c39e0a}", "", -1, "A_Programs", "programs", ""
	, lMenuProgramsFolderStartMenu, "" ; Menu D�marrer / Programmes (Menu Start/Programs)
	, "CLS", "CLS", "NEW", "AHK", "DOA", "AHK", "AHK")
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
	, lMenuDownloads, "lMenuDownloads"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Music
InitSpecialFolderObject(strException, "", -1, "", "mymusic", ""
	, lMenuMyMusic, "MyMusic"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Video
InitSpecialFolderObject(strException, "", -1, "", "myvideos", ""
	, lMenuMyVideo, "MyVideo"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Templates
InitSpecialFolderObject(strException, "", -1, "", "templates", ""
	, lMenuTemplates, "Templates"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, g_strMyPicturesPath, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, My Pictures
InitSpecialFolderObject(g_strMyPicturesPath, "", 39, "", "mypictures", ""
	, lMenuPictures, "lMenuPictures"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
RegRead, strException, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Favorites
InitSpecialFolderObject(strException, "", -1, "", "", ""
	, lMenuFavoritesInternet, "Favorites"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")

;---------------------
; Path under %APPDATA% (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Start Menu", "", -1, "A_StartMenu", "start", ""
	, lMenuStartMenu, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup", "", -1, "A_Startup", "startup", ""
	, lMenuStartup, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%", "", -1, "A_AppData", "appdata", ""
	, lMenuAppData, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Recent", "", -1, "", "recent", ""
	, lMenuRecentItems, "menuRecentFolders"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Windows\Cookies", "", -1, "", "cookies", ""
	, lMenuCookies, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\Internet Explorer\Quick Launch", "", -1, "", "", ""
	, lMenuQuickLaunch, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")
InitSpecialFolderObject("%APPDATA%\Microsoft\SystemCertificates", "", -1, "", "", ""
	, lMenuSystemCertificates, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")

;---------------------
; Path under other environment variables (no CLSID), localized name and icon provided, no Shell Command - to be tested with DOpus, TC and FPc

InitSpecialFolderObject("%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu", "", -1, "A_StartMenuCommon", "commonstartmenu", ""
	, lMenuCommonStartMenu, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup", "", -1, "A_StartupCommon", "commonstartup", ""
	, lMenuCommonStartupMenu, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ALLUSERSPROFILE%", "", -1, "A_AppDataCommon", "commonappdata", ""
	, lMenuCommonAppData, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%LOCALAPPDATA%\Microsoft\Windows\Temporary Internet Files", "", -1, "", "", ""
	, lMenuCache, "Temporary"
	, "CLS", "CLS", "CLS", "CLS", "CLS", "CLS", "CLS")
InitSpecialFolderObject("%LOCALAPPDATA%\Microsoft\Windows\History", "", -1, "", "history", ""
	, lMenuHistory, "History"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%ProgramFiles%", "", -1, "A_ProgramFiles", "programfiles", ""
	, lMenuProgramFiles, "Folder"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
if (A_Is64bitOS)
	InitSpecialFolderObject("%ProgramFiles(x86)%", "", -1, "", "programfilesx86", ""
		, lMenuProgramFiles . " (x86)", "Folder"
		, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject("%PUBLIC%\Libraries", "", -1, "", "", ""
	, lMenuPublicLibraries, "Folder"
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
	, lMenuDesktop, "lMenuDesktop"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "TCC", "CLS")
InitSpecialFolderObject(A_DesktopCommon, "", -1, "A_DesktopCommon", "commondesktopdir", ""
	, lMenuCommonDesktop, "lMenuDesktop"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject(A_Temp, "", -1, "A_Temp", "temp", ""
	, lMenuTemporaryFiles, "Temporary"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")
InitSpecialFolderObject(A_WinDir, "", -1, "A_WinDir", "windows", ""
	, "Windows", "Winver"
	, "CLS", "CLS", "CLS", "CLS", "DOA", "CLS", "CLS")

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

; Special Folder Object definition:
;		ClassIdOrPath: key to access one Special Folder object (example: g_objSpecialFolders[strClassIdOrPath]
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
    /*
        Question: What's the best Registry key should I use for this to work on Win 7, 8+ ?
		
        HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}
        HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}
        HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}
        HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Wow6432Node\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}
        HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}
		
		Seems to be HKEY_CLASSES_ROOT for XP compatibility accorging to
		http://msdn.microsoft.com/en-us/library/windows/desktop/ms724475(v=vs.85).aspx
		But what if XP support is not needed in QAP?
		
		See: http://superuser.com/questions/916401/registry-keys-for-clsid-info
    */
    RegRead, strLocalizedString, HKEY_CLASSES_ROOT, CLSID\%strClassId%, LocalizedString
    ; strLocalizedString example: "@%SystemRoot%\system32\shell32.dll,-9216"

    StringSplit, arrLocalizedString, strLocalizedString, `,
    intDllNameStart := InStr(arrLocalizedString1, "\", , 0)
    StringRight, strDllFile, arrLocalizedString1, % StrLen(arrLocalizedString1) - intDllNameStart
    strDllIndex := arrLocalizedString2
    strTranslatedName := TranslateMUI(strDllFile, Abs(strDllIndex))
    
    /*
    MsgBox, % ""
        . "strClassId: " . strClassId . "`n"
        . "strLocalizedString: " . strLocalizedString . "`n"
        . "strDllFile: " . strDllFile . "`n"
        . "strDllIndex: " . strDllIndex . "`n"
        . "strTranslatedName: " . strTranslatedName . "`n"
    */
    
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
InitGuiControls:
;------------------------------------------------------------

; Order of controls important to avoid drawgins gliches when resizing

InsertGuiControlPos("lnkGuiDropHelpClicked",	 -88, -130)
InsertGuiControlPos("lnkGuiHotkeysHelpClicked",	  40, -130)

InsertGuiControlPos("picGuiOptions",			 -44,   10, true) ; true = center
InsertGuiControlPos("picGuiAddFavorite",		 -44,  122, true)
InsertGuiControlPos("picGuiEditFavorite",		 -44,  199, true)
InsertGuiControlPos("picGuiRemoveFavorite",		 -44,  274, true)
InsertGuiControlPos("picGuiGroupsManage",		 -44, -150, true, true) ; true = center, true = draw
InsertGuiControlPos("picGuiDonate",				  50,  -62, true, true)
InsertGuiControlPos("picGuiHelp",				 -44,  -62, true, true)
InsertGuiControlPos("picGuiAbout",				-104,  -62, true, true)

InsertGuiControlPos("picAddColumnBreak",		  10,  230)
InsertGuiControlPos("picAddSeparator",			  10,  200)
InsertGuiControlPos("picMoveFavoriteDown",		  10,  170)
InsertGuiControlPos("picMoveFavoriteUp",		  10,  140)
InsertGuiControlPos("picPreviousMenu",			  10,   84)
InsertGuiControlPos("picSortFavorites",			  10, -165)
InsertGuiControlPos("picUpMenu",				  25,   84)

InsertGuiControlPos("btnGuiSave",				   0,  -90, , true)				
InsertGuiControlPos("btnGuiCancel",				   0,  -90, , true)

InsertGuiControlPos("drpMenusList",				  40,   84)

InsertGuiControlPos("lblGuiDonate",				  50,  -20, true)
InsertGuiControlPos("lblGuiAbout",				-104,  -20, true)
InsertGuiControlPos("lblGuiHelp",				 -44,  -20, true)
InsertGuiControlPos("lblAppName",				  10,   10)
InsertGuiControlPos("lblAppTagLine",			  10,   42)
InsertGuiControlPos("lblGuiAddFavorite",		 -44,  172, true)
InsertGuiControlPos("lblGuiEditFavorite",		 -44,  249, true)
InsertGuiControlPos("lblGuiOptions",			 -44,   45, true)
InsertGuiControlPos("lblGuiRemoveFavorite",		 -44,  324, true)
InsertGuiControlPos("lblSubmenuDropdownLabel",	  40,   66)
InsertGuiControlPos("lblGuiGroupsManage",		 -44,  -95, true)

InsertGuiControlPos("lvFavoritesList",			  40,  115)

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
;-----------------------------------------------------------

; create a backup of the ini file before loading
StringReplace, strIniBackupFile, g_strIniFile, .ini, -backup.ini
FileCopy, %g_strIniFile%, %strIniBackupFile%, 1

; reinit after Settings save if already exist
g_objMenuInGui := Object() ; object of menu currently in Gui
g_objMenuIndex := Object() ; index of menu path used in Gui menu dropdown list
g_objMainMenu := Object() ; object of menu structure entry point
g_objMainMenu.MenuPath := "Main" ; localized name of the main menu

IfNotExist, %g_strIniFile%
{
	strLaunchHotkeyMouseDefault := g_arrHotkeyDefaults1 ; "MButton"
	strLaunchHotkeyKeyboard := g_arrHotkeyDefaults2 ; "#a"
	strNavigateHotkeyMouseDefault := g_arrHotkeyDefaults3 ; "+MButton"
	strNavigateHotkeyKeyboardDefault := g_arrHotkeyDefaults4 ; "+#a"
	strPowerHotkeyMouseDefault := g_arrHotkeyDefaults5 ; "!MButton"
	strPowerHotkeyKeyboardDefault := g_arrHotkeyDefaults6 ; "!#a"
	strSettingsHotkeyDefault := g_arrHotkeyDefaults7 ; "+^s"
	
	g_intIconSize := 24
	
	FileAppend,
		(LTrim Join`r`n
			[Global]
			LaunchHotkeyMouse=%strLaunchHotkeyMouseDefault%
			LaunchHotkeyKeyboard=%strLaunchHotkeyKeyboardDefault%
			NavigateHotkeyMouseDefault=%strNavigateHotkeyMouseDefault%
			NavigateHotkeyKeyboardDefault=%strNavigateHotkeyKeyboardDefault%
			PowerHotkeyMouseDefault=%strPowerHotkeyMouseDefault%
			PowerHotkeyKeyboardDefault=%strPowerHotkeyKeyboardDefault%
			SettingsHotkey=%strSettingsHotkeyDefault%
			DisplayTrayTip=1
			DisplayIcons=1
			RecentFolders=10
			DisplayMenuShortcuts=0
			PopupMenuPosition=1
			PopupFixPosition=20,20
			DiagMode=0
			Startups=1
			LanguageCode=%g_strLanguageCode%
			DirectoryOpusPath=
			IconSize=%g_intIconSize%
			OpenMenuOnTaskbar=1
			[Favorites]
			Favorite1=F|C:\|C:\
			Favorite2=F|Windows|%A_WinDir%
			Favorite3=F|Program Files|%A_ProgramFiles%
			Favorite4=F|User Profile|`%USERPROFILE`%
			Favorite5=A|Notepad|%A_WinDir%\system32\notepad.exe
			Favorite6=U|%g_strAppNameText% web site|http://www.QuickAccessPopup.com


)
		, %g_strIniFile%
}

Gosub, LoadIniHotkeys

IniRead, g_blnDisplayTrayTip, %g_strIniFile%, Global, DisplayTrayTip, 1
IniRead, g_blnDisplayIcons, %g_strIniFile%, Global, DisplayIcons, 1
g_blnDisplayIcons := (g_blnDisplayIcons and OSVersionIsWorkstation())
IniRead, g_blnDisplaySpecialMenusShortcuts, %g_strIniFile%, Global, DisplaySpecialMenusShortcuts, 1
IniRead, blnDisplayRecentFolders, %g_strIniFile%, Global, DisplayRecentFolders, 1
IniRead, blnDisplayFoldersInExplorerMenu, %g_strIniFile%, Global, DisplayFoldersInExplorerMenu, 1
IniRead, blnDisplayGroupMenu, %g_strIniFile%, Global, DisplaySwitchMenu, 1 ; keep "Switch" in label instead of "Group" for backward compatibility
IniRead, blnDisplayClipboardMenu, %g_strIniFile%, Global, DisplayClipboardMenu, 1
IniRead, blnDisplayCopyLocationMenu, %g_strIniFile%, Global, DisplayCopyLocationMenu, 1
IniRead, g_intPopupMenuPosition, %g_strIniFile%, Global, PopupMenuPosition, 1
IniRead, strPopupFixPosition, %g_strIniFile%, Global, PopupFixPosition, 20,20
StringSplit, g_arrPopupFixPosition, strPopupFixPosition, `,
IniRead, g_blnDisplayMenuShortcuts, %g_strIniFile%, Global, DisplayMenuShortcuts, 0
IniRead, g_blnDiagMode, %g_strIniFile%, Global, DiagMode, 0
IniRead, g_intRecentFolders, %g_strIniFile%, Global, RecentFolders, 10
IniRead, g_intIconSize, %g_strIniFile%, Global, IconSize, 24
IniRead, g_strGroups, %g_strIniFile%, Global, Groups, %A_Space% ; empty string if not found
IniRead, g_blnCheck4Update, %g_strIniFile%, Global, Check4Update, 1
IniRead, g_blnOpenMenuOnTaskbar, %g_strIniFile%, Global, OpenMenuOnTaskbar, 1
IniRead, g_blnRememberSettingsPosition, %g_strIniFile%, Global, RememberSettingsPosition, 1

IniRead, g_blnDonor, %g_strIniFile%, Global, Donor, 0 ; Please, be fair. Don't cheat with this.

IniRead, g_strDirectoryOpusPath, %g_strIniFile%, Global, DirectoryOpusPath, %A_Space% ; empty string if not found
IniRead, g_blnDirectoryOpusUseTabs, %g_strIniFile%, Global, DirectoryOpusUseTabs, 1 ; use tabs by default
if StrLen(g_strDirectoryOpusPath)
{
	g_blnUseDirectoryOpus := FileExist(g_strDirectoryOpusPath)
	if (g_blnUseDirectoryOpus)
		Gosub, SetDOpusRt
	else
		if (g_strDirectoryOpusPath <> "NO")
			Oops(lOopsWrongThirdPartyPath, "Directory Opus", g_strDirectoryOpusPath, lOptionsThirdParty)
}
else
	if (g_strDirectoryOpusPath <> "NO")
		Gosub, CheckDirectoryOpus

IniRead, g_strTotalCommanderPath, %g_strIniFile%, Global, TotalCommanderPath, %A_Space% ; empty string if not found
IniRead, g_blnTotalCommanderUseTabs, %g_strIniFile%, Global, TotalCommanderUseTabs, 1 ; use tabs by default
if StrLen(g_strTotalCommanderPath)
{
	g_blnUseTotalCommander := FileExist(g_strTotalCommanderPath)
	if (g_blnUseTotalCommander)
		Gosub, SetTCCommand
	else
		if (g_strTotalCommanderPath <> "NO")
			Oops(lOopsWrongThirdPartyPath, "Total Commander", g_strTotalCommanderPath, lOptionsThirdParty)
}
else
	if (g_strTotalCommanderPath <> "NO")
		Gosub, CheckTotalCommander

IniRead, g_strFPconnectPath, %g_strIniFile%, Global, FPconnectPath, %A_Space% ; empty string if not found
if StrLen(g_strFPconnectPath)
{
	g_blnUseFPconnect := FileExist(g_strFPconnectPath)
	if (g_blnUseFPconnect)
		Gosub, SetFPconnect
	else
		if (g_strFPconnectPath <> "NO")
			Oops(lOopsWrongThirdPartyPath, "FPconnect", g_strFPconnectPath, lOptionsThirdParty)
}
else
	if (g_strFPconnectPath <> "NO")
		Gosub, CheckFPconnect

IniRead, g_strTheme, %g_strIniFile%, Global, Theme
if (g_strTheme = "ERROR") ; if Theme not found, we have a new ini file - add the themes to the ini file
{
	g_strTheme := "Windows"
	g_strAvailableThemes := "Windows|Grey|Light Blue|Light Green|Light Red|Yellow"
	IniWrite, %g_strTheme%, %g_strIniFile%, Global, Theme
	IniWrite, %g_strAvailableThemes%, %g_strIniFile%, Global, AvailableThemes
	FileAppend,
		(LTrim Join`r`n
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
else
{
	IniRead, g_strAvailableThemes, %g_strIniFile%, Global, AvailableThemes
	if !InStr(g_strAvailableThemes, "Windows|")
	{
		g_strAvailableThemes := "Windows|" . g_strAvailableThemes
		IniWrite, %g_strAvailableThemes%, %g_strIniFile%, Global, AvailableThemes
	}
}
g_blnUseColors := (g_strTheme <> "Windows")
	
IniRead, blnMySystemFoldersBuilt, %g_strIniFile%, Global, MySystemFoldersBuilt, 0 ; default false
; ### if !(blnMySystemFoldersBuilt) and (A_OSVersion <> "WIN_XP")
; 	Gosub, AddToIniMySystemFoldersMenu ; modify the ini file Folders section before reading it

Loop
{
	IniRead, strLoadIniLine, %g_strIniFile%, Favorites, Favorite%A_Index%
	if (strLoadIniLine = "ERROR")
		Break
	strLoadIniLine := strLoadIniLine . "|||" ; additional "|" to make sure we have all empty items
	; 1 FavoriteName, 2 FavoriteLocation, 3 MenuName, 4 SubmenuFullName, 5 FavoriteType, 6 IconResource, 7 AppArguments, 8 AppWorkingDir
	StringSplit, arrThisFavorite, strLoadIniLine, |

	objLoadIniFavorite := Object() ; new menu item
	objLoadIniFavorite.FavoriteName := arrThisFavorite1 ; display name of this menu item
	objLoadIniFavorite.FavoriteLocation := arrThisFavorite2 ; path for this menu item
	objLoadIniFavorite.MenuName := lMainMenuName . arrThisFavorite3 ; parent menu of this menu item, adding main menu name

	if StrLen(arrThisFavorite4)
		objLoadIniFavorite.SubmenuFullName := lMainMenuName . arrThisFavorite4 ; full name of the submenu, adding main menu name
	else
		objLoadIniFavorite.SubmenuFullName := ""
	
	if StrLen(arrThisFavorite5)
		
		objLoadIniFavorite.FavoriteType := arrThisFavorite5 ; "F" folder, "D" document, "U" URL or "S" submenu
		
	else ; for upward compatibility from v1 and v2 ini files
		if StrLen(objLoadIniFavorite.SubmenuFullName)
			objLoadIniFavorite.FavoriteType := "S" ; "S" submenu
		else ; for upward compatibility from v1 ini files
			objLoadIniFavorite.FavoriteType := "F" ; "F" folder

	objLoadIniFavorite.IconResource := arrThisFavorite6 ; icon resource in format "iconfile,iconindex"
	objLoadIniFavorite.AppArguments := arrThisFavorite7 ; application arguments
	objLoadIniFavorite.AppWorkingDir := arrThisFavorite8 ; application working directory

	if (objLoadIniFavorite.FavoriteType = "S") ; then this is a new submenu
	{
		arrSubMenu := Object() ; create submenu
		g_arrMenus.Insert(objLoadIniFavorite.SubmenuFullName, arrSubMenu) ; add this submenu to the array of menus
	}
	g_arrMenus[objLoadIniFavorite.MenuName].Insert(objLoadIniFavorite) ; add this menu item to parent menu
}

IfNotExist, %g_strIniFile%
{
	Oops(lOopsWriteProtectedError, g_strAppNameText)
	ExitApp
}

strIniBackupFile := ""
arrMainMenu := ""
strPopupHotkeyMouseDefault := ""
strPopupHotkeyMouseNewDefault := ""
strPopupHotkeyKeyboardDefault := ""
strPopupHotkeyKeyboardNewDefault := ""
strSettingsHotkeyDefault := ""
strFoldersInExplorerHotkeyDefault := ""
strGroupsHotkeyDefault := ""
strRecentsHotkeyDefault := ""
strClipboardHotkeyDefault := ""
strPopupFixPosition := ""
blnMySystemFoldersBuilt := ""
strLoadIniLine := ""
arrThisFavorite := ""
objLoadIniFavorite := ""
arrSubMenu := ""

return
;------------------------------------------------------------


;-----------------------------------------------------------
LoadIniHotkeys:
;-----------------------------------------------------------

strHotkeyNoneModifiers := ">^!+#" ; right-control/atl/shift/windows impossible keys combination
strHotkeyNoneKey := "9"

; Read the values and set hotkey shortcuts
loop, % g_arrHotkeyNames%0%
{
	; Prepare global arrays used by SplitHotkey function
	IniRead, arrHotkeys%A_Index%, %g_strIniFile%, Global, % g_arrHotkeyNames%A_Index%, % g_arrHotkeyDefaults%A_Index%
	SplitHotkey(arrHotkeys%A_Index%, strModifiers%A_Index%, strOptionsKey%A_Index%, strMouseButton%A_Index%, strMouseButtonsWithDefault%A_Index%)
	; example: Hotkey, $MButton, LaunchHotkeyMouse
	
	###_D("g_arrHotkeyDefaults%A_Index%: " . g_arrHotkeyDefaults%A_Index% . "`n"
		. "arrHotkeys%A_Index%: " . arrHotkeys%A_Index% . "`n"
		. "g_arrHotkeyNames%A_Index%: " . g_arrHotkeyNames%A_Index% . "`n"
		. "")
	if (arrHotkeys%A_Index% = "None") ; do not compare with lOptionsMouseNone because it is translated
		Hotkey, % "$" . strHotkeyNoneModifiers . strHotkeyNoneKey, % g_arrHotkeyNames%A_Index%, On UseErrorLevel
	else
		Hotkey, % "$" . arrHotkeys%A_Index%, % g_arrHotkeyNames%A_Index%, On UseErrorLevel
	if (ErrorLevel)
		Oops(lDialogInvalidHotkey, Hotkey2Text(strModifiers%A_Index%, strMouseButton%A_Index%, strOptionsKey%A_Index%), g_strAppNameText, g_arrOptionsTitles%A_Index%)
}

arrHotkeys := ""
strHotkeyNoneModifiers := ""
strHotkeyNoneKey := ""

return
;------------------------------------------------------------


;-----------------------------------------------------------
CleanUpBeforeExit:
;-----------------------------------------------------------

FileRemoveDir, %g_strTempDir%, 1 ; Remove all files and subdirectories

if (g_blnDiagMode)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDiagModeExit, g_strAppNameText, g_strDiagFile) . "`n`n" . lDiagModeIntro . "`n`n" . lDiagModeSee
	IfMsgBox, Yes
		Run, %g_strDiagFile%
}
ExitApp
;-----------------------------------------------------------



;========================================================================================================================
; END OF INITIALIZATION
;========================================================================================================================



;========================================================================================================================
; POPUP MENU
;========================================================================================================================

LaunchHotkeyMouse:
LaunchHotkeyKeyboard:
return


NavigateHotkeyMouse:
NavigateHotkeyKeyboard:
return


PowerHotkeyMouse:
PowerHotkeyKeyboard:
return


SettingsHotkey:
return


;========================================================================================================================
; END OF POPUP MENU
;========================================================================================================================



;========================================================================================================================
; THIRD-PARTY
;========================================================================================================================


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


;------------------------------------------------------------
CheckDirectoryOpus:
;------------------------------------------------------------

g_strCheckDirectoryOpusPath := A_ProgramFiles . "\GPSoftware\Directory Opus\dopus.exe"

if FileExist(g_strCheckDirectoryOpusPath)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDialogThirdPartyDetected, g_strAppNameText, "Directory Opus")
	IfMsgBox, No
		g_strDirectoryOpusPath := "NO"
	else
	{
		g_strDirectoryOpusPath := g_strCheckDirectoryOpusPath
		Gosub, SetDOpusRt
	}
	g_blnUseDirectoryOpus := (g_strDirectoryOpusPath <> "NO")
	IniWrite, %g_strDirectoryOpusPath%, %g_strIniFile%, Global, DirectoryOpusPath
	g_blnDirectoryOpusUseTabs := 1
	IniWrite, %g_blnDirectoryOpusUseTabs%, %g_strIniFile%, Global, DirectoryOpusUseTabs
	; g_strDirectoryOpusNewTabOrWindow will contain "NEWTAB" to open in a new tab if DirectoryOpusUseTabs is 1 (default) or "NEW" to open in a new lister
	g_strDirectoryOpusNewTabOrWindow := "NEWTAB"
}

return
;------------------------------------------------------------


;------------------------------------------------------------
SetDOpusRt:
;------------------------------------------------------------

IniRead, g_blnDirectoryOpusUseTabs, %g_strIniFile%, Global, DirectoryOpusUseTabs, 1 ; should be intialized here but true by default for safety
if (g_blnDirectoryOpusUseTabs)
	g_strDirectoryOpusNewTabOrWindow := "NEWTAB" ; open new folder in a new tab
else
	g_strDirectoryOpusNewTabOrWindow := "NEW" ; open new folder in a new lister

g_strDOpusTempFilePath := g_strTempDir . "\dopus-list.txt"
StringReplace, g_strDirectoryOpusRtPath, g_strDirectoryOpusPath, \dopus.exe, \dopusrt.exe

; additional icon for Directory Opus
g_objIconsFile["DirectoryOpus"] := g_strDirectoryOpusPath
g_objIconsIndex["DirectoryOpus"] := 1

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckTotalCommander:
;------------------------------------------------------------

strCheckTotalCommanderPath := GetTotalCommanderPath()

if FileExist(strCheckTotalCommanderPath)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDialogThirdPartyDetected, g_strAppNameText, "Total Commander")
	IfMsgBox, No
		g_strTotalCommanderPath := "NO"
	else
	{
		g_strTotalCommanderPath := strCheckTotalCommanderPath
		Gosub, SetTCCommand
	}
	g_blnUseTotalCommander := (g_strTotalCommanderPath <> "NO")
	IniWrite, %g_strTotalCommanderPath%, %g_strIniFile%, Global, TotalCommanderPath
	g_blnTotalCommanderUseTabs := 1
	IniWrite, %g_blnTotalCommanderUseTabs%, %g_strIniFile%, Global, TotalCommanderUseTabs
	; g_strTotalCommanderNewTabOrWindow will contain "/O /T" to open in a new tab if TotalCommanderUseTabs is 1 (default) or "/N" to open in a new file list
	g_strTotalCommanderNewTabOrWindow := "/O /T"
}

strCheckTotalCommanderPath := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
GetTotalCommanderPath()
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
SetTCCommand:
;------------------------------------------------------------

IniRead, g_blnTotalCommanderUseTabs, %g_strIniFile%, Global, TotalCommanderUseTabs, 1 ; should be intialized here but true by default for safety
if (g_blnTotalCommanderUseTabs)
	g_strTotalCommanderNewTabOrWindow := "/O /T" ; open new folder in a new tab
else
	g_strTotalCommanderNewTabOrWindow := "/N" ; open new folder in a new window (TC instance)

; additional icon for TotalCommander
g_objIconsFile["TotalCommander"] := g_strTotalCommanderPath
g_objIconsIndex["TotalCommander"] := 1

return
;------------------------------------------------------------


;------------------------------------------------------------
CheckFPconnect:
;------------------------------------------------------------

strCheckFPconnectPath := A_ScriptDir . "\FPconnect\FPconnect.exe"

if FileExist(strCheckFPconnectPath)
{
	MsgBox, 52, %g_strAppNameText%, % L(lDialogThirdPartyDetected, g_strAppNameText, "FPconnect")
	IfMsgBox, No
		g_strFPconnectPath := "NO"
	else
	{
		g_strFPconnectPath := strCheckFPconnectPath
		Gosub, SetFPconnect
	}
	g_blnUseFPconnect := (g_strFPconnectPath <> "NO")
	IniWrite, %g_strFPconnectPath%, %g_strIniFile%, Global, FPconnectPath
}

strCheckFPconnectPath := ""

return
;------------------------------------------------------------


;------------------------------------------------------------
SetFPconnect:
;------------------------------------------------------------

StringTrimRight, strFPconnectIniPath, g_strFPconnectPath, 4
strFPconnectIniPath := strFPconnectIniPath . ".ini"

IniRead, strFPconnectAppPathFilename, %strFPconnectIniPath%, Options, AppPath, %A_Space% ; empty by default
g_blnUseFPconnect := FileExist(EnvVars(strFPconnectAppPathFilename))

IniRead, strFPconnectTargetPathFilename, %strFPconnectIniPath%, Options, TargetPath, %A_Space% ; empty by default

if (g_blnUseFPconnect)
{
	strFPconnectAppPathFilename := EnvVars(strFPconnectAppPathFilename)
	SplitPath, strFPconnectAppPathFilename, g_strFPconnectAppFilename
	strFPconnectTargetPathFilename := EnvVars(strFPconnectTargetPathFilename)
	SplitPath, strFPconnectTargetPathFilename, g_strFPconnectTargetFilename
}
else
	Oops(lOopsWrongFPconnectAppPathFilename, g_strFPconnectPath, strFPconnectIniPath)

strFPconnectAppPathFilename := ""
strFPconnectTargetPathFilename := ""

return
;------------------------------------------------------------



;========================================================================================================================
; VARIOUS FUNCTIONS
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
	global g_strMouseButtons

	if (strHotkey = "None") ; do not compare with lOptionsMouseNone because it is translated
	{
		strMouseButton := "None" ; do not use lOptionsMouseNone because it is translated
		strKey := ""
		StringReplace, strMouseButtonsWithDefault, lOptionsMouseButtonsText, % lOptionsMouseNone . "|", % lOptionsMouseNone . "||" ; use lOptionsMouseNone because this is displayed
	}
	else 
	{
		SplitModifiersFromKey(strHotkey, strModifiers, strKey)
		if InStr(g_strMouseButtons, "|" . strKey . "|") ;  we have a mouse button
		{
			strMouseButton := strKey
			strKey := ""
			StringReplace, strMouseButtonsWithDefault, lOptionsMouseButtonsText, % GetText4MouseButton(strMouseButton) . "|", % GetText4MouseButton(strMouseButton) . "||" ; with default value
		}
		else ; we have a key
			strMouseButtonsWithDefault := lOptionsMouseButtonsText ; no default value
	}
}
;------------------------------------------------------------


;------------------------------------------------------------
Hotkey2Text(strModifiers, strMouseButton, strOptionKey, blnShort := false)
;------------------------------------------------------------
{
	if (strMouseButton = "None") ; do not compare with lOptionsMouseNone because it is translated
		str := lOptionsMouseNone ; use lOptionsMouseNone because this is displayed
	else
	{
		str := ""
		loop, parse, strModifiers
		{
			if (A_LoopField = "!")
				str := str . lOptionsAlt . "+"
			if (A_LoopField = "^")
				str := str . (blnShort ? lOptionsCtrlShort : lOptionsCtrl) . "+"
			if (A_LoopField = "+")
				str := str . lOptionsShift . "+"
			if (A_LoopField = "#")
				str := str . (blnShort ? lOptionsWinShort : lOptionsWin) . "+"
		}
		if StrLen(strMouseButton)
			str := str . GetText4MouseButton(strMouseButton)
		if StrLen(strOptionKey)
		{
			StringUpper, strOptionKey, strOptionKey
			str := str . strOptionKey
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
	global g_arrMouseButtons
	global g_arrMouseButtonsText
	
	loop, %g_arrMouseButtons0%
		if (strSource = g_arrMouseButtons%A_Index%)
			return g_arrMouseButtonsText%A_Index%
}
;------------------------------------------------------------


;------------------------------------------------------------
GetMouseButton4Text(strSource)
; Returns the string in g_arrMouseButtons at the same position of strSource in g_arrMouseButtonsText
;------------------------------------------------------------
{
	global g_arrMouseButtons
	global g_arrMouseButtonsText

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


