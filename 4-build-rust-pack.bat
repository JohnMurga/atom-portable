@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo ------------------------
echo Downloading Rust packages
echo ------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\rust.msi" (
    %WGET% "https://static.rust-lang.org/dist/rust-1.8.0-i686-pc-windows-gnu.msi" ".\\downloads\\rust.msi"
) else (
    echo Rust Download already present
)

echo ------------------------
echo Extracting Rust packages
echo ------------------------

rmdir /S /Q .\packages\rust 2> nul

msiexec /a %~dp0\downloads\rust.msi /qb TARGETDIR=%~dp0\packages /quiet
rename %~dp0\packages\Rust rust  > nul
del %~dp0\packages\rust*.msi > nul

echo ------------------------
echo Creating Rust Addon pack
echo ------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-Rust-1.8.0.7z -r .\packages\rust
