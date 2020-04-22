@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------------
echo Downloading required archives
echo -----------------------------

rmdir /s /q downloads 2> nul
mkdir downloads 2> nul

set WGET=cscript /nologo tools\wget.js

%WGET% "https://www.7-zip.org/a/7z1900.msi" ".\\downloads\\7Zip.msi"
%WGET% "http://repo.msys2.org/msys/i686/rsync-3.1.3-1-i686.pkg.tar.xz" ".\\downloads\\RSync.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/sqlite-3.21.0-4-i686.pkg.tar.xz" ".\\downloads\\Sqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libsqlite-3.21.0-4-i686.pkg.tar.xz" ".\\downloads\\libsqlite.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/libevent-2.1.8-1-i686.pkg.tar.xz" ".\\downloads\\libevent.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/tmux-2.7-1-i686.pkg.tar.xz" ".\\downloads\\tmux.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/zsh-5.5.1-1-i686.pkg.tar.xz" ".\\downloads\\zsh.tar.xz"
%WGET% "http://repo.msys2.org/msys/i686/xz-5.2.4-1-i686.pkg.tar.xz" ".\\downloads\\xz.tar.xz"
%WGET% "https://github.com/Kitware/CMake/releases/download/v3.16.5/cmake-3.16.5-win32-x86.zip" ".\\downloads\\CMake.zip"
%WGET% "https://graphviz.gitlab.io/_pages/Download/windows/graphviz-2.38.zip" ".\\downloads\\graphviz.zip"
%WGET% "http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.0.10-2-portable-Q16-x86.zip" ".\\downloads\\ImageMagick.zip"
:: FFMpeg included in ImageMagick
:: %WGET% "https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-4.2.2-win32-static.zip" ".\\downloads\\ffmpeg.zip"
%WGET% "https://yt-dl.org/latest/youtube-dl.exe" ".\\downloads\\youtube-dl.exe"
%WGET% "https://mirrors.ustc.edu.cn/gnome/binaries/win32/meld/3.20/Meld-3.20.2-mingw.msi" ".\\downloads\\Meld.msi"
%WGET% "https://www.fossil-scm.org/home/uv/fossil-w32-2.9.zip" ".\\downloads\\Fossil.zip"
%WGET% "https://github.com/Maximus5/ConEmu/releases/download/v19.10.12/ConEmuPack.191012.7z" ".\\downloads\\ConEmu.7z"
%WGET% "https://github.com/VSCodium/vscodium/releases/download/1.44.2/VSCodium-win32-ia32-1.44.2.zip" ".\\downloads\\VsCodium.zip"
%WGET% "https://github.com/atom/atom/releases/download/v1.46.0-beta0/atom-windows.zip" ".\\downloads\\Atom-windows.zip"
%WGET% "https://github.com/git-for-windows/git/releases/download/v2.26.2.windows.1/PortableGit-2.26.2-32-bit.7z.exe" "downloads\\PortableGit.7z"
%WGET% "https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim" ".\\downloads\\.vimrc"
