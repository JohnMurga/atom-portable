@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Generating package list from existing Atom install

cd packages

rmdir /s /q .bin 2> nul

<nul set /p hacktastic=" " > ..\package-list.txt

FOR /D %%G in ("*") DO (
	<nul set /p hacktastic= %%G >> ..\package-list.txt
)

pause
