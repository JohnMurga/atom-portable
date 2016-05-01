@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2
set PAL_DataDir=%~dp0\..\Data
set PAL_AppDir=%~dp0\..\App

:: Taken from the Launcher.ini
set ATOM_HOME=%PAL_DataDir%\AtomProfile

set HOME=%PAL_DataDir%\Home

set NPM_CONFIG_prefix=%PAL_DataDir%\Home\npm
set NPM_CONFIG_userconfig=%PAL_DataDir%\Home\.npmrc
set NPM_CONFIG_init-module=%PAL_DataDir%\Home\.npm-init.js
set NPM_CONFIG_cache=%PAL_DataDir%\Home\npm-cache

set MYPATH=%PAL_AppDir%
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\cmd
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\nodejs
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\meld
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\python
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\ruby\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\gcc\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\rust\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\Atom\resources\app\apm\bin

set PATH=%MYPATH%;%PATH%

set CPATH=%PAL_AppDir%\..\..\git\usr\local\include

cmd /c "" %~dp0\ConEmu.bat
