@echo off
REM Copyright 2014-2017 John de Murga - Licensed under the GPLv2

echo ------------------------
echo Downloading Rust packages
echo ------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\rustup.exe" (
    %WGET% "https://static.rust-lang.org/rustup/dist/i686-pc-windows-gnu/rustup-init.exe" ".\\downloads\\rustup.exe"
) else (
    echo Rust Download already present
)

echo -------------------
echo Setting environment
echo -------------------

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\cmd
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\usr\bin

echo -------------------------
echo Getting Rust distribution
echo -------------------------

set CARGO_HOME=%~dp0\packages\rust\.cargo
set RUSTUP_HOME=%~dp0\packages\rust\.rustup
set PATH=%CARGO_HOME%\bin;%RUSTUP_HOME%\toolchains\nightly-i686-pc-windows-gnu\bin;%PATH%

.\\downloads\\rustup.exe -v default nightly-i686-pc-windows-gnu
.\\downloads\\rustup.exe -v component add rust-src
.\\downloads\\rustup.exe -v target add wasm32-unknown-unknown
.\\downloads\\rustup.exe show
cargo install racer
cargo install --git https://github.com/alexcrichton/wasm-gc
copy .\\downloads\\rustup.exe %CARGO_HOME%\bin

echo ------------------------
echo Installing Rust packages
echo ------------------------

SET PACKAGE_LIST=racer

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo ------------------------
echo Creating Rust Addon pack
echo ------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-Rust-Nightly.7z -r .\packages\rust

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% .\packages\AtomPortable-Part3-Rust-Nightly.7z -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
