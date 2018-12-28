@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

IF DEFINED MYPATH GOTO RUN_TERM

call %~dp0\setPaths.bat
cd /D %HOME%

:RUN_TERM
cmd /c "" %~dp0\ConEmu.bat

:: If you want to execute MinTTY instead
:: mintty --title "Bash window" --size 140,40 %~dp0\Console.bat
