@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Using the flatten-packages utility to shorten package paths

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

call npm install flatten-packages > nul
set PATH=%PATH%;%ATOM_HOME%\..\..\Data\AtomProfile\node_modules\.bin

cd packages
rmdir /s /q .bin 2> nul

FOR /D %%G in ("*") DO (
	cd "%%G"
	echo * %%G *
	call flatten-packages
	cd ..
)

cd ..
rmdir /s /q node_modules 2> nul
