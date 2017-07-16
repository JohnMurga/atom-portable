@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

call %~dp0\setPaths.bat

cd /D %HOME%

:: cmd /c "" %~dp0\ConEmu.bat
start "" mintty --size 140,40 tmux
