@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "http://www.7-zip.org/a/7z1700.msi" ".\\downloads\\7Zip.msi"
:: %WGET% "https://nodejs.org/dist/v4.6.0/node-v4.6.0-x86.msi" ".\\downloads\\Node.msi"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\Sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.8.8.2-1-i686.pkg.tar.xz" ".\\downloads\\Sqlite-lib.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/curl-7.53.1-1-i686.pkg.tar.xz" ".\\downloads\\Curl.tar.xz"
%WGET% "http://ftp.gnome.org/mirror/gnome.org/binaries/win32/meld/3.16/Meld-3.16.2-win32.msi" ".\\downloads\\Meld.msi"
%WGET% "https://www.fossil-scm.org/fossil/uv/fossil-w32-2.2.zip" ".\\downloads\\Fossil.zip"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v17.06.05/ConEmuPack.170605.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.18.0/atom-windows.zip" ".\\downloads\\Atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.13.0.windows.1/PortableGit-2.13.0-32-bit.7z.exe" "downloads\\PortableGit.7z"
%WGET% "https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim" ".\\downloads\\.vimrc"
