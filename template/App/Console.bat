@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

set START_DIR=%CD%

:: Fix/hack for uname behavior affecting make/configure (MSYS vs MINGW)
set MSYSTEM=MINGW-W32

cd /d "%~dp0\..\..\git\usr\bin"

FOR /F "tokens=* USEBACKQ" %%F IN (`.\which.exe .\bash`) DO (
    SET BASH_PATH=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`.\cygpath.exe -w "%BASH_PATH%"`) DO (
    SET BASH_PATH=%%F
)

cd /d "%START_DIR%"
set START_SHELL=call start "" /B /W /D "%START_DIR%"

cls

if "%BASH_PATH%" EQU "" (
    if "%ConEmuANSI%" EQU "ON" (
        %START_SHELL% cmd /k "%~dp0\ConEmu\ConEmu\CmdInit.cmd"
    ) else (
        set PROMPT=%username%@%computername% $p$_^> 
        %START_SHELL% cmd
    )
) else (
    set PROMPT=%username%@%computername% $p$_^> 
    %START_SHELL% "%BASH_PATH%" --login -i -s
)

exit
