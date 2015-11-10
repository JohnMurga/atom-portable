@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Cleaning everything except the downloads

rmdir /s /q empty 2> nul
mkdir empty
robocopy empty .\packages /MIR /XJD /XJF /R:1 /W:1 > nul
rmdir /s /q empty 2> nul

rmdir /s /q .\tools\7Zip 2> nul

del *-log.txt
