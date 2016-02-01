@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

set START_DIR=%CD%

cd /d "%~dp0\..\..\git\usr\bin"

FOR /F "tokens=* USEBACKQ" %%F IN (`.\which.exe bash`) DO (
    SET BASH_PATH=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`.\cygpath.exe -w "%BASH_PATH%"`) DO (
    SET BASH_PATH=%%F
)

cd /d "%START_DIR%"

cls

if "%BASH_PATH%" EQU "" (
    if "%ConEmuANSI%" EQU "ON" (
        cmd /k "%~dp0\ConEmu\ConEmu\CmdInit.cmd"
    ) else (
        set PROMPT=%username%@%computername% $p$_^> 
        cmd
    )
) else (
    set PROMPT=%username%@%computername% $p$_^> 
    "%BASH_PATH%" --login -i -s
)
