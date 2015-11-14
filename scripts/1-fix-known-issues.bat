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

REM ## linter-eslint is known to not work
REM ## So we force the version we know works

call apm install linter-eslint@3.1.1 > nul

REM ## Make it think linter-eslint is at 4.0.0, to avoid update prompts
REM ## Not an issue if other version 3.1.1 get changed in the package.json

cd packages\linter-eslint

set MYFILE=.\package.json
set FIXSTR="\x22version\x22: \x223.1.1\x22" "\x22version\x22: \x225.0.0\x22"

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
