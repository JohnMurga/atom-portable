@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo --------------------------------------------------
echo Clean and package AtomPortable as 7z and ZIP files
echo --------------------------------------------------

rmdir /s /q .\packages\Atom\Data\AtomProfile\.apm 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\.node-gyp 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\local-history 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\local-storage 2> nul
rmdir /s /q .\packages\Atom\Data\AtomProfile\storage 2> nul
del   /f /q .\packages\Atom\Data\AtomProfile\config.cson.bak 2> nul

echo Performing BASH fixups
.\packages\Git\bin\bash.exe -e scripts\bash-fixups.sh

echo Copying launchers
copy .\tools\Launchers\*.exe .\packages

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -m0=lzma2 -mmt=3 -mlc=4 -myx=9 -mmc=65536 -mfb=273 -md=128m -ms=on

echo Creating .\packages\AtomPortable-Part1-Core.7z ... PLEASE WAIT
del .\packages\AtomPortable-Part1-Core.7z 2> nul
%PACK% .\packages\AtomPortable-Part1-Core.7z .\packages\Atom.exe > nul
%PACK% .\packages\AtomPortable-Part1-Core.7z .\packages\Atom

echo Creating .\packages\AtomPortable-Part2-Addons.7z ... PLEASE WAIT
del .\packages\AtomPortable-Part2-Addons.7z 2> nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\_home > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\Bash.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\Meld.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\Vim.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\VsCodium.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\TMux.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\Shortcuts.exe > nul
%PACK% .\packages\AtomPortable-Part2-Addons.7z .\packages\git .\packages\meld -x!atom\App 

:: ** For use on 8GB+ machines with and recent versions of 64Bit 7Zip **
:: %~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma2 -mlc=4 -myx=9 -mmc=65536 -mfb=273 -md=580m -ms=on -r

:: ** For creating the tightest possible ZIP files **
:: echo Creating smallest possible .\packages\AtomPortable.zip ...
:: %~dp0\tools\7Zip\7za.exe a -mm=Deflate -mfb=256 -mpass=15 -r
