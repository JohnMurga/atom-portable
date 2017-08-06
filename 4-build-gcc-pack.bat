@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo ------------------------
echo Downloading GCC packages
echo ------------------------

set WGET=cscript /nologo tools\wget.js
set CURL=.\packages\Git\usr\bin\curl.exe -L

::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/4.8.5/threads-posix/sjlj/i686-4.8.5-release-posix-sjlj-rt_v4-rev0.7z" -o ".\\downloads\\gcc.7z"
::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/4.9.3/threads-posix/sjlj/i686-4.9.3-release-posix-sjlj-rt_v4-rev1.7z" -o ".\\downloads\\gcc.7z"
::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/5.3.0/threads-posix/sjlj/i686-5.3.0-release-posix-sjlj-rt_v4-rev0.7z" -o ".\\downloads\\gcc.7z"
::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/6.2.0/threads-posix/sjlj/i686-6.2.0-release-posix-sjlj-rt_v5-rev1.7z" -o ".\\downloads\\gcc.7z"
::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/6.3.0/threads-posix/sjlj/i686-6.3.0-release-posix-sjlj-rt_v5-rev1.7z" -o ".\\downloads\\gcc.7z"
::    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/7.1.0/threads-win32/sjlj/i686-7.1.0-release-win32-sjlj-rt_v5-rev0.7z" -o ".\\downloads\\gcc.7z"

IF NOT EXIST ".\\downloads\\gcc.7z" (
    %CURL% "http://download.sourceforge.net/project/mingw-w64/Toolchains targetting Win32/Personal Builds/mingw-builds/7.1.0/threads-win32/sjlj/i686-7.1.0-release-win32-sjlj-rt_v5-rev1.7z" -o ".\\downloads\\gcc.7z"
) else (
    echo GCC Download already present
)

IF NOT EXIST ".\\downloads\\make.tar.xz" (
    %WGET% "http://repo.msys2.org/msys/i686/make-4.1-4-i686.pkg.tar.xz" ".\\downloads\\make.tar.xz"
) else (
    echo MSys2 MAKE Download already present
)

echo ------------------------
echo Extracting GCC packages
echo ------------------------

RMDIR /S /Q .\packages\gcc 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\gcc.7z -o.\packages > nul
rename .\packages\mingw32 gcc

%UN7ZIP% -so %~dp0\downloads\make.tar.xz | %UN7ZIP% -si -ttar -o.\packages\gcc\make > nul
move /Y .\packages\gcc\make\usr\bin\* .\packages\gcc\bin > nul
RMDIR /S /Q .\packages\gcc\make > nul

echo ------------------------
echo Creating GCC Addon pack
echo ------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-GCC-4.8.5.7z -r .\packages\gcc
