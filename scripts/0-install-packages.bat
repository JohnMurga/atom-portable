@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Installing BASE set of packages

if "%ATOM_HOME%" equ "" (
	echo ERROR : The ATOM_HOME variable must be set
	exit /b 1
)

if not exist "%ATOM_HOME%\" (
	echo ERROR : "%ATOM_HOME%" is not a valid directory
	exit /b 2
)

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin

set ATOM_HOME=%ATOM_HOME%
set npm_config_loglevel=verbose

<nul set /p hacktastic=call apm install > .tmp.bat
type %~dp0\packages.txt >> .tmp.bat
cmd /c  .tmp.bat > nul
del  .tmp.bat
