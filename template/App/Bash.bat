@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2
set PAL_DataDir=%~dp0\..\Data
set PAL_AppDir=%~dp0\..\App

:: Taken from the Launcher.ini
set ATOM_HOME=%PAL_DataDir%\AtomProfile

set PATH=%PATH%;%PAL_AppDir%
set PATH=%PATH%;%PAL_AppDir%\..\..\git\bin
set PATH=%PATH%;%PAL_AppDir%\..\..\git\cmd
set PATH=%PATH%;%PAL_AppDir%\..\..\nodejs
set PATH=%PATH%;%PAL_AppDir%\..\..\meld
set PATH=%PATH%;%PAL_AppDir%\..\..\python
set PATH=%PATH%;%PAL_AppDir%\..\..\ruby\bin
set PATH=%PATH%;%PAL_AppDir%\..\..\TDM-GCC-32\bin
set PATH=%PATH%;%PAL_AppDir%\Atom\resources\app\apm\bin

set PATH=%PATH%;C:\Program Files (x86)\Python27

set CPATH=%PAL_AppDir%\..\..\git\usr\local\include

cmd /c "" %~dp0\ConEmu.bat
