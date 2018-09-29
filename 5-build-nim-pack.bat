@echo off
REM Copyright 2014-2018 John de Murga - Licensed under the GPLv2

echo -----------------------
echo Downloading Nim package
echo -----------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\nim.zip" (
    %WGET% "https://nim-lang.org/download/nim-0.19.0_x32.zip" ".\\downloads\\nim.zip"
) else (
    echo Nim Download already present
)

echo -----------------------
echo Extracting Nim binaries
echo -----------------------

rmdir /S /Q .\packages\nim 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\nim.zip -o.\packages > nul
move .\packages\nim-* .\packages\nim > nul 2> nul

echo -----------------------
echo Installing Nim packages
echo -----------------------

SET PACKAGE_LIST=nim

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo -------------------
echo Creating dddon pack
echo -------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part5-Nim-0.19.7z -r .\packages\nim -x!atom\Data -x!_home\.vimrc -x!git

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% .\packages\AtomPortable-Part5-Nim-0.19.7z -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
