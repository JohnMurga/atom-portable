@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7z1602.msi" ".\\downloads\\7Zip.msi"
%WGET% "https://nodejs.org/dist/v4.4.5/node-v4.4.5-x86.msi" ".\\downloads\\node.msi"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\sqlite-lib.tar.xz"
%WGET% "https://download.gnome.org/binaries/win32/meld/3.16/Meld-3.16.0-win32.msi" ".\\downloads\\meld.msi"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v16.06.09/ConEmuPack.160609.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.9.0-beta0/atom-windows.zip" ".\\downloads\\atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.8.4.windows.1/PortableGit-2.8.4-32-bit.7z.exe" "downloads\\PortableGit.7z"
