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

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\gcc\bin
:: Check for GCC ?
where gcc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo GCC wasn't found and is required for building cargo-web
    exit
)

echo -------------------------
echo Getting Rust distribution
echo -------------------------

set CHOSEN_TOOLCHAIN=stable-i686-pc-windows-gnu

set CARGO_HOME=%~dp0\packages\rust\.cargo
set RUSTUP_HOME=%~dp0\packages\rust\.rustup
set PATH=%CARGO_HOME%\bin;%RUSTUP_HOME%\toolchains\%CHOSEN_TOOLCHAIN%\bin;%PATH%

md %CARGO_HOME%\bin
copy .\\downloads\\rustup.exe %CARGO_HOME%\bin

rustup -v default %CHOSEN_TOOLCHAIN%
rustup -v component add rust-src
rustup -v target add wasm32-unknown-unknown
rustup show

:: R
:: rustup -v toolchain install nightly
:: cargo +nightly install rls
:: rustup -v toolchain remove nightly

cargo install -f cargo-web
cargo install --git https://github.com/alexcrichton/wasm-gc

echo ------------------------
echo Installing Rust packages
echo ------------------------

SET PACKAGE_LIST=ide-rust atom-ide-ui

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo --------------------------
echo Cleaning Cargo directories
echo --------------------------

rmdir /s /q .\packages\rust\.cargo\registry
rmdir /s /q .\packages\rust\.cargo\git

echo ------------------------
echo Creating Rust Addon pack
echo ------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part3-Rust-%CHOSEN_TOOLCHAIN%.7z -r .\packages\rust

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% .\packages\AtomPortable-Part3-Rust-%CHOSEN_TOOLCHAIN%.7z -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
