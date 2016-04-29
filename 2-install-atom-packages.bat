@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo ------------------------------------------
echo Setting up Atom with some default packages
echo ------------------------------------------

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

setlocal enabledelayedexpansion

cmd /c scripts\0-install-packages.bat
if !ERRORLEVEL! NEQ 0 (exit /b)

echo Calculating max path length from current after package install
call scripts\free-drive FREE_DRIVE
subst %FREE_DRIVE%: .\packages\Atom
robocopy /e %FREE_DRIVE%: ..\dummy /MIR /FP /NC /NS /NDL /NJH /NJS /L | cscript /nologo .\tools\maxLen.js

cmd /c scripts\1-fix-known-issues.bat
if !ERRORLEVEL! NEQ 0 (exit /b)
cmd /c scripts\2-optimize-packages.bat
if !ERRORLEVEL! NEQ 0 (exit /b)
cmd /c scripts\3-flatten-packages.bat
if !ERRORLEVEL! NEQ 0 (exit /b)

echo Calculating max path length from current after package flatten
robocopy /e %FREE_DRIVE%: ..\dummy /MIR /FP /NC /NS /NDL /NJH /NJS /L | cscript /nologo .\tools\maxLen.js

subst %FREE_DRIVE%: /D > nul
