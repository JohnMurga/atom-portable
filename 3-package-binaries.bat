@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo --------------------------------------------------
echo Clean and package AtomPortable as 7z and ZIP files
echo --------------------------------------------------

rmdir /s /q .\packages\Atom\Data\AtomProfile\.apm 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\.node-gyp 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\local-history 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\local-storage 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\storage 2> nul
del   /f /q .\packages\Atom\Data\AtomProfile\config.cson.bak 2> nul

:: Keep the compile cache if present
REM rmdir /s /q .\packages\Atom\Data\AtomProfile\compile-cache 2> nul

echo Creating .\packages\AtomPortable.7z ... PLEASE WAIT
%~dp0\tools\7Zip\7za.exe a -t7z -m0=lzma -mx=9 -mmc=512 -mfb=256 -md=84m -ms=on -r .\packages\AtomPortable-Windows.7z .\packages\Atom\*  > nul

:: echo Creating smallest possible .\packages\AtomPortable.zip ...
:: %~dp0\tools\7Zip\7za.exe a -mm=Deflate -mfb=256 -mpass=15 -r .\packages\AtomPortable-Windows.zip .\packages\Atom\* > nul
