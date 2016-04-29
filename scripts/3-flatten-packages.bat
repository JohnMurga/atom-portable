@echo off
setlocal enabledelayedexpansion

REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo Using the flatten-deps utility to shorten package paths

if "%ATOM_HOME%" equ "" (
	echo ERROR : The ATOM_HOME variable must be set
	exit /b 1
)

if not exist "%ATOM_HOME%\" (
	echo ERROR : "%ATOM_HOME%" is not a valid directory
	exit /b 2
)

cd %ATOM_HOME%

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\node_modules\.bin

set npm_config_loglevel=verbose
set LOG_FILE=%~dp0\..\flatten-log.txt
echo. > %LOG_FILE%
echo See log file here : %LOG_FILE%

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin

call npm --color false install flatten-deps 1>> %LOG_FILE% 2>&1
if !ERRORLEVEL! NEQ 0 (
  echo Install of flatten-deps FAILED !
  exit /b 2
)

set PATH=%PATH%;%ATOM_HOME%\node_modules\.bin

cd packages
rmdir /s /q .bin 2> nul

<nul set /p hacktastic="Flattening : "

FOR /D %%G in ("*") DO (
	cd "%%G"
	<nul set /p hacktastic="%%G "
	call flatten-deps 1>> %LOG_FILE% 2>&1
	if !ERRORLEVEL! NEQ 0 (
		<nul set /p hacktastic="-*FAILED* "
	)
	cd ..
)
echo.

cd ..
rmdir /s /q node_modules 2> nul
