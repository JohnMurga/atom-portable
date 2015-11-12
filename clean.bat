@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo ----------------------------------------
echo Cleaning everything except the downloads
echo ----------------------------------------

rmdir /s /q empty 2> nul
mkdir empty
robocopy empty .\packages /MIR /XJD /XJF /R:1 /W:1 > nul
rmdir /s /q empty 2> nul

rmdir /s /q .\tools\7Zip 2> nul

del *-log.txt 2> nul
del .tmp.bat 2> nul
