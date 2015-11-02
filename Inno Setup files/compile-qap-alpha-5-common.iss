#define MyAppName "Quick Access Popup"
#define MyAppNameLower "quickaccesspopup"
#define MyAppPublisher "Jean Lalonde"
#define MyAppURL "http://wwww.QuickAccessPopup.com"
#define MyAppExeName "QuickAccessPopup.exe"
#define FPImportVersionFileName "ImportFPsettings-0_4-ALPHA.exe"

#define MyAppVersion "v6.1.5 ALPHA"
#define MyVersionFileName "6_1_5-alpha"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{BE9D760B-0D64-40BD-9F24-B5B8AB90131B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=C:\Dropbox\AutoHotkey\QuickAccessPopup\Inno Setup files\licence.txt
OutputDir=C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\
OutputBaseFilename={#MyAppNameLower}-setup-alpha
SetupIconFile=C:\Dropbox\AutoHotkey\QuickAccessPopup\qap-white-rounded-512.ico
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
AppMutex={#MyAppName}Mutex

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
; Name: "french"; MessagesFile: "compiler:Languages\French.isl"
; Name: "german"; MessagesFile: "compiler:Languages\German.isl"
; Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
; Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl"
; Name: "swedish"; MessagesFile: "compiler:Languages\Swedish.isl"
; Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
; Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
; Name: "brazilportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Dirs]
; repository for files to be copied to "{userappdata}\{#MyAppName}" at first QAP execution with quickaccesspopup.ini and _temp subfolder
Name: "{commonappdata}\{#MyAppName}" 

[Files]
Source: "C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\QuickAccessPopup-{#MyVersionFileName}-64-bit.exe"; DestDir: "{app}"; DestName: "QuickAccessPopup.exe"; Check: IsWin64; Flags: 64bit ignoreversion
; Source: "C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\QuickAccessPopup-{#MyVersionFileName}-32-bit.exe"; DestDir: "{app}"; DestName: 
Source: "C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\{#FPImportVersionFileName}"; DestDir: "{app}"; DestName: "ImportFPsettings.exe"
Source: "C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\QAPconnect.ini"; DestDir: "{commonappdata}\{#MyAppName}"; DestName: "QAPconnect.ini"
Source: "C:\Dropbox\AutoHotkey\QuickAccessPopup\build-alpha\_do_not_remove_or_rename.txt"; DestDir: "{app}"; DestName: "_do_not_remove_or_rename.txt"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[INI]
Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "EN"; Languages: english
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "FR"; Languages: french
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "DE"; Languages: german
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "NL"; Languages: dutch
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "KO"; Languages: korean
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "SV"; Languages: swedish
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "IT"; Languages: italian
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "ES"; Languages: spanish
; Filename: "{commonappdata}\{#MyAppName}\{#MyAppNameLower}-setup.ini"; Section: "Global"; Key: "LanguageCode"; String: "PT-BR"; Languages: brazilportuguese

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{commonappdata}\{#MyAppName}"
Name: "{group}\Import Folders Popup Settings"; Filename: "{app}\ImportFPsettings.exe"; WorkingDir: "{commonappdata}\{#MyAppName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\ImportFPsettings.exe"; Flags: runhidden waituntilterminated; WorkingDir: "{commonappdata}\{#MyAppName}"; Parameters: "/calledfromsetup"; Tasks: importfpsettings
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; WorkingDir: "{commonappdata}\{#MyAppName}"; Flags: waituntilidle postinstall skipifsilent

[Tasks]
Name: importfpsettings; Description: "Import &Folders Popup settings and favorites (only for Folders Popup users)"; Flags: checkedonce

[UninstallDelete]
Type: files; Name: "{userstartup}\{#MyAppName}.lnk"