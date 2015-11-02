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

call apm install linter-eslint@3.1.1

cd packages\clipboard-plus

move .\node_modules\@aki77\atom-select-action .\node_modules\atom-select-action

set MYFILE=.\lib\clipboard-list-view.coffee
set FIXSTR="require '@aki77/atom-select-action'" "require 'atom-select-action'"

type %MYFILE% | %REPLACE% %FIXSTR% > %MYFILE%.tmp
move %MYFILE%.tmp %MYFILE%
