@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Running basic NPM optimization before we do anything else

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
set npm_config_loglevel=verbose

cd packages
rmdir /s /q .bin 2> nul

FOR /D %%G in ("*") DO (
	cd "%%G"
	echo * %%G *
	call apm dedupe > nul
	cd ..
)
