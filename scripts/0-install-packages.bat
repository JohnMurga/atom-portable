@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Installing BASE set of packages - THIS WILL TAKE SOME TIME

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

set LOG_FILE=%~dp0\..\install-log.txt
echo. > %LOG_FILE%
echo See log file here : %LOG_FILE%

<nul set /p hacktastic="Installing : "

setlocal enabledelayedexpansion

:: If all on one line
::for /F "tokens=* USEBACKQ" %%F in (`type %~dp0\packages.txt`) do (
::	SET PACKAGES=%%F
::)

for /F "tokens=*" %%F in (%~dp0\packages.txt) do (
	SET PACKAGES=!PACKAGES! %%F
)

for %%a in (%PACKAGES%) do (
    SET CURRENT_PACKAGE=%%a
	<nul set /p hacktastic="!CURRENT_PACKAGE! "
	call apm --color false install !CURRENT_PACKAGE! 1>> %LOG_FILE% 2>&1
	if !ERRORLEVEL! NEQ 0 (
		echo RETRYING !CURRENT_PACKAGE! >> %LOG_FILE%
		call apm --color false install !CURRENT_PACKAGE! 1>> %LOG_FILE% 2>&1
		if !ERRORLEVEL! NEQ 0 (
			echo RETRYING !CURRENT_PACKAGE! >> %LOG_FILE%
			call apm --color false install !CURRENT_PACKAGE! 1>> %LOG_FILE% 2>&1
			if !ERRORLEVEL! NEQ 0 (
				<nul set /p hacktastic=" *FAILED* "
				exit /b 3
			)
		)
	)
)
echo.
