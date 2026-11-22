;===============================================
/*

QAPupdateIconsWin10

Update icons in favorites created with Quick Access Popup under Windows 7 to Windows 10 icons
Written using AutoHotkey_L v1.1.09.03+ (http://ahkscript.org/)
By Jean Lalonde (JnLlnd on AHKScript.org forum)

Version: 1.1 (2016-06-25)
- adapted to new icon file imageres.dll dated 2015-10-30 in Windows 10

Version: 1.0 (2016-06-21)
- first official release

Version: 0.1 (2016-05-25)
- first release

*/ 
;========================================================================================================================
; --- COMPILER DIRECTIVES ---
;========================================================================================================================

; Doc: http://fincs.ahk4.net/Ahk2ExeDirectives.htm
; Note: prefix comma with `

;@Ahk2Exe-SetName QAPupdateIconsWin10
;@Ahk2Exe-SetDescription Update QAP icons to Windows 10
;@Ahk2Exe-SetVersion 1.1
;@Ahk2Exe-SetOrigFilename QAPupdateIconsWin10.exe


;========================================================================================================================
; INITIALIZATION
;========================================================================================================================

#NoEnv
#SingleInstance force
#KeyHistory 0
ListLines, Off

;========================================================================================================================
; GET FILE
;========================================================================================================================

g_blnPortableMode := !FileExist(A_ScriptDir . "\_do_not_remove_or_rename.txt")
g_strIniFile := (g_blnPortableMode ? A_ScriptDir : A_AppData . "\Quick Access Popup")
FileSelectFile, g_strIniFile, , %g_strIniFile%, Update favorite icons from Windows 7 to Windows 10 - Select the Quick Acces Popup settings file to update, Ini file (*.ini)

if !StrLen(g_strIniFile)
	ExitApp

IniRead, blnUpdatedIconsWin10, %g_strIniFile%, Global, UpdatedIconsWin10, 0
if (blnUpdatedIconsWin10)
{
	MsgBox, 48, Settings file already updated, The settings file has already been updated:`n`n%g_strIniFile%
	ExitApp
}
else
{
	MsgBox, 1, Updating icons in Settings file, Selected settings file:`n%g_strIniFile%`n`nThis script will:`n`n1) BACKUP this settings file under the name:`n%g_strIniFile%-IconUpdate_BK`n`n2) UPDATE icon numbers from Windows 7 to Windows 10.`n`n3) SAVE the settings file.`n`nContinue?
	IfMsgBox, Cancel
		ExitApp
}

;========================================================================================================================
; BACKUP AND LOAD FILE
;========================================================================================================================

FileCopy, %g_strIniFile%, %g_strIniFile%-IconUpdate_BK, 1
FileRead, strIniContent, %g_strIniFile%

;========================================================================================================================
; EDIT FILE
;========================================================================================================================

StringReplace, strIniContent, strIniContent, imageres.dll`,203, imageres.dll`,204, All ; iconSpecialFolders
StringReplace, strIniContent, strIniContent, imageres.dll`,208, imageres.dll`,209, All ; iconDonate
StringReplace, strIniContent, strIniContent, shell32.dll`,297, shell32.dll`,299, All ; iconGroupSave
StringReplace, strIniContent, strIniContent, shell32.dll`,298, shell32.dll`,300, All ; iconSubmenu
StringReplace, strIniContent, strIniContent, shell32.dll`,301, shell32.dll`,319, All ; iconOptions
StringReplace, strIniContent, strIniContent, shell32.dll`,304, shell32.dll`,324, All ; iconApplication
StringReplace, strIniContent, strIniContent, shell32.dll`,305, shell32.dll`,325, All ; iconSwitch

; icons index over 224 in Win 10 file imageres.dll dated "20151030031815" must be increadesed by 3
FileGetTime, strWin10ImageresDate, %A_WinDir%\System32\imageres.dll
if (GetOsVersion() = "WIN_10") and (strWin10ImageresDate = "20151030031815") ; Win 10 "B" -> index +3
	StringReplace, strIniContent, strIniContent, imageres.dll`,217, imageres.dll`,310, All ; iconAddThisFolder
else ; "shell32" or Win 7 or Win 10 "A" ("20150710070017")
	StringReplace, strIniContent, strIniContent, imageres.dll`,217, imageres.dll`,307, All ; iconAddThisFolder

;========================================================================================================================
; SAVE FILE
;========================================================================================================================

FileDelete, %g_strIniFile%
FileAppend, %strIniContent%, %g_strIniFile%
IniWrite, 1, %g_strIniFile%, Global, UpdatedIconsWin10

MsgBox, 48, Settings file updated, The settings file has been updated:`n`n%g_strIniFile%`n`nRestart Quick Access Popup to see the new icons.
ExitApp

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


