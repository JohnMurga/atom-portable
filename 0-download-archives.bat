@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7za920.zip" ".\\downloads\\7za920.zip"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v16.01.11/ConEmuPack.160111.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.5.0-beta0/atom-windows.zip" ".\\downloads\\atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.7.0.windows.1/PortableGit-2.7.0-32-bit.7z.exe" "downloads\\PortableGit.7z"
