@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Setting Atom up with some cool default packages

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

cmd /c scripts\0-install-packages.bat
cmd /c scripts\1-fix-known-issues.bat
cmd /c scripts\2-optimize-packages.bat
cmd /c scripts\3-flatten-packages.bat
