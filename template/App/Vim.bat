@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

SET SCRIPT_HOME=%~dp0
SET BUFFER=

:loop

set FILE_NAME=%1
set FILE_NAME=%FILE_NAME:\\=\\\\%
set BUFFER=%BUFFER% %FILE_NAME%

shift

if not "%~1"=="" goto loop

call %SCRIPT_HOME%\setPaths.bat

start "" %SCRIPT_HOME%\ConEmu\ConEmu.exe /loadcfgfile %SCRIPT_HOME%\ConEmu.xml /cmd %SCRIPT_HOME%\..\..\git\usr\bin\vim.exe %BUFFER%
