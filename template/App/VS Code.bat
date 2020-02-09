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

if "%BUFFER%"==" \\=\\\\" (
    set BUFFER=
)

call %SCRIPT_HOME%\setPaths.bat

start %SCRIPT_HOME%\..\..\VsCodium\VSCodium.exe --extensions-dir %HOME%/.VsCode/extensions --user-data-dir %HOME%/.VsCode %BUFFER%
exit /B
