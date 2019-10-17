;===============================================
/*

Quick Access Popup Messenger
Written using AutoHotkey_L v1.1.09.03+ (http://ahkscript.org/)
By Jean Lalonde (JnLlnd on AHKScript.org forum)
	
DESCRIPTION

Called from Explorer context menus to send messages to QAP in order to launch various actions like:
- add the selected folder to favorites (message "AddFolder")
- add the selected file to favorites (message "AddFile")
- add the selected folder to favorites in express mode (message "AddFolderXpress")
- add the selected file tofavorites in express mode (message "AddFileXpress")
See RECEIVE_QAPMESSENGER function in QuickAccessPopup.ahk for details.

HISTORY
=======

Version: 1.4 (2019-10-17)
- get the user's language from settings file in working directory following changes in v10
  - for Easy Setup: get the value from Windows registry key WorkingFolder
  - for portable installation: get it from ini file in script directory
- alternative settings file option is not supported (at worst, QAPmessenger will default to EN)

Version: 1.3 (2018-09-30)
- save script as UTF-8 (with BOM) to support foreign language charsets
- insert language variables in main script

Version: 1.2 (2018-09-15)
- add localization using QAP language files

Version: 1.1.9 BETA (2018-09-14)
- add localization using QAP language files

Version: 1.1.1 BETA (2017-07-11)
- add action to import ,lnk files (Windows shortcuts)

Version: 1.1 (2016-09-01)
- addig diagnostic code activated by value DiagMode in section Global of QAP ini file
- find the working directory to read the QAP ini file and write its diag file to this directory

Version: 1.0 (2016-06-20)
- small adjustment to prevent the cursor to shortly turn to wait image when showing menu from Desktop background

Version: 0.4 beta (2016-06-06)
- check if QAP is running before sending message; if not display error message
- improved message if QAPmessenger is launched directly

Version: 0.3 beta (2016-05-24)
- improve version number and branch mangement

Version: 0.2 beta (2016-04-29)
- check for result 0xFFFF flagging an open settings window in QAP

Version: 0.1 beta (2016-04-25)
- initial alpha test release
- implement message "AddFolder", "AddFile", "AddFolderXpress" and "AddFileXpress"
- manage result codes sent by QAP: 1 for success, FAIL or 0 if an error occurred

*/ 
;========================================================================================================================
; --- COMPILER DIRECTIVES ---
;========================================================================================================================

; Doc: http://fincs.ahk4.net/Ahk2ExeDirectives.htm
; Note: prefix comma with `

;@Ahk2Exe-SetName QAP Messenger
;@Ahk2Exe-SetDescription Send messages to Quick Access Popup
;@Ahk2Exe-SetVersion 1.4
;@Ahk2Exe-SetOrigFilename QAPmessenger.exe


;========================================================================================================================
; INITIALIZATION
;========================================================================================================================

#NoEnv
#SingleInstance force
#KeyHistory 0
ListLines, Off

g_strAppNameText := "Quick Access Popup Messenger"
g_strAppNameFile := "QAPmessenger"
g_strAppVersion := "1.4"
g_strAppVersionBranch := "prod"
g_strAppVersionLong := "v" . g_strAppVersion . (g_strAppVersionBranch <> "prod" ? " " . g_strAppVersionBranch : "")
g_stTargetAppTitle := "Quick Access Popup ahk_class JeanLalonde.ca"
g_stTargetAppTitleDev := "Quick Access Popup ahk_class AutoHotkeyGUI"
g_stTargetAppName := "Quick Access Popup"
g_strQAPNameFile := "QuickAccessPopup"

gosub, SetQAPWorkingDirectory

; Force A_WorkingDir to A_ScriptDir if uncomplied (development environment)
;@Ahk2Exe-IgnoreBegin
; Start of code for development environment only - won't be compiled
; see http://fincs.ahk4.net/Ahk2ExeDirectives.htm
SetWorkingDir, %A_ScriptDir%
; to test user data directory: SetWorkingDir, %A_AppData%\Quick Access Popup
; / End of code for developement enviuronment only - won't be compiled
;@Ahk2Exe-IgnoreEnd

g_blnDiagMode := False
g_strDiagFile := A_WorkingDir . "\" . g_strAppNameFile . "-DIAG.txt"
g_strIniFile := A_WorkingDir . "\" . g_strQAPNameFile . ".ini"

; Set developement ini file

;@Ahk2Exe-IgnoreBegin
; Start of code for developement environment only - won't be compiled
if (A_ComputerName = "JEAN-PC") ; for my home PC
	g_strIniFile := A_WorkingDir . "\" . g_strQAPNameFile . "-HOME.ini"
else if InStr(A_ComputerName, "STIC") ; for my work hotkeys
	g_strIniFile := A_WorkingDir . "\" . g_strQAPNameFile . "-WORK.ini"
; / End of code for developement environment only - won't be compiled
;@Ahk2Exe-IgnoreEnd


IniRead, g_blnDiagMode, %g_strIniFile%, Global, DiagMode, 0
IniRead, g_strLanguageCode, %g_strIniFile%, Global, LanguageCode, EN

gosub, InitLanguageVariables

if QAPisRunning()
{
	; Use traditional method, not expression
	g_strParam0 = %0% ; number of parameters
	g_strParam1 = %1% ; fisrt parameter, the command name
	g_strParam2 = %2% ; second parameter, the selected path or filename
	
	Diag("g_strParam0", g_strParam0)

	if (g_strParam0 > 0) and StrLen(g_strParam1)
	{
		Diag("Send_WM_COPYDATA:Param", g_strParam1 . "|" . g_strParam2)
		Diag("Send_WM_COPYDATA:g_stTargetAppTitle", g_stTargetAppTitle)
		; try to send message to compiled QAP
		intResult := Send_WM_COPYDATA(g_strParam1 . "|" . g_strParam2, g_stTargetAppTitle)
		; returns FAIL or 0 if an error occurred, 0xFFFF if a QAP window is open or 1 if success
		Diag("Send_WM_COPYDATA (1=OK)", intResult)
		
		; if error, check if running in dev
		if (intResult <> 1) and (intResult <> 0xFFFF)
		{
			intResult := Send_WM_COPYDATA(g_strParam1 . "|" . g_strParam2, g_stTargetAppTitleDev)
			Diag("Send_WM_COPYDATA-DEV:intResult", intResult)
		}
		
		if (intResult = 0xFFFF)
			Oops(lMessengerCloseQAPSettings . "`n`n" . lMessengerHelp, g_stTargetAppName)
	}
	else
		Oops(lMessengerDoNotRun . "`n`n" . lMessengerHelp, g_strAppNameText, g_stTargetAppName)
}
else
	Oops(lMessengerError . "`n`n" . lMessengerHelp, g_stTargetAppName)

return


;-----------------------------------------------------------
InitLanguageVariables:
;-----------------------------------------------------------

if (g_strLanguageCode = "DE")
{
	lMessengerCloseQAPSettings := "Ein Einstellungsfenster ist offen in ~1~, möglicherweise mit ungespeicherten Änderungen.`n`nSchliessen Sie bitte das Einstellungsfenster, bevor Sie dieses Kontextmenü verwenden."
	lMessengerDoNotRun := "Starten Sie ~1~ nicht direkt. Sie können:`n`n- eine Datei oder einen Ordner per Rechtsklick im Explorer zum Menü hinzufügen`n- im Explorerfenster-Hintergrund rechtsklicken um den aktuellen Ordner hinzuzufügen`n- auf dem Desktop-Hintergrund rechtsklicken um das Menü anzuzeigen.`n`nStellen Sie sicher, daß ~2~ gestartet ist, bevor Sie dessen Kontextmenüs verwenden. Siehe ""Kontextmenüs"" Kontrollkästchen im ~2~ ""Optionen"" Fenster."
	lMessengerError := "Ein Fehler ist aufgetreten.`n`nStellen Sie sicher, daß ~1~ läuft, bevor Sie dessen Kontextmenüs verwenden."
	lMessengerHelp := "Suche nach ""Messenger"" auf www.QuickAccessPopup.com für Unterstützung."
}
else if (g_strLanguageCode = "ES")
{
	lMessengerCloseQAPSettings := "Se abre una ventana de Configuración en ~1~, posiblemente con cambios no guardados.`n`nPor favor, cierre las ventanas de configuración antes de utilizar este menú contextual."
	lMessengerDoNotRun := "No ejecutar ~1~ directamente. Usted puede:`n`n- hacer clic con el botón derecho en un archivo o en un icono de carpeta en el Explorador para agregarlos al menú`n- hacer clic con el botón derecho en el fondo de la ventana del Explorador para agregar la carpeta actual`n- hacer clic con el botón derecho del ratón en el fondo del escritorio para abrir el menú.`n`nAsegúrese de que ~2~ se lanza antes de usar sus menús contextuales. Ver casilla de selección de""Menús contextuales"" en ~2~ la ventana de ""Opciones""."
	lMessengerError := "Ha ocurrido un error.`n`nAsegúrese de que ~1~ se está ejecutando antes de usar sus menús contextuales."
	lMessengerHelp := "Buscar por ""Messenger"" en www.QuickAccessPopup.com para ayuda."
}
else if (g_strLanguageCode = "FR")
{
	lMessengerCloseQAPSettings := "Une fenêtre de paramètres est ouverte dans ~1~, peut-être avec des changements non enregistrés.`n`nVeuillez fermer les fenêtres de paramètres avant d'utiliser ce menu contextuel."
	lMessengerDoNotRun := "N'exécutez pas ~1~ directement. Vous pouvez:`n`n- faire un clic-droite sur l'icône d'un fichier ou d'un dossier dans l'Explorateur pour l'ajouter au menu`n- clic-droite dans le fond d'une fenêtre de l'Explorateur pour ajouter le dossier affiché`n- clic-droite sur le fond du Bureau pour afficher le menu.`n`nAssurez-vous que ~2~ est lancé avant d'utiliser ses menus contextuels. Voir la case à cocher ""Menus contextuels"" dans la fenêtre ""Options"" de ~2~."
	lMessengerError := "Une erreur s'est produite.`n`nAssurez-vous que ~1~ est lancé avant d'utiliser ses menus contextuels."
	lMessengerHelp := "Recherchez ""Messenger"" sur www.QuickAccessPopup.com pour de l'aide."
}
else if (g_strLanguageCode = "IT")
{
	lMessengerCloseQAPSettings := "Una finestra delle Impostazioni è aperta in ~1~, eventualmente con modifiche non salvate.`n`nSi consiglia di chiudere le finestre di impostazioni prima di usare questo menù contestuale."
	lMessengerDoNotRun := "Non eseguire ~1~ direttamente. Puoi in alternativa:`n`n- fare un click-destro su un'icona di file/cartella in Explorer per aggiungerli al menù`n- click-destro in una finestra di Explorer (ossia sul suo sfondo) per aggiungere tale cartella`n- click-destro sullo sfondo del Desktop per aprire il menù a popup.`n`nAssicurati che ~2~ sia in esecuzione prima di usare i suoi menù contestuali. Vedere la casella di spunta  ""Menù contestuali"" nella finestra ""Opzioni"" ~2~."
	lMessengerError := "Si è verificato un errore.`n`nAssicurati che ~1~ sia in esecuzione prima di usare i suoi menù contestuali."
	lMessengerHelp := "Cerca ""Messenger"" su www.QuickAccessPopup.com per aiuto."
}
else if (g_strLanguageCode = "KO")
{
	lMessengerCloseQAPSettings := "설정 창이 ~1~에서 열리고 저장되지 않은 변경 사항이 있을 수 있습니다..`n`n이 상황에 맞는 메뉴를 사용하기 전에 설정 창을 닫으세요."
	lMessengerDoNotRun := "~1~을 직접 실행하지 마세요. 실행 방식:`n`n- 탐색기에서 파일이나 폴더 아이콘을 마우스 오른쪽 단추로 클릭하여 메뉴에 추가.`n- 현재 폴더를 추가하려면 탐색기 창 배경을 마우스 오른쪽 단추로 클릭.`n- 바탕 화면 배경을 마우스 오른쪽 버튼으로 클릭하여 메뉴 팝업.`n`n컨텍스트 메뉴를 사용하기 전에 ~2~가 시작되었는지 확인하세요. ~2~ ""옵션""창에서 ""컨텍스트 메뉴""확인란을 참조하세요."
	lMessengerError := "에러 발생.`n`n컨텍스트 메뉴를 사용하기 전에 ~1~이 실행 중인지 확인하세요."
	lMessengerHelp := "도움을 받으려면 www.QuickAccessPopup.com에서 ""Messenger""를 검색하세요."
}
else if (g_strLanguageCode = "NL")
{
	lMessengerCloseQAPSettings := "Een instellingenvenster is open in ~1~, mogelijk met onopgeslagen wijzingen.`n`nSluit alstublieft het venster alvorens het context menu te gebruiken."
	lMessengerDoNotRun := "Start ~1~ niet direct. U kunt gebruik maken van:`n`n- Klik met de rechtermuistoets op een bestand of map in Explorer om deze toe te voegen aan het menu`n- Klik met de rechtermuistoets op de achtergrond van Explorer om de geopende map toe te voegen`n- Klik met de rechtermuistoets op het bureaublad om QAP te openen.`n`nZorg ervoor dat ~2~ geopend is voordat de contextmenus gebruikt kunnen worden. Zie de ""Context menus""-optie in ~2~ ""Instellingen""."
	lMessengerError := "Er is een fout opgetreden.`n`nZorg er alstublieft voor dat ~1~ geladen is voor het gebruik van het context menu."
	lMessengerHelp := "Zoek naar ""Messenger"" op www.QuickAccessPopup.com voor hulp."
}
else if (g_strLanguageCode = "PT")
{
	lMessengerCloseQAPSettings := "É aberta uma janela em ~1~, possivelmente com alterações não guardadas.`n`nPor favor, feche as janelas de definições antes, usando este menu de contexto."
	lMessengerDoNotRun := "Não execute o ~1~ directamente. Pode:`n`n- clicar com o botão direito do rato num ícone de ficheiro ou pasta no Explorador para adicioná-los ao menu`n- clicar com o botão direito do rato no fundo da janela do Explorador para adicionar a pasta actual`n- clicar com o botão direito do rato no fundo do Ambiente de Trabalho para fazer emergir o menu.`n`nCertifique-se que o ~2~ está aberto antes de usar os seus menus de contexto. Ver caixa de selecção ""Menus de Contexto"" na janela ""Opções"" do ~2~."
	lMessengerError := "Ocorreu um erro.`n`nCertifique-se de que o ~1~ está em execução antes de usar os seus menus de contexto."
	lMessengerHelp := "Procure o ""Messenger"" em www.QuickAccessPopup.com para ajuda."
}
else if (g_strLanguageCode = "PT-BR")
{
	lMessengerCloseQAPSettings := "Uma janela de configurações ~1~ é aberta, possivelmente com alterações não salvas.`n`nPor favor, feche a janela de configurações antes de usar este menu de contexto."
	lMessengerDoNotRun := "Não execute o ~1~ diretamente. Você pode:`n`n- clicar com o botão direito do mouse em um arquivo ou ícone de pasta no Explorer para adicioná-los ao menu`n- clicar com o botão direito do mouse no fundo da janela do Explorer para adicionar a pasta atual`n- clicar com o botão direito no plano de fundo da área de trabalho para abrir o menu.`n`nCertifique-se de que o ~2~ foi executado antes de usar seus menus de contexto. Veja a caixa de marcação ""Menus de contexto"" na janela de ""Opções"" ~2~."
	lMessengerError := "Ocorreu um erro.`n`nCerifique-se de que o ~1~ está em execução antes de usar seus menus de contexto."
	lMessengerHelp := "Pesquise por ""Messenger"" em www.QuickAccessPopup.com para ajuda."
}
else ; if (g_strLanguageCode = "EN")
{
	lMessengerCloseQAPSettings := "A settings window is open in ~1~, possibly with unsaved changes.`n`nPlease, close the settings windows before using this context menu."
	lMessengerDoNotRun := "Do not run ~1~ directly. You can:`n`n- right-click a file or a folder icon in Explorer to add them to the menu`n- right-click Explorer window background to add the current folder`n- right-click the Desktop background to popup the menu.`n`nMake sure ~2~ is launched before using its context menus. See ""Context menus"" checkbox in ~2~ ""Options"" window."
	lMessengerError := "An error occurred.`n`nMake sure ~1~ is running before using its context menus."
	lMessengerHelp := "Search for ""Messenger"" on www.QuickAccessPopup.com for help."
}

lMessengerCloseQAPSettings := StrReplace(lMessengerCloseQAPSettings, "``n", "`n")
lMessengerDoNotRun := StrReplace(lMessengerDoNotRun, "``n", "`n")
lMessengerError := StrReplace(lMessengerError, "``n", "`n")
lMessengerHelp := StrReplace(lMessengerHelp, "``n", "`n")

return
;-----------------------------------------------------------


;-----------------------------------------------------------
Send_WM_COPYDATA(ByRef strStringToSend, ByRef strTargetScriptTitle) ; ByRef saves a little memory in this case.
; Adapted from AHK documentation (https://autohotkey.com/docs/commands/OnMessage.htm)
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
;-----------------------------------------------------------
{
    VarSetCapacity(varCopyDataStruct, 3 * A_PtrSize, 0) ; Set up the structure's memory area.
	
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    intSizeInBytes := (StrLen(strStringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(intSizeInBytes, varCopyDataStruct, A_PtrSize) ; OS requires that this be done.
    NumPut(&strStringToSend, varCopyDataStruct, 2 * A_PtrSize) ; Set lpData to point to the string itself.

	strPrevDetectHiddenWindows := A_DetectHiddenWindows
    intPrevTitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
	
    SendMessage, 0x4a, 0, &varCopyDataStruct, , %strTargetScriptTitle% ; 0x4a is WM_COPYDATA. Must use Send not Post.
	
    DetectHiddenWindows %strPrevDetectHiddenWindows% ; Restore original setting for the caller.
    SetTitleMatchMode %intPrevTitleMatchMode% ; Same.
	
    return ErrorLevel ; Return SendMessage's reply back to our caller.
}
;-----------------------------------------------------------


;------------------------------------------------
Oops(strMessage, objVariables*)
;------------------------------------------------
{
	global g_strAppNameText
	global g_strAppVersionLong
	
	MsgBox, 48, % L("~1~ (~2~)", g_strAppNameText, g_strAppVersionLong), % L(strMessage, objVariables*)
}
; ------------------------------------------------


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


;------------------------------------------------------------
QAPisRunning()
;------------------------------------------------------------
{
    strPrevDetectHiddenWindows := A_DetectHiddenWindows
    intPrevTitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows, On
    SetTitleMatchMode, 2
	
	SendMessage, 0x2224, , , , Quick Access Popup ahk_class JeanLalonde.ca ; USE v7.2 OR ahk_class JeanLalonde.ca
	intErrorLevel := ErrorLevel
	Diag("QAPisRunning:ErrorLevel (1=OK)", intErrorLevel)
    DetectHiddenWindows, %strPrevDetectHiddenWindows%
    SetTitleMatchMode, %intPrevTitleMatchMode%
	Sleep, -1 ; prevent the cursor to turn to WAIT image for 5 seconds (did not search why) when showing menu from Desktop background
	
    return (intErrorLevel = 1) ; QAP reply 1 if it runs, else SendMessage returns "FAIL".
}
;------------------------------------------------------------


;-----------------------------------------------------------
SetQAPWorkingDirectory:
;-----------------------------------------------------------

; See the same command in QuickAccessPopup.ahk for explanations
if !FileExist(A_ScriptDir . "\_do_not_remove_or_rename.txt")
{
	g_blnPortableMode := true ; set this variable for use later during init
	SetWorkingDir, %A_ScriptDir% ; do not support alternative settings files, always use value in scriptdir (at worst, default to EN)
	return
}

g_blnPortableMode := false ; set this variable for use later during init

strWorkingFolder := GetRegistry("HKEY_CURRENT_USER\Software\Jean Lalonde\Quick Access Popup", "WorkingFolder")
if !StrLen(strWorkingFolder)
	strWorkingFolder := A_AppData . "\Quick Access Popup"

SetWorkingDir, %strWorkingFolder%

return
;-----------------------------------------------------------


;------------------------------------------------
Diag(strName, strData)
;------------------------------------------------
{
	global g_blnDiagMode
	global g_strDiagFile

	if !(g_blnDiagMode)
		return

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


;---------------------------------------------------------
GetRegistry(strKeyName, strValueName)
;---------------------------------------------------------
{
	RegRead, strValue, %strKeyName%, %strValueName%
	
	return strValue
}
;---------------------------------------------------------


