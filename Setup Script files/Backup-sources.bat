@ECHO OFF
ECHO Create ZIP file for QAP_source_%QAPVERSIONPREV%.zip
SET AHK_SOURCE_DIR=C:\Dropbox\AutoHotkey
SET DEST_DIR=C:\Dropbox\AutoHotkey\QuickAccessPopup\Build-v8\Sources_backups
ECHO Add AHK source files
CD %AHK_SOURCE_DIR%
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\*.ahk
ping 127.0.0.1 -n 1 > nul
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" EDD\*.ahk
ping 127.0.0.1 -n 1 > nul
ECHO Add translation files
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??.txt
ping 127.0.0.1 -n 1 > nul
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??-??.txt
ECHO Copying sources to ZIP file terminated
