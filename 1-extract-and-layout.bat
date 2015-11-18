@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo ------------------------------------------------------
echo Unzipping downloads and preparing "packages" directory
echo ------------------------------------------------------

set UNZIP=cscript /nologo tools\unzip.js
set UN7ZIP=%~dp0\tools\7Zip\7za.exe x -y

%UNZIP% .\downloads\7za920.zip .\tools\7Zip

rmdir /s /q .\packages\Atom 2> nul
rmdir /s /q .\packages\Git 2> nul

%UN7ZIP% %~dp0\downloads\ConEmu.7z -o.\packages\Atom\App\ConEmu > nul
%UN7ZIP% %~dp0\downloads\atom-windows.zip -o.\packages\Atom\App > nul
%UN7ZIP% %~dp0\downloads\PortableGit.7z -o.\packages\Git > nul

move .\packages\Atom\App\Atom* .\packages\Atom\App\Atom > nul 2> nul

set PATH=%PATH%;%~dp0\packages\Atom\App\Atom\resources\app\apm\bin
set PATH=%PATH%;%~dp0\packages\Atom\App\Atom\resources\app\apm\node_modules\.bin

call npm --color false install marked highlight.js > nul 2> nul
call node scripts\renderMarkup.js

xcopy .\template\* .\packages\Atom /s /i > nul

rmdir /s /q node_modules 2> nul
