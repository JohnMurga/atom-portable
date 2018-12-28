@echo off
setlocal enabledelayedexpansion

:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

call %~dp0\setPaths.bat

set PATH=!PATH:%PAL_AppDir%\..\..\git\usr\bin;%PAL_AppDir%\..\..\git\mingw32\bin;=!
cd /D %HOME%
set RUN_DOS=true

cmd /c "" %~dp0\ConEmu.bat

:: If ConEmu isn't installed
::%~dp0\Console.bat
