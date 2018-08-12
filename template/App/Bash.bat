@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

call %~dp0\setPaths.bat
cd /D %HOME%

:: Remove ConEmu biaries for now
:: cmd /c "" %~dp0\ConEmu.bat

:: Execute MinTTY instead
start "" mintty --title "Bash window" --size 140,40 %~dp0\Console.bat
