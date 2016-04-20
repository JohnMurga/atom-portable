@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7z1514.msi" ".\\downloads\\7Zip.msi"
%WGET% "https://nodejs.org/dist/v4.4.3/node-v4.4.3-x86.msi" ".\\downloads\\node.msi"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.10.0.0-1-i686.pkg.tar.xz" ".\\downloads\\sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.10.0.0-1-i686.pkg.tar.xz" ".\\downloads\\sqlite-lib.tar.xz"
%WGET% "http://gnome.mirrors.pair.com/pub/gnome/binaries/win32/meld/3.14/Meld-3.14.2-win32.msi" ".\\downloads\\meld.msi"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v16.04.16/ConEmuPack.160416.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.7.2/atom-windows.zip" ".\\downloads\\atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.8.1.windows.1/PortableGit-2.8.1-32-bit.7z.exe" "downloads\\PortableGit.7z"
