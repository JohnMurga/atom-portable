@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -------------------------
echo Downloading Ruby packages
echo -------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\ruby.7z" (
    %WGET% "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.7.1-1/rubyinstaller-2.7.1-1-x86.7z" ".\\downloads\\ruby.7z"
) else (
    echo Ruby Download already present
)

echo ------------------------
echo Extracting Ruby packages
echo ------------------------

rmdir /S /Q .\packages\ruby 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\ruby.7z -o.\packages > nul
move .\packages\ruby* .\packages\ruby > nul 2> nul

copy .\scripts\Ruby-Portable-Fixer.sh .\packages\ruby\bin

echo ------------------------
echo Creating Ruby Addon pack
echo ------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-Ruby-2.5.3-1.7z -r .\packages\ruby
