@echo off
REM Copyright 2018 John de Murga - Licensed under the GPLv2

set TARGET=T:

:: Create an empty dir for clearing directories reliably
rmdir /s /q %~dp0\empty 2> nul
mkdir %~dp0\empty

set WIPEDIR=robocopy /MIR /XJD /XJF /R:1 /W:1 %~dp0\empty
set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

SET DIR_LIST=_home\go _home\npm _home\npm-cache atom git meld go rust 
SET ARC_LIST=^
AtomPortable-Part1-Core.7z ^
AtomPortable-Part2-Addons.7z ^
AtomPortable-Part3-Rust-Nightly.7z ^
AtomPortable-Part4-Go-1.11.beta1-64bit.7z

move %TARGET%\atom\Data\AtomProfile\local-history %TARGET%\local-history

FOR %%G IN (%DIR_LIST%) DO (
	echo Deleting %%G
	%WIPEDIR% %TARGET%\%%G > nul
	rmdir /s /q %TARGET%\%%G 2> nul
)
rmdir /s /q %~dp0\empty 2> nul

FOR %%G IN (%ARC_LIST%) DO (
	echo Unpacking %%G
	%UN7ZIP% %~dp0\packages\%%G -o%TARGET% > nul
)

move %TARGET%\local-history %TARGET%\atom\Data\AtomProfile\local-history
