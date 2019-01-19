@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "https://www.7-zip.org/a/7z1806.msi" ".\\downloads\\7Zip.msi"
%WGET% "http://repo.msys2.org/msys/i686/rsync-3.1.3-1-i686.pkg.tar.xz" ".\\downloads\\RSync.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.21.0-4-i686.pkg.tar.xz" ".\\downloads\\Sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.21.0-4-i686.pkg.tar.xz" ".\\downloads\\libsqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libevent-2.1.8-1-i686.pkg.tar.xz" ".\\downloads\\libevent.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/tmux-2.7-1-i686.pkg.tar.xz" ".\\downloads\\tmux.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/zsh-5.5.1-1-i686.pkg.tar.xz" ".\\downloads\\zsh.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/xz-5.2.4-1-i686.pkg.tar.xz" ".\\downloads\\xz.tar.xz"
%WGET% "https://mirrors.ustc.edu.cn/gnome/binaries/win32/meld/3.20/Meld-3.20.0-mingw.msi" ".\\downloads\\Meld.msi"
%WGET% "https://fossil-scm.org/index.html/uv/fossil-w32-2.7.zip" ".\\downloads\\Fossil.zip"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v19.01.08/ConEmuPack.190108.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/atom/atom/releases/download/v1.35.0-beta0/atom-windows.zip" ".\\downloads\\Atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/PortableGit-2.20.1-32-bit.7z.exe" "downloads\\PortableGit.7z"
%WGET% "https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim" ".\\downloads\\.vimrc"
