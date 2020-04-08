rem Check that there is no debug code flag
IF [%CHECKHASHTAGS%] == [1] >NUL find "#####" ..\QuickAccessPopup.ahk && (ECHO Debug code ##### FOUND in QuickAccessPopup.ahk & PAUSE & EXIT) || (ECHO NO debug code flag found)
rem Check if version number is OK in source file
>NUL find "SetVersion %QAPVERSIONNUMBER%" ..\QuickAccessPopup.ahk && (ECHO Version %QAPVERSIONNUMBER% #1 FOUND in QuickAccessPopup.ahk) || (ECHO SetVersion %QAPVERSIONNUMBER% = Version number NOT FOUND in QuickAccessPopup.ahk & PAUSE & EXIT)
>NUL find """%QAPVERSIONNUMBER%""" ..\QuickAccessPopup.ahk && (ECHO Version %QAPVERSIONNUMBER% #2 FOUND in QuickAccessPopup.ahk) || (ECHO "%QAPVERSIONNUMBER%" = Version number NOT FOUND in QuickAccessPopup.ahk & PAUSE & EXIT)
rem Check branch
IF [%QAPBETAPROD%] == [] >NUL find "g_strCurrentBranch := ""prod""" ..\QuickAccessPopup.ahk && (ECHO Branch "prod" OK in QuickAccessPopup.ahk) || (ECHO Branch "prod" NOT FOUND in QuickAccessPopup.ahk & PAUSE & EXIT)
IF [%QAPBETAPROD%] == [-beta] >NUL find "g_strCurrentBranch := ""beta""" ..\QuickAccessPopup.ahk && (ECHO Branch "beta" OK in QuickAccessPopup.ahk) || (ECHO Branch "beta" NOT FOUND in QuickAccessPopup.ahk & PAUSE & EXIT)
IF [%QAPBETAPROD%] == [-alpha] >NUL find "g_strCurrentBranch := ""alpha""" ..\QuickAccessPopup.ahk && (ECHO Branch "alpha" OK in QuickAccessPopup.ahk) || (ECHO Branch "alpha" NOT FOUND in QuickAccessPopup.ahk & PAUSE & EXIT)
rem Check if Language files are available
ECHO Checking language files...
E:\Dropbox\AutoHotkey\QuickAccessPopup\Language\AutoExec-Check4QAPLanguageFilesReady.ahk
rem Set current directory
E:
CD \Dropbox\AutoHotkey\QuickAccessPopup\Build-v8%QAPBETAPROD%\
rem Create or update version variables
SET QAPVERSIONPREV=%QAPVERSIONPREV%%QAPBETAPROD%
SET QAPVERSIONFILE=%QAPVERSION%%QAPBETAPROD%
SET QAPZIPFILE=quickaccesspopup%QAPBETAPROD%
SET QAPZIPFILEVERSION=quickaccesspopup-%QAPVERSIONFILE%
rem Check current version file
IF NOT EXIST "QAP-v%QAPVERSIONPREV%.txt" ECHO QAP-v%QAPVERSIONPREV%.txt INTROUVABLE...
IF EXIST "QAP-v%QAPVERSIONFILE%.txt" ECHO MAIS QAP-v%QAPVERSIONFILE%.txt EXISTE - OK!
rem Compile exe files
ECHO Ahk2Exe-QAP-v8.ahk 32 %QAPBETAPROD%
"E:\Dropbox\AutoHotkey\QuickAccessPopup\Setup Script files\Ahk2Exe-Custom\Ahk2Exe-QAP-v8.ahk" 32 %QAPBETAPROD%
ECHO Ahk2Exe-QAP-v8.ahk 64 %QAPBETAPROD%
"E:\Dropbox\AutoHotkey\QuickAccessPopup\Setup Script files\Ahk2Exe-Custom\Ahk2Exe-QAP-v8.ahk" 64 %QAPBETAPROD%
rem Compile Setup file
ECHO Inno Setup Compile-QAP-v10.iss
"C:\Program Files (x86)\Inno Setup 5\compil32" /cc "E:\Dropbox\AutoHotkey\QuickAccessPopup\Setup Script files\Compile-QAP-v10.iss"
IF %ERRORLEVEL% NEQ 0 ECHO UNE ERREUR EST SURVENUE...
IF %ERRORLEVEL% NEQ 0 PAUSE
IF %ERRORLEVEL% NEQ 0 EXIT
ECHO Copy quickaccesspopup-setup%QAPBETAPROD%.exe
COPY "C:\temp\InnoSetup-OutputDir\quickaccesspopup-setup%QAPBETAPROD%.exe"
ECHO Copy quickaccesspopup-setup-%QAPVERSIONFILE%.exe (for Chocolatey)
COPY "quickaccesspopup-setup%QAPBETAPROD%.exe" "quickaccesspopup-setup-%QAPVERSIONFILE%.exe"
rem Update version file
IF NOT EXIST "QAP-v%QAPVERSIONFILE%.txt" REN "QAP-v%QAPVERSIONPREV%.txt" "QAP-v%QAPVERSIONFILE%.txt"
ECHO Remove previous version and executable files from zip file
7z d -bso0 "%QAPZIPFILE%.zip" QAP-v*.txt QuickAccessPopup-??-bit.exe
ECHO Add new version and executable files to zip file
7z a -bso0 "%QAPZIPFILE%.zip" QAP-v%QAPVERSIONFILE%.txt QuickAccessPopup-??-bit.exe
ECHO Check if ZIP file is good
IF EXIST "*.tmp*" ECHO Erreur dans le fichier ZIP...
IF EXIST "*.tmp*" GOTO:finish
IF [%QAPBETAPROD%] == [] GOTO:messages
ECHO Copy %QAPZIPFILE%.zip to %QAPZIPFILEVERSION%.zip
COPY %QAPZIPFILE%.zip %QAPZIPFILEVERSION%.zip
ECHO Delete previous ZIP file quickaccesspopup-%QAPVERSIONPREV%.zip
IF EXIST quickaccesspopup-%QAPVERSIONPREV%.zip DEL quickaccesspopup-%QAPVERSIONPREV%.zip
:messages
ECHO TERMINE DE v%QAPVERSIONPREV% A v%QAPVERSIONFILE% AVEC SUCCES
IF [%QAPBETAPROD%] == [] GOTO:messagesprod
ECHO COPIER quickaccesspopup-setup-%QAPVERSIONFILE%.exe dans FTP ftp://www.quickaccesspopup/download
ECHO COPIER quickaccesspopup-%QAPVERSIONFILE%.zip dans FTP ftp://www.quickaccesspopup/download
ECHO DEPLACER anciennes versions dans FTP ftp://www.quickaccesspopup/download/archives
GOTO:finish
:messagesprod
ECHO COPIER quickaccesspopup-setup.exe dans FTP ftp://www.quickaccesspopup/download
ECHO COPIER quickaccesspopup.zip dans FTP ftp://www.quickaccesspopup/download
ECHO COPIER quickaccesspopup-setup-%QAPVERSIONFILE%.exe dans FTP ftp://www.quickaccesspopup/download/archives
:finish
PAUSE
