@echo off
REM Copyright 2014-2015 John de Murga - Licensed under the GPLv2

echo Downloading required archives

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7za920.zip" ".\\downloads\\7za920.zip"
%WGET% "https://github.com/atom/atom/releases/download/v1.2.0-beta2/atom-windows.zip" ".\\downloads\\atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.6.2.windows.1/PortableGit-2.6.2-32-bit.7z.exe" "downloads\\PortableGit.7z"
