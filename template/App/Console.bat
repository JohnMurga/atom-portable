@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

FOR /F "tokens=* USEBACKQ" %%F IN (`where bash`) DO (
	SET BASH_PATH=%%F
)

cls

if "%BASH_PATH%" EQU "" (
    call start "" /B /W /D "%CD%" cmd /k "%~dp0\ConEmu\ConEmu\CmdInit.cmd"
) else (
    call start "" /B /W /D "%CD%" "%BASH_PATH%" --login -i -s
)

exit
