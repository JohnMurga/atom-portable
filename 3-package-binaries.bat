@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Clean and package AtomPortable as 7z and ZIP files

rmdir /s /q .\packages\Atom\Data\AtomProfile\.apm 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\.node-gyp 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\compile-cache 2> nul

echo Creating .\packages\AtomPortable.7z ...
%~dp0\tools\7Zip\7za.exe a -t7z -m0=lzma -mx=9 -mfb=256 -md=64m -ms=on -r .\packages\AtomPortable-Windows.7z .\packages\Atom\* > nul

echo Creating .\packages\AtomPortable.zip ...
%~dp0\tools\7Zip\7za.exe a -mm=Deflate -mfb=256 -mpass=15 -r .\packages\AtomPortable-Windows.zip .\packages\Atom\* > nul
