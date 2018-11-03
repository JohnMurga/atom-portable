@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

set PAL_DataDir=%~dp0\..\Data
set PAL_AppDir=%~dp0\..\App

:: Done before as it sets "Home"
if exist "%PAL_AppDir%\..\..\python\scripts\env.bat" (
    call %PAL_AppDir%\..\..\python\scripts\env.bat
)

:: Make sure all environment is set
set ATOM_HOME=%PAL_DataDir%\AtomProfile

set HOME=%PAL_AppDir%\..\..\_home

set NPM_CONFIG_prefix=%HOME%\npm
set NPM_CONFIG_userconfig=%HOME%\.npmrc
set NPM_CONFIG_init-module=%HOME%\.npm-init.js
set NPM_CONFIG_cache=%HOME%\npm-cache

set GOROOT=%PAL_AppDir%\..\..\go\.install
set GOPATH=%PAL_AppDir%\..\..\go\.packages;%PAL_AppDir%\..\..\_home\go
set GOBIN=%PAL_AppDir%\..\..\go\.packages\bin

set CARGO_HOME=%PAL_AppDir%\..\..\rust\.cargo
set RUSTUP_HOME=%PAL_AppDir%\..\..\rust\.rustup

set JAVA_HOME=%PAL_AppDir%\..\..\java
set _JAVA_OPTIONS=-Duser.home=%PAL_AppDir%\..\..\_home

set GRADLE_OPTS=-Xmx512m
set GRADLE_USER_HOME=%PAL_AppDir%\..\..\_home\.gradle

set ANDROID_HOME=%PAL_AppDir%\..\..\android
set ANDROID_SDK_HOME=%PAL_AppDir%\..\..\android

set MYPATH=%PAL_AppDir%
set MYPATH=%MYPATH%;%HOME%\npm
set MYPATH=%MYPATH%;%PAL_AppDir%\Atom\resources\app\apm\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\cmd
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\usr\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\git\mingw32\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\meld
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\ruby\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\gcc\bin
set MYPATH=%MYPATH%;%CARGO_HOME%\bin;%RUSTUP_HOME%\toolchains\stable-i686-pc-windows-gnu\bin
set MYPATH=%MYPATH%;%GOROOT%\bin;%GOBIN%
set MYPATH=%MYPATH%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
set MYPATH=%MYPATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\android\android-studio\gradle\gradle-3.2\bin
set MYPATH=%MYPATH%;%PAL_AppDir%\..\..\nim\bin
set MYPATH=%MYPATH%;%HOME%\.nimble\bin

set PATH=%MYPATH%;%PATH%

set CPATH=%PAL_AppDir%\..\..\git\usr\local\include
