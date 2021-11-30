@ECHO OFF
ECHO Create ZIP file for QAP_source_%QAPVERSION%.zip
SET AHK_SOURCE_DIR=C:\Dropbox\AutoHotkey
SET DEST_DIR=C:\Dropbox\AutoHotkey\QuickAccessPopup\Build-v8\Sources_backups
ECHO Add AHK source files
CD %AHK_SOURCE_DIR%
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%-Code.zip" QuickAccessPopup\*.ahk
ping 127.0.0.1 -n 1 > nul
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%-EDD.zip" EDD\*.ahk
ping 127.0.0.1 -n 1 > nul
ECHO Add translation files (part 1)
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%-Lang_A.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??.txt
ping 127.0.0.1 -n 5 > nul
ECHO Add translation files (part 2)
"C:\Program Files\7-Zip\7z.exe" a -bso0 "%DEST_DIR%\QAP_source_%QAPVERSION%-Lang_B.zip" QuickAccessPopup\FileInstall\QuickAccessPopup_LANG_??-??.txt
ECHO Copying sources to ZIP file terminated
