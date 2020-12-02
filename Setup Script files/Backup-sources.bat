@ECHO OFF
ECHO Create ZIP file for QAP_source_%QAPVERSIONPREV%.zip
SET AHK_SOURCE_DIR=C:\Dropbox\AutoHotkey
SET DEST_DIR=C:\Dropbox\AutoHotkey\QuickAccessPopup\Build-v8\Sources_backups
ECHO Add AHK source files
CD %AHK_SOURCE_DIR%
7z a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\*.ahk
7z a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" EDD\*.ahk
ECHO Add translation files
7z a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??.txt
7z a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??-??.txt
ECHO Copying sources to ZIP file terminated
