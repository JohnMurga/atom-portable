@echo off
REM Copyright 2014-2017 John de Murga - Licensed under the GPLv2

echo -------------------------
echo Downloading Java packages
echo -------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\jdk.zip" (
    %WGET% "https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.151-1/java-1.8.0-openjdk-1.8.0.151-1.b12.ojdkbuild.windows.x86.zip" ".\\downloads\\jdk.zip"
) else (
    echo JDK Download already present
)

echo ------------------------
echo Extracting Java binaries
echo ------------------------

rmdir /S /Q .\packages\java 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\jdk.zip -o.\packages > nul
move .\packages\java* .\packages\java > nul 2> nul


echo -------------------
echo Setting environment
echo -------------------

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\cmd
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\usr\bin

echo ----------------------
echo Installing Java packages
echo ----------------------

SET PACKAGE_LIST=autocomplete-java linter-javac

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo ----------------------
echo Creating Java Addon pack
echo ----------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part4-Java-1.8.7z -r .\packages\java -x!atom\Data -x!_home\.vimrc -x!git

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% .\packages\AtomPortable-Part4-Java-1.8.7z -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
