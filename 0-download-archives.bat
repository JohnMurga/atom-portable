@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7z1514.msi" ".\\downloads\\7Zip.msi"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v16.03.29/ConEmuPack.160329.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.6.1/atom-windows.zip" ".\\downloads\\atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.7.4.windows.1/PortableGit-2.7.4-32-bit.7z.exe" "downloads\\PortableGit.7z"
%WGET% "http://llvm.org/releases/3.8.0/LLVM-3.8.0-win32.exe" ".\\downloads\\LLVM.7z"
