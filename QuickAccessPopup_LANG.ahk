global lAboutText1 := "~1~ ~2~ (~3~ bits)"
global lAboutText2 := "~1~ is written by Jean Lalonde using the`n<a href=""http://ahkscript.org/"">AutoHotkey</a> programming language.`n`nGerman translation: Edgar ""Fast Edi"" Hoffmann`nFrench translation: Jean Lalonde`nSwedish translation:�ke Engelbrektson`nItalian translation: Riccardo Leone`nSpanish translation: kiketrucker`nBrazilian Portuguese translation: Igor Ruckert`nSimplified and Traditional Chinese translation: Jess Yang`nPortuguese translation: Luis Neves`nOther languages translation: (help welcomed)`nEnglish proof checking: (help welcomed)`n`nIcons by: <a href=""http://www.visualpharm.com"">Visual Pharm</a>`nInstall program: <a href=""http://www.jrsoftware.org/isinfo.php"">Inno Setup</a> by jrsoftware.org`nAutoHotkey_L v1.1 sources: <a href=""https://github.com/JnLlnd/QuickAccessPopup"">GitHub</a>"
global lAboutText3 := "~1~ Jean Lalonde 2013-2014. Freeware."
global lAboutText4 := "Support on <a href=""http://www.quickaccesspopup.com"">www.quickaccesspopup.com</a>"
global lAboutTitle := "About - ~1~ ~2~"
global lAlternativeMenuTrayTipCopyLocation := "Select the favorite to copy" ; new
global lAlternativeMenuTrayTipEditFavorite := "Select the favorite to edit" ; new
global lAlternativeMenuTrayTipNewWindow := "Select the folder to open in a new window" ; new
global lAppTagline :=  "<a href=""http://www.quickaccesspopup.com/what-should-i-know-about-quick-access-popup-before-starting/"">Quick Start</a> � <a href=""http://www.quickaccesspopup.com/frequently-asked-questions/"">Frequently asked questions</a> � <a href=""http://www.quickaccesspopup.com"">Support</a>" ; new
global lCopyLocationCopiedToClipboard := "Path or URL copied to the Clipboard" ; new
global lDiagModeCaution := "~1~ is running in diagnostic mode.`n`nInformation about the app's execution will be collected in the file:`n~2~`n`nNothing will be sent without your consent.`n`nDo you want to keep diagnostic mode ON?"
global lDiagModeExit := "~1~ colleted diagnostic information in the file ~2~."
global lDiagModeIntro := "Send this file to ahk@jeanlalonde.ca with a description of the situation requiring diagnostic."
global lDiagModeSee := "Do you want to see the diagnostic file?"
global lDialogActivateAlreadyRunning := "If the application is already running, activate it instead of launching`n(application must be of the exactly same location)" ; new
global lDialogAdd := "Add"
global lDialogAddEditFavoriteTitle := "~1~ Favorite: ~4~ - ~2~ ~3~" ; changed
global lDialogAddFavoriteSelectTitle := "Add Favorite - ~1~ ~2~" ; new
global lDialogAddFavoriteTabs := "Basic Settings|Menu Options|Window Options|Advanced Settings" ; new
global lDialogAddFileSelect := "Choose the new document:"
global lDialogAddFolderManuallyPrompt := "Sorry, we can't detect the current folder in this type of window.`n`nDo you want to add a favorite folder manually now?" ; changed
global lDialogAddFolderManuallyTitle := "Add This Folder - ~1~ ~2~"
global lDialogAddFolderSelect := "Choose or create the new folder:"
global lDialogAlt := "Alt" ; lOptionsAlt renamed
global lDialogApplicationLabel := "Application"
global lDialogArgumentsLabel := "Parameters"
global lDialogArgumentsLabelHelp := "(enclose each parameter in double-quotes if required)" ; new
global lDialogArgumentsPlaceholders := "You can insert the location of this favorite or part of it in the parameters using these placeholders: {LOC} (full location), {NAME} (file name), {DIR} (directory), {EXT} (extension), {NOEXT} (file name without extension) or {DRIVE} (drive)" ; new
global lDialogArgumentsPlaceholdersCheckLabel := "Current parameters with expanded placeholders" ; new
global lDialogBrowseButton := "Browse"
global lDialogBrowseOrSelectApplication := "Browse for an executable file or`nselect a running application in this list" ; new
global lDialogCancelButton := "Cancel"
global lDialogCancelPrompt := "Discard changes?"
global lDialogCancelTitle := "Cancel - ~1~ ~2~"
global lDialogChangeHotkeyAlternative := "This is an Alternative menu hotkey.`n`nDo you want to manage ""~1~"" in ""~2~""?" ; new
global lDialogChangeHotkeyNote := "Note: The location ""~1~"" will be linked to the new hotkey in all menus." ; new
global lDialogChangeHotkeyNoteSnippet := "Note: This snippet will be linked to the new hotkey in all menus." ; new
global lDialogChangeHotkeyPopup := "This is a popup menu hotkey.`n`nDo you want to manage ""~1~"" in ""~2~""?" ; new
global lDialogChangeHotkeyTitle := "Change hotkey - ~1~ ~2~" ; lOptionsChangeHotkeyTitle renamed
global lDialogContinue := "Continue" ; added
global lDialogCopy := "Copy" ; new
global lDialogCtrl := "Control" ; renamed
global lDialogCtrlShort := "Ctrl" ; renamed
global lDialogEdit := "Edit"
global lDialogEditIcon := "Edit icon resource" ; new
global lDialogEditIconPrompt := "Edit icon resource in the format ""iconfile,index"" (for example, ""shell32.dll,2""):" ; new
global lDialogEndOfMenu := "end of menu"
global lDialogErrorMoving := "Unable to resize for favorite:`n""~1~""" ; new
global lDialogExternalLocation := "Shared menu settings file location" ; changed
global lDialogExternalLocationIni := "Shared menu settings file must be an .ini file" ; changed
global lDialogExternalStartingNumber := "Number of the first favorite:" ; new
global lDialogFavoriteDoesNotExistPrompt := "The favorite ""~1~""~2~ does not exist or is not available.`n`nIf this favorite is on a network drive, please try again after network authentification." ; changed
global lDialogFavoriteDoesNotExistTitle := "Favorite does not exist - ~1~"
global lDialogFavoriteDropdownEmpty := "Please choose an item in the ~1~ drop-down list." ; new
global lDialogFavoriteExternalHelpWeb := "See <a href=""~1~"">Shared menus help</a> for more information." ; changed
global lDialogFavoriteLocationEmpty := "The location is empty. Please, choose a location."
global lDialogFavoriteMenuPosition := "Insert the new favorite before this item"
global lDialogFavoriteNameEmpty := "The favorite name is empty. Please, choose a name."
global lDialogFavoriteNameNoSeparator := "This item name cannot include the reserved character ""~1~""." ; changed
global lDialogFavoriteNameNotAllowed := "Favorites of type ""~1~"" are not allowed in groups. Please, select another parent menu in the ""Menu Options"" tab." ; new
global lDialogFavoriteNameNotNew := "The name ""~1~"" is already used in this menu. Please, choose a new name."
global lDialogFavoriteNameNotNewQAPfeature := "The name ""~1~"" is already used in this menu. Please, rename the existing favorite and try again." ; new
global lDialogFavoriteParentMenu := "Favorite parent menu"
global lDialogFavoriteRemoveExternalPrompt := "Remove the shared submenu ""~1~""`n(external settings ini file will NOT be deleted)?" ; new
global lDialogFavoriteRemovePrompt := "Remove the submenu ""~1~""`nand ALL its content (folders and submenus)?"
global lDialogFavoriteRemoveTitle := "Remove Favorite - ~1~"
global lDialogFavoriteSelectType := "Select the type of favorite to add.`n`nIn the next window, you will give your favorite:`n- a name`n- a content (depending on the type)`n- various settings (icon, shortcut, etc.)`n`nChoose the new favorite's type and click ""~1~""." ; new
global lDialogFavoriteShortNameLabel := "Short name for menu" ; new
global lDialogFavoriteSnippetEmpty := "The content is empty. Please, enter the snippet's content." ; new
global lDialogFavoriteSnippetHelpNoProcess := "Insert ``n for end-of-line and ``t for tab."
global lDialogFavoriteSnippetHelpProcess := "Use Ctrl-Tab to insert tabs and Enter to insert end-of-lines"
global lDialogFavoriteSnippetHelpWeb := "See <a href=""~1~"">Snippets help</a> for special characters and commands encoding."
global lDialogFavoriteSnippetProcessEOLTab := "Automatically encode end-of-lines and tabs"
global lDialogFavoriteSnippetSendMode := "Send snippet to current application in:"
global lDialogFavoriteSnippetSendModeMacro := "Macro mode"
global lDialogFavoriteSnippetSendModeText := "Text mode"
global lDialogFavoriteSnippetPromptLabel := "Prompt before ~1~ the snippet" ; new
global lDialogFavoriteSnippetPromptLabelLaunching := "launching" ; new
global lDialogFavoriteSnippetPromptLabelPasting := "pasting" ; new
global lDialogFavoriteSnippetPromptNoPipe := "Pipe character (|) are not allowed in snippet prompt." ; new
global lDialogFavoriteSnippetSendMode := "Send snippet to current application in:"
global lDialogFavoriteSnippetSendModeMacro := "Macro mode"
global lDialogFavoriteSnippetSendModeText := "Text mode"
global lDialogFavoritesParentMenuMove := "Move ~1~ favorites to this menu"
global lDialogFavoriteType := "Favorite Type" ; new
global lDialogFavoriteTypesHelp1 := "Create a shortcut to a frequently used ""Folder"".`n`nSet the favorite's menu name, path and various menu options.`n`nAdvanced settings allow to set the window position and file manager options." ; new
global lDialogFavoriteTypesHelp13 := "Create a ""Snippet"". Set the snippet's title for the menu, its content and various menu options.`n`nIn advanced options, choose ""Text mode"" to paste snippets of text as you would do with the Clipboard or choose ""Macro mode"" to send snippets as if you would type keystrokes (including special keys, see help)." ; new
global lDialogFavoriteTypesHelp14 := "Create a ""Shared menu"" to use favorites on various systems from the same settings file on an external location.`n`nSet the shared menu's name for the menu, the external settings file location and various options.`n`nShared menus can be edited as regular menus except if they are set as read-only (see help)." ; new
global lDialogFavoriteTypesHelp2 := "Create a shortcut to a ""Document"".`n`nSet the favorite's menu name, path and various menu options.`n`nAdvanced settings allow to choose a specific application to launch the document, add optional parameters and set the window position." ; new
global lDialogFavoriteTypesHelp3 := "Create a shortcut to an ""Application"" (program, batch or script).`n`nBrowse for the executable file or select one of the currently running programs. Set various menu options.`n`nAdvanced settings allow to select a ""Start In"" directory, add parameters and set the window position." ; new
global lDialogFavoriteTypesHelp4 := "Create a shortcut to one of the 50 pre-defined Windows ""Special Folders"" suchs as: Libraries, My Pictures, Recycle Bin, Downloads, etc.`n`nSet various menu options. Advanced settings allow to set the window position and file manager options." ; new
global lDialogFavoriteTypesHelp5 := "Create a ""Link"" to a web page.`n`nSet menu name, web page's address (URL) and various menu options.`n`nAdvanced settings allow to select a specific browser to launch the link, add optional parameters and set the window position." ; new
global lDialogFavoriteTypesHelp6 := "Create a shortcut to an ""FTP Site"".`n`nSet menu name, FTP site's address (URL), login name, password and various menu options.`n`nAdvanced settings allow to select a specific FTP program to access this site, add optional parameters, set the window position and encode login name and password.`n`nNote: the password is NOT encrypted when sent on Internet." ; new
global lDialogFavoriteTypesHelp7 := "Insert anywhere in your menu ""Quick Access Popup Features"" such as:`n`n- ~1~`n- ~2~`n- ~3~`n- ~4~`n- ~5~`n- etc." ; new
global lDialogFavoriteTypesHelp8 := "Gather related favorites in a ""Submenu"".`n`nGive your submenu a name and select menu options.`n`nAdd favorites to your submenu or move them from other submenus or groups using the ""Edit"" button." ; new
global lDialogFavoriteTypesHelp9 := "Launch a ""Group"" of favorites, all in one shortcut!`n`nGive your group a name and set various options for your group.`n`nAdd favorites to your group or move them from other submenus or groups using the ""Edit"" button.`n`nAdvanced settings allow to control restoring speed by inserting a delay between each favorite to restore." ; new
global lDialogFavoriteTypesLabels := "&Folder|&Document|&Application|&Special Folder|&Link|F&TP Site|&QAP Feature|Sub&menu|&Group||||S&nippet|S&hared Menu" ; changed
global lDialogFavoriteTypesLocationLabels := "Folder (path)|Document (path and file name)|Application (path and file name)||Link (URL)|FTP Site (URL)|||||||Content|External settings file (path)|" ; changed
global lDialogFavoriteTypesShortNames := "Folder|Doc|App|Special|Link|FTP|QAP|Menu|Group|Separator|Column Break|..|Snippet|Shared" ; changed
global lDialogFileLabel := "Document"
global lDialogFolderLabel := "Folder"
global lDialogGetWinInfo := "To identify the window of which you want to get the title and class, click in the target window with the QAP menu hotkey [~1~]." ; new
global lDialogGetWInInfo2Clippoard := "Window title:`n""~1~""`n`nClass:`n""~2~""`n`nCopy this info to your Clipboard?" ; new
global lDialogHotkeys := "Hotkeys" ; new
global lDialogHotkeysManageAbout := "Shortcuts currently active in ~1~" ; new
global lDialogHotkeysManageAlternative := "Alternative" ; new
global lDialogHotkeysManageAlternativeMenu := "Alternative Menu" ; new
global lDialogHotkeysManageIntro := "Double-click on a favorite line to change its shortcut." ; new
global lDialogHotkeysManageListHeader := "Menu|Favorite Name|Type|Hotkey|Favorite Location" ; new
global lDialogHotkeysManageListSeeAllFavorites := "See all favorites" ; new
global lDialogHotkeysManageListSeeShortHotkeyNames := "See abbreviated hotkey names" ; new
global lDialogHotkeysManagePopup := "Popup" ; keep Popup in all languages?
global lDialogHotkeysManageTitle := "Manage Hotkeys - ~1~ ~2~" ; new
global lDialogIcon := "Favorite Icon" ; changed
global lDialogInvalidHotkey := "With your current system keyboard layout, the hotkey ""~1~"" could not be used as a trigger for the popup menu (not a valid key name error).`n`nPlease, open the ""Settings"" window from the Tray menu and click ""Options"". In this dialog box, choose another shortcut for ""~2~""."
global lDialogInvalidHotkeyFavorite := "With your current system keyboard layout, the hotkey ""~1~"" could not be used as a trigger for the location ""~2~"" (not a valid key name error).`n`nPlease, choose another shortcut for location ""~2~""." ; new
global lDialogKeyboard := "Keyboard" ; lOptionsKeyboard renamed
global lDialogLaunchWith := "Launch with this application" ; new
global lDialogMaximized := "Maximized"
global lDialogMenuNotMoveUnderItself := "Menu ""~1~"" cannot be moved under itself"
global lDialogMinimized := "Minimized"
global lDialogMouse := "Mouse" ; lOptionsMouse renamed
global lDialogMouseButtonsText := "Left Mouse Button|Middle Mouse Button|Right Mouse Button|Special Mouse Button 1|Special Mouse Button 2|Wheel Up|Wheel Down|Wheel Left|Wheel Right|" ; lOptionsMouseButtonsText renamed
global lDialogMouseCheckLButton := "You can't assign the ""Left Mouse Button"" without a modifier`n(like ~1~, ~2~, ~3~ or ~4~ keys)." ; lOptionsMouseCheckLButton renamed, changed
global lDialogMoveFavoritesTitle := "Move Favorites - ~1~ ~2~"
global lDialogNone := "None" ; lOptionsMouseNone renamed
global lDialogNormal := "Normal"
global lDialogOK := "OK" ; new
global lDialogOpenThisMenu := "Open this menu"
global lDialogOr := "or" ; new (lowercase)
global lDialogRemoveMultipleFavorites := "Do you realy want to remove ~1~ favorites or submenus?"
global lDialogSelectIcon := "Select icon" ; new
global lDialogSelectItemToAdd := "Select the item to add" ; new
global lDialogSelectItemToEdit := "Please, select the item to edit."
global lDialogSelectItemToMove := "Please, select the item to move." ; new
global lDialogSelectItemToRemove := "Please, select the item to remove."
global lDialogShift := "Shift" ; renamed
global lDialogShortcut := "Shortcut" ; new
global lDialogSpacebarTab := "choose <a id=""Space"">space bar</a> or <a id=""Tab"">tab</a>" ; do NOT translate ID="xxx"
global lDialogState := "Window State:" ; new
global lDialogSubmenuNameEmpty := "The submenu name is empty. Please, choose a name."
global lDialogSubmenuParentMenu := "Submenu parent menu"
global lDialogTabNext := "Next"
global lDialogThirdPartyDetected := "~1~ detected that ~2~ is installed on your system.`n`nDo you want to enable ~2~ integration?"
global lDialogTriggerFor := "Trigger for:" ; renamed
global lDialogUseDefaultWindowPosition := "Use default window position" ; new
global lDialogWin := "Windows" ; this is the windows key
global lDialogWindowPosition := "Window position:" ; new
global lDialogWindowPositionDelay := "Delay" ; new
global lDialogWindowPositionH := "Height" ; new
global lDialogWindowPositionLeft := "Left" ; new
global lDialogWindowPositionMayFail := "Note: for various reasons QAP may fail to move or resize some windows." ; new
global lDialogWindowPositionRight := "Right" ; new
global lDialogWindowPositionW := "Width" ; new
global lDialogWindowPositionX := "Left" ; new
global lDialogWindowPositionY := "Top" ; new
global lDialogWindowsFolderIconCreate := "create" ; new
global lDialogWindowsFolderIconNoRoot := "The Windows folder icon cannot be set in drive's root directory (~1~)." ; new
global lDialogWindowsFolderIconPrompt := "This command will ~1~ the system file:`n~2~`n`nThe Windows folder's icon will be set to the icon currently selected for this favorite. Do you want to continue?" ; new
global lDialogWindowsFolderIconRemove := "Remove Windows folder icon" ; new
global lDialogWindowsFolderIconRemoveFile := "This command can also DELETE the system file:`n~1~`n`nDo you want to restore this folder to its normal state?" ; new
global lDialogWindowsFolderIconReset := "The folder's icon will be reset to its default image. `n`nDo you want to continue?" ; new
global lDialogWindowsFolderIconSet := "Set Windows folder icon" ; new
global lDialogWindowsFolderIconUpdate := "update" ; new
global lDialogWinShort := "Win" ; windows key short name
global lDialogWorkingDirLabel := "Start in"
global lDonateButton := "Support Freeware!"
global lDonateCheckPrompt := "Are you happy with ~1~?`n`n~1~ is not only FREE of charge but also FREE of nasty advertising or adware that you never know if they carry spyware or malware.`n`n~2~ times so far, ~1~ has helped you in your daily work. How about supporting freeware now?"
global lDonateCheckTitle := "~1~ times! - ~2~"
global lDonateMenu := "Support Freeware!"
global lDonatePlatformComment1 := "The most flexible way using your PayPal account or your credit card"
global lDonatePlatformComment2 := "Receive an official invoice if you need it to be refunded"
global lDonatePlatformName1 := "Using Paypal"
global lDonatePlatformName2 := "Using Share-it"
global lDonateReviewNameLeft1 := "Download.com"
global lDonateReviewNameLeft2 := "PortableFreeware.com"
global lDonateReviewNameLeft3 := "Softpedia.com"
global lDonateReviewNameRight1 := "BetaNews.com"
global lDonateReviewNameRight2 := "FileCluster.com"
global lDonateReviewNameRight3 := "Freewares && Tutos (FR)"
global lDonateText1 := "Support ~1~ development!"
global lDonateText2 := "<a href=""~1~"">Why support freeware?</a>"
global lDonateText3 := "... or support freeware for free!"
global lDonateText4 := "Give a favorable review to ~1~ on:"
global lDonateText5 := "Send me your link"
global lDonateThankyou := "Thank you for supporting freeware!"
global lDonateTitle := "Support freeware! - ~1~ ~2~"
global lGui2Close := "Close"
global lGuiAbout := "About"
global lGuiAddFavorite := "Add"
global lGuiCancel := "&Cancel"
global lGuiClose := "&Close"
global lGuiDonate := "Support"
global lGuiDropFilesHelp := "Drag && Drop Help"
global lGuiDropFilesIncentive := "You can Drag & Drop the following types of favorites`nto the ~1~ window:`n`n- ~2~`n- ~3~`n- ~4~"
global lGuiEditFavorite := "Edit"
global lGuiGroupClosing := "Closing Explorer windows" ; changed
global lGuiGroupRestoreDelay := "Delay between favorites to restore:" ; new
global lGuiGroupRestoreDelayMilliseconds := "milliseconds" ; new
global lGuiGroupRestoreSide := "Display on which side of ~1~?" ; new
global lGuiGroupSaveAddWindowsLabel := "Add to existing windows"
global lGuiGroupSaveReplaceWindowsLabel := "Replace existing windows" ; changed
global lGuiGroupSaveRestoreOption := "When restoring this group:"
global lGuiGroupSaveRestoreWith := "Restore folders with:" ; new
global lGuiHelp := "Help"
global lGuiHotkeysHelp := "Favorites Shortcuts Help"
global lGuiHotkeysHelpText := "Down: Select next favorite`nUp: Select previous favorite`n`nEnter: Edit favorite`nCtrl-N: Add a new favorite`nCtrl-C: Copy a favorite`nDel: Remove favorite(s)`n`nShift-Up/Down: Select contiguous favorites`nCtrl-Click: Select non-contiguous favorites`nCtrl-A: Select all favorites`n`nCtrl-Down: Move favorite(s) down`nCtrl-Up: Move favorite(s) up`n`nCtrl-Right: Open selected submenu or group`nCtrl-Left: Open parent menu" ; order changed and lines added
global lGuiLoginName := "Login name" ; new
global lGuiLvFavoritesHeader := "Name|Type|Location or content" ; changed
global lGuiMove := "Move"
global lGuiOptions := "Options"
global lGuiPassword := "Password" ; new
global lGuiPasswordNotEncripted := "Note: the password will NOT be encrypted when sent on Internet." ; new
global lGuiRemoveFavorite := "Remove"
global lGuiResetDefault := "Reset default hotkey"
global lGuiSave := "&Save"
global lGuiSaveToUpdateBacklinks := "Save to update back links" ; new
global lGuiSubmenuDropdownLabel := "Menu or group to edit:" ; changed
global lGuiTitle := "Settings - ~1~ ~2~"
global lHelpTabAddingFavorite := "Adding Favorites" ; changed
global lHelpTabGettingStarted := "Getting Started"
global lHelpTabQAPFeatures := "QAP Features" ; new
global lHelpTabTipsAndTricks := "Tips and Tricks" ; variable name changed
global lHelpText11 := "At its launch, Quick Access Popup adds an icon in the System Tray and awaits your orders. When you want to launch one of your preferred FOLDERS, DOCUMENTS, APPLICATIONS, WEB LINKS, FTP SITE or SNIPPET, just hit the QAP hotkey [~1~] or [~2~] and, in the popup menu, select the desired favorite." ; changed
global lHelpText12 := "When you select a favorite FOLDER in Windows Explorer or a file dialog box*, Quick Access Popup  instantly ""navigate"" the current window to this folder! * This feature must be enabled in Options." ; new
global lHelpText13 := "To force opening the folder in a new window, hit the Alternative hotkeys [~1~] or [~2~]. In the Alternative menu, select ""Open in new window"", then select the desired folder. The Alternative menu offers several other functionalities." ; new
global lHelpText14 := "Choose ""Settings"" to customize your Quick Access Popup menu. You can add favorites to your menu. You can move, rename or delete them. You can also add SUBMENUS, GROUPS or SHARED MENUS. Choose the ""Menu or group to edit:"" in the  drop-down list. Click ""Save"" to keep your changes." ; changed
global lHelpText21 := "To add favorites, in the ""Settings"" window, click the ""Add"" button. Select the type of the new favorite and see the tips on the right side of the window. Click ""Continue"" to open the ""Add Favorite"" dialog box." ; changed
global lHelpText22 := "In the four tabs of the ""Add favorite"" dialog box, enter the ""Basic Settings"", ""Menu Options"", ""Window Options"" and ""Advanced Settings"". Click ""Add"" to insert the favorite in your menu and ""Save"" in the Settings window." ; new
global lHelpText23 := "ADD THIS FOLDER`n`nTo quickly ADD a new favorite FOLDER to the popup menu:`n1) Go to a frequently used folder.`n2) Click the QAP hotkey [~1~] or [~2~], and choose ""Add This Folder"".`n3) Give the folder a short name, click ""Add"", then ""Save"" in the Settings window." ; changed
global lHelpText31 := "In the ""My QAP Essentials"" menu:" ; new
global lHelpText32 := "- Hit the ""Switch..."" menu to switch to any other running Explorer or application window.`n- Use the ""Reopen a Folder"" menu to reopen one of the folders already open in an Explorer window (very useful in file dialog boxes).`n- Choose the ""Recent folders..."" menu to show an updated list of the Windows recent folders.`n- Access the files or URLs in your Clipboard with the ""Clipboard"" menu.`n- Click the ""Drives"" menu to see the list of drives with current disk space." ; changed
global lHelpText33 := "CUSTOMIZE YOUR QAP FEATURES MENU" ; not new (splitted)
global lHelpText34 := "You can move the ""My QAP Essentials"" menu items to the main menu or to other submenus as you wish.`n`n1) Select the ""Settings"" menu (or hit [~1~]).`n2) In the ""Menu or group to edit:"" drop-down list, select ""Main > My QAP Essentials"".`n3) Select the QAP feature to move and click ""Edit"".`n4) In the ""Menu Options"" tab, select the new ""Favorite Parent menu"".`n5) Save your changes." ; not new (splitted)
global lHelpText41 := "- Use the Quick Access Popup icon in the Tray menu (lower right of Windows screen) in one of these three ways:`n1) Left-click the icon to open the QAP popup menu`n2) Right-click the icon to open the QAP system menu.`n3) Double-click the icon to open the ""Settings"" dialog box." ; new
global lHelpText42 := "- In the Tray menu, right-click on the Quick Access Popup icon and check the ""Run at Startup"" option to launch Quick Access Popup automatically at start-up." ; new
global lHelpText43 := "- Configure your Quick Access Popup menu triggers: choose your preferred mouse buttons or keyboard shortcuts in ""Settings, Options, Menu hotkeys""." ; new
global lHelpText44 := "- Also in ""Options"": choose your preferred language, menu icons size, windows colors. Select the number of recent folders to display, add numeric keyboard shortcuts to the folders menu or shortcut reminders. Pin the popup menu at a fix position or remember the Settings window position." ; new
global lHelpText45 := "- Directory Opus users, see <a href=""http://www.quickaccesspopup.com/how-to-i-enable-directory-opus-support-in-quick-access-popup/"">this page</a> for additional information.`n- Total Commander users, see <a href=""http://www.quickaccesspopup.com/how-do-i-enable-total-commander-support-in-quick-access-popup/"">this page</a> for additional information.`n- Other file managers users, see <a href=""http://www.quickaccesspopup.com/what-file-managers-are-supported-in-addition-to-windows-explorer/"">this page</a> for additional information on QAPconnect." ; new
global lHelpTextLead := "Quick Access Popup lets you move like a breeze between your frequently used folders, documents, applications, web pages and much more!"
global lHelpTitle := "Help - ~1~ ~2~"
global lMainMenuName := "Main"
global lMenuAbout := "A&bout"
global lMenuAddFavorite := "Add Favorite" ; new
global lMenuAddThisFolder := "Add This Folder"
global lMenuAddThisFolderXpress := "Add This Folder Express" ; new
global lMenuAlternativeEditFavorite := "Edit a Favorite" ; new
global lMenuAlternativeNewWindow := "Open in new window" ; new
global lMenuAppData := "Application Data"
global lMenuCache := "Cache"
global lMenuClipboard := "Clipboard"
global lMenuCloseThisMenu := "Close this menu"
global lMenuColumnBreak := "column"
global lMenuCommonAppData := "Common Application Data"
global lMenuCommonDesktop := "Common Desktop"
global lMenuCommonStartMenu := "Common Start Menu"
global lMenuCommonStartupMenu := "Common Startup Menu"
global lMenuComputerRestart := "Restart Computer" ; new
global lMenuComputerShutdown := "Shutdown Computer" ; new
global lMenuCookies := "Cookies"
global lMenuCopyLocation := "Copy a Favorite's Path or URL" ; new
global lMenuCurrentFolders := "Reopen a Folder" ; changed
global lMenuDesktop := "Desktop"
global lMenuDownloads := "Downloads"
global lMenuDrives := "Drives" ; new
global lMenuDrivesSpace := "(~1~ GB free / ~2~ GB)" ; new GB for giga-bytes
global lMenuEditIniFile := "Edit ~1~" ; new
global lMenuExitApp := "Exit ~1~"
global lMenuFavoritesInternet := "Favorites (Internet)"
global lMenuFonts := "Fonts"
global lMenuGetWinInfo := "Get window Title and Class" ; new
global lMenuHelp := "Help"
global lMenuHistory := "History"
global lMenuMenu := "Menu"
global lMenuMyMusic := "My Music"
global lMenuMyQAPMenu := "My QAP Esssentials" ; new
global lMenuMySpecialMenu := "My Special Folders" ; new
global lMenuMyVideo := "My Video"
global lMenuNoClipboard := "Clipboard contains no path or URL..." ; new
global lMenuNoCurrentFolder := "No currently open folders..." ; new
global lMenuPictures := "Pictures"
global lMenuProgramFiles := "Program Files"
global lMenuProgramsFolderStartMenu := "Programs Folder (Start Menu)"
global lMenuPublicLibraries := "Public Libraries"
global lMenuQuickLaunch := "Quick Launch"
global lMenuRecentFolders := "Recent Folders"
global lMenuRecentItems := "Recent Items"
global lMenuReload := "Restart ~1~" ; new
global lMenuRunAtStartup := "&Run at Startup"
global lMenuSettings := "Settings" ; changed
global lMenuStartMenu := "Start Menu"
global lMenuStartup := "Startup"
global lMenuSuspendHotkeys := "Suspend Hotkeys"
global lMenuSwitchFolderOrApp := "Switch" ; changed
global lMenuSystemCertificates := "System Certificates"
global lMenuTemplates := "Templates"
global lMenuTemporaryFiles := "Temporary Files"
global lMenuUpdate := "Check for &update"
global lMenuUserFolder := "User Folder"
global lMenuUserPinned := "User Pinned"
global lNavigateFileError := "An error occurred while opening the folder:`n~1~."
global lNavigateSpecialError := "An error occurred while opening the special folder #~1~."
global lOopsCannotCopyFavorite := "Favorites of type ""~1~"" cannot be copied." ; new
global lOopsChangeFolderInDialogAlert := "Did you want to change folder in this dialog box? In order to navigate inside a dialog box, you have to enable an option (first checkbox in the ""General"" tab).`n`nDo you want to open the Options window?" ; new
global lOopsCouldNotOpenSpecialFolder := "~1~ could not open the special folder: ""~2~""."
global lOopsEmpty := "empty" ; new (no capital)
global lOopsErrorIniFileRetry := "If the settings file is on a network drive, try reload ~1~ when the network drive will be available." ; new
global lOopsErrorIniFileUnavailable := "This shared menu settings file is unavailable" ; new
global lOopsErrorReadingIniFile := "An error occurred while reading this settings file:" ; new
global lOopsExternalMenuReadOnly := "This shared menu is in read-only and cannot be modified." ; new
global lOopsFtpLocationProtocol := "FTP location must start with ""ftp://""." ; new
global lOopsGroup := "group" ; new
global lOopsHotkeyAlreadyUsed := "The hotkey ""~1~"" is already used for ~2~.`n`nPlease, choose another hotkey for ~3~." ; new
global lOopsHotkeyNotInMenus := "Error: location ""~1~"" for hotkey ""~1~"" not found in menus." ; new
global lOopsHttpLocationTransformed := "The http location (URL format) has been transformed to a network path (UNC format) for compatibility with Windows:`n`n~1~`n~2~" ; changed
global lOopsInvalidWinCmdIni := "Total Commander settings file ""wincmd.ini"" not found.`n`nSelect the file in ""Options"", ""File managers"" tab."
global lOopsInvalidWindowPosition := "Invalid window position value(s)" ; new
global lOopsLaunchWithNotFound := """Launch with this application"" file not found:`n`n~1~`n`nCheck the favorite's advanced settings." ; new
global lOopsLocation := "location" ; new
global lOopsOSVerrsionError := "~1~ requires Window 7 or a more recent operating system. Windows Vista and XP users are invited to use Folders Popup that is compatible with these versions.`n`nDo you want to visit Folders Popup website?" ; new
global lOopsQAPfeature := "QAP feature" ; new
global lOopsTitle := "~1~ (~2~)"
global lOopsUnknownTargetAppName := "An error occurred while trying to open this favorite. Please, try again..." ; new
global lOopsWriteProtectedError := "It appears that ~1~ is running from a WRITE-PROTECTED folder where the configuration file ""~1~.ini"" could not be created.`n`nMove the ~1~ .EXE file to the REGULAR folder of your choice and re-run it from this folder.`n`n~1~ will quit."
global lOopsWrongThirdPartyPath := "Wrong path or file name for ~1~:`n~2~.`n`nCheck the .exe file selected for ~1~ in ""Options"", tab ""~3~""."
global lOopsWrongThirdPartyPathQAPconnect := "Wrong path or file name for QAPconnect application`n~1~:`n~2~.`n`nCheck values for [~1~] in ~3~. Use the ""~4~"" button in ""Options"", tab ""~5~""." ; new
global lOopsZipFileError := "It appears that ~1~ is running directly from a .ZIP file.`n`nYou must extract the ~1~ .EXE file from the .ZIP file to the folder of your choice before running it.`n`n~1~ will quit."
global lOptionsAddCloseToDynamicMenus := "&Add ""Close"" to menus"
global lOptionsAlternativeMenuFeatures := "Alternative Menu Hotkeys" ; new
global lOptionsAlternativeMenuFeaturesIntro := "Manage the shortcuts that will trigger the Alternative menu features." ; new
global lOptionsChangeFolderInDialog := "Change &folders in dialog box with main QAP mouse and keyboard hotkeys" ; changed
global lOptionsChangeFolderInDialogCheckbox := "Click this checkbox to confirm that you understand the possible consequence of misusing the change folder feature in ""non-file"" dialog boxes." ; new
global lOptionsChangeFolderInDialogText := "Turn this option ON to enable folder navigation in dialog boxes (Open, Save As, etc.) but, please, read the following warning.`n`nYou must use this feature ONLY in ""file"" dialog boxes. If you use it in other types of dialog box, for example in an ""Options"" dialog box, trying to change folder could modify and save values in the dialog box without any notification." ; new
global lOptionsChangeHotkey := "Change"
global lOptionsCheck4Update := "&Check for update"
global lOptionsDisplayIcons := "Display Menu &Icons"
global lOptionsDisplayMenuShortcuts := "Display &Numeric Menu Shortcuts"
global lOptionsExclusionDetail1 := "To block the QAP mouse menu button [~1~] in an application, enter any part of the application's window title. You can enter multiple exclusions, one per line. For example, to exclude Chrome and Word, enter the following two lines in the exclusion list:`n`nGoogle Chrome`nMicrosoft Word" ; new
global lOptionsExclusionDetail2 := "The QAP hotkey will be disabled in these apps and the [~1~] click will be sent to the target window as if QAP was not running. You can also exclude windows by their class name. You can find help and support on this feature <a href=""~2~"">on the QAP website</a>." ; new
global lOptionsExclusionList := "Exclusions list" ; new
global lOptionsExclusionTitle := "Exclusions list for Mouse trigger [~1~]" ; new
global lOptionsExplorerContextMenus := "Enable Explorer Context Menus"
global lOptionsFtpEncoding := "Encode FTP username and password (recommended)" ; new
global lOptionsFtpEncodingTC := "Encode FTP username and password (not recommended for Total Commander)" ; new
global lOptionsGuiTitle := "Options - ~1~ ~2~" ; new
global lOptionsHotkeyRemindersFull := "Display f&ull names" ; new
global lOptionsHotkeyRemindersNo := "Do not di&splay" ; new
global lOptionsHotkeyRemindersPrompt := "Hotkey reminders in menu:" ; new
global lOptionsHotkeyRemindersShort := "Display a&bbreviated names" ; new
global lOptionsIconSize := "&Menu icons size"
global lOptionsLanguage := "&Language"
global lOptionsLanguageLabels := "English|French|German|Swedish|Spanish|Brazilian Portuguese|Italian|Traditional Chinese|Portuguese|Simplified Chinese" ; removed Dutch|Korean|
global lOptionsMenuActiveWindow := "Top-left of acti&ve window"
global lOptionsMenuFixPosition := "At a fi&x position"
global lOptionsMenuNearMouse := "Near the mouse &pointer"
global lOptionsMenuPositionPrompt := "Popup the menu:"
global lOptionsMouseAndKeyboard := "Menu hotkeys"
global lOptionsOpenMenuOnTaskbar := "&Open menu on taskbar"
global lOptionsOtherOptions := "General"
global lOptionsPopupFixPositionX := "Position X:"
global lOptionsPopupFixPositionY := "Y:"
global lOptionsPopupHotkeyTitles := "Quick Access Popup Mouse button|Quick Access Popup Keyboard shortcut|Alternative Menu Mouse button|Alternative Menu Keyboard shortcut" ; new
global lOptionsPopupHotkeyTitlesSub := "This mouse button pops the menu anywhere (except over <a>excluded applications</a>) and launch your favorite or navigate to your folder.|This hotkey the menu anywhere and launch your favorite or navigate to your folder.|This mouse pops an alternate menu offering various features. This menu can pop anywhere (without exception).|This hotkey pops an alternate menu offering various features. This menu can pop anywhere." ; new
global lOptionsRecentFolders := "Numb&er of folders in menu" ; changed
global lOptionsRecentFoldersPrompt := "Recent Folders:" ; new
global lOptionsRememberSettingsPosition := "Remember &window position"
global lOptionsRunAtStartup := "&Run at Startup"
global lOptionsTabFileManagersIntro := "Select the file manager to use to open folders in a new window." ; changed
global lOptionsTabMouseAndKeyboardIntro := "Define the mouse buttons and keyboard hotkeys that will trigger the ~1~ main menu." ; changed
global lOptionsTabOtherOptionsIntro := "Make ~1~ work the way you like!"
global lOptionsTheme := "&Theme"
global lOptionsThirdParty := "File managers"
global lOptionsThirdPartyDetail := "Select the ~1~ program file (.exe) to enable ~1~ integration."
global lOptionsThirdPartyDetailQAPconnect := "Select your file manager (or edit ~1~ to add it - see help)." ; new
global lOptionsThirdPartyFileNotFound := "~1~ application file ""~2~"" not found." ; new
global lOptionsThirdPartySelectedHelp := "Selected File Manager: ~1~ (<a href=""~2~"">~3~</a>)" ; new
global lOptionsThirdPartySelectFile := "Please, select the ~1~ application file using the ""Browse"" button" ; new
global lOptionsThirdPartyUseTabs := "Use tabs instead of opening in a new window" ; new
global lOptionsTrayTip := "&Display Startup Tray Tip"
global lPickIconNoLocation := "First select a favorite before choosing an icon."
global lReloadPrompt := "~1~ changed to ~2~. Do you want to reload ~3~ in ~2~ now? Unsaved changes to the folders menu will be lost."
global lTCMenuName := "TC Directory hotlist" ; new
global lTCWinCmdLocation := "WinCmd.ini location" ; new
global lTooltipSnippetKeyWait := "Press {~1~} to continue..."
global lTooltipSnippetWaitEnter := "Enter"
global lTooltipSnippetWaitMacro := "Hit ""~1~"" to launch the macro (waiting ~2~ seconds)" ; new
global lTooltipSnippetWaitText := "Select the insertion point and hit ""~1~"" to paste the snippet (waiting ~2~ seconds)" ; new
global lTrayTipInstalledDetail := "~1~ to launch favorites" ; changed
global lTrayTipInstalledTitle := "~1~ ready!"
global lTrayTipWorkingDetail := "Building menus"
global lTrayTipWorkingDetailFinished := "The menu has been updated."
global lTrayTipWorkingTitle := "~1~ working..."
global lUpdateButtonChangeLog := "See change log" ; new
global lUpdateButtonDownloadPortable := "Download Portable zip file" ; new
global lUpdateButtonDownloadSetup := "Download Setup file" ; new
global lUpdateButtonRemind := "Remind me"
global lUpdateButtonSkipVersion := "Skip this version" ; new
global lUpdateButtonVisit := "Visit web site" ; new
global lUpdateError := "An error occurred while accessing the latest version number. Checking for update interrupted."
global lUpdatePrompt := "Update ~1~ from v~2~ to v~3~?"
global lUpdatePromptAlpha := "There is a new ~1~ ALPHA version.`n`nUpdate ~1~ from v~2~ to v~3~?" ; new
global lUpdatePromptAlphaContinue := "Do you still want to to be informed of future alpha versions?" ; new
global lUpdatePromptBeta := "There is a new ~1~ BETA version.`n`nUpdate ~1~ from v~2~ to v~3~?"
global lUpdatePromptBetaContinue := "Do you still want to to be informed of future beta versions?"
global lUpdateTitle := "Update ~1~?"
global lUpdateYouHaveLatest := "You have the latest version: ~1~.`n`nVisit the ~2~ web page anyway?"
global lWindowIsTreeviewText := "Windows limitation..." ; changed
global lWindowIsTreeviewTitle := "Tree view dialog box not supported"
