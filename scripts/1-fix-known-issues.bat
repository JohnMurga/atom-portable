@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

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

REM ## atom-ternjs doesn't work after 0.12.2
REM ## So we lock it at this version

cd packages\atom-ternjs

set MYFILE=.\package.json
set FIXSTR="\x22version\x22: \x220.12.2\x22" "\x22version\x22: \x220.13.2\x22"

type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..

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
set FIXSTR="syntax-background-color: #212121" "syntax-background-color: #181818"

type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE% > nul

cd ..\..
