@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo ---------------------------
echo Downloading Python packages
echo ---------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\python.msi" (
    %WGET% "https://www.python.org/ftp/python/2.7.11/python-2.7.11.msi" ".\\downloads\\python.msi"
) else (
    echo Python Download already present
)

echo ---------------------------
echo Extracting Python packages
echo ---------------------------

rmdir /S /Q .\packages\python 2> nul

msiexec /a %~dp0\downloads\python.msi /qb TARGETDIR=%~dp0\packages\python /quiet

echo ---------------------------
echo Creating Python Addon pack
echo ---------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-Python-2.7.11.7z -r .\packages\python
