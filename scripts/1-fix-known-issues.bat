@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

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

set REPLACE=cscript /nologo %~dp0\..\tools\replace.js

REM ## clipboard-plus has a GIT package reference
REM ## This prevents package flattening, so we fix it

cd packages\clipboard-plus

move .\node_modules\@aki77\atom-select-action .\node_modules\atom-select-action > nul

set MYFILE=.\lib\clipboard-list-view.coffee
set FIXSTR="@aki77/atom-select-action" "atom-select-action"

type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..

REM ## The tomorrow-night-eighties-syntax ... Is not dark enough

cd packages\tomorrow-night-eighties-syntax 

set MYFILE=.\styles\colors.less
set FIXSTR="@background: #2d2d2d;" "@background: #181818;"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..

REM ## The atom-material-syntax-dark ... Is not dark enough

cd packages\atom-material-syntax-dark 

set MYFILE=.\styles\colors.less
set FIXSTR="@light-gray:        #B2CCD6;" "@light-gray:        #B5B5B5;"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul
set FIXSTR="@gray:              #373b41;" "@gray:              #353535;"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul
set FIXSTR="@dark-gray:         #282a2e;" "@dark-gray:         #252525;"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul
set FIXSTR="@very-dark-gray:    #212121;" "@very-dark-gray:    #151515;"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

set MYFILE=.\styles\syntax-variables.less
set FIXSTR="very-dark-gray, 20" "very-dark-gray, 35"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..

REM ## Fixes for packages with open pull requests
COPY /Y %~dp0\patch\highlight-column-element.coffee packages\highlight-column\lib
