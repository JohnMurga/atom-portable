@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7z1604.msi" ".\\downloads\\7Zip.msi"
:: %WGET% "https://nodejs.org/dist/v4.6.0/node-v4.6.0-x86.msi" ".\\downloads\\Node.msi"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\Sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\Sqlite-lib.tar.xz"
%WGET% "http://ftp.nara.wide.ad.jp/pub/X11/GNOME/binaries/win32/meld/3.16/Meld-3.16.2-win32.msi" ".\\downloads\\Meld.msi"
%WGET% "https://www.fossil-scm.org/index.html/uv/download/fossil-w32-1.36.zip" ".\\downloads\\Fossil.zip"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v16.10.22/ConEmuPack.161022.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.12.0-beta5/atom-windows.zip" ".\\downloads\\Atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.10.1.windows.1/PortableGit-2.10.1-32-bit.7z.exe" "downloads\\PortableGit.7z"
%WGET% "https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim" ".\\downloads\\.vimrc"
