@echo off
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe" sign /t http://timestamp.digicert.com /f "C:\Dropbox\AutoHotkey\QuickAccessPopup\Setup Script files\Certificat-Sectigo\Certificat-Sectigo.p12" /p Iabdd2019! "%1"
