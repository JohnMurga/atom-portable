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

REM ## The atom-material-syntax-dark ... Is not dark enough

cd packages\atom-material-syntax-dark 

set MYFILE=.\styles\syntax-variables.less
set FIXSTR="syntax-background-color: #212121" "syntax-background-color: #141414"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

set MYFILE=.\styles\syntax-variables.less
set FIXSTR="syntax-comment-color: #444" "syntax-comment-color: #6b6b6b"
type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..

REM ## Fix for Python Windows OS detection
COPY /Y %~dp0\patch\read-arch.bat packages\autocomplete-python\node_modules\kite-installer\lib\support

REM ## Fix for TypeScript beta on Windows
COPY /Y %~dp0\patch\fs.js packages\atom-typescript-beta\dist\main\atom\utils
