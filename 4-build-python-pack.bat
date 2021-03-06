@echo off
REM Copyright 2014-2017 John de Murga - Licensed under the GPLv2

echo ---------------------------
echo Downloading Python packages
echo ---------------------------

set CURL=.\packages\Git\mingw32\bin\curl.exe -L

set PYTHON_VERSION=3.7.7


IF NOT EXIST ".\\downloads\\python.7z" (
    %CURL% "https://github.com/winpython/winpython/releases/download/2.3.20200319/Winpython32-3.7.7.0dot.exe" -o ".\\downloads\\python.7z"
) else (
    echo Python Download already present
)

echo ---------------------------
echo Extracting Python packages
echo ---------------------------

rmdir /S /Q .\packages\python 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\python.7z -o.\packages > nul

echo -----------
echo Cleaning up
echo -----------

move .\packages\WPy* .\packages\python

echo -------------------
echo Setting environment
echo -------------------

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\cmd
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\usr\bin

echo --------------------------
echo Installing Python packages
echo --------------------------

call .\packages\python\scripts\env.bat
pip install "python-language-server[all]"

SET PACKAGE_LIST=atom-ide-ui ide-python

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo --------------------------
echo Creating Python Addon pack
echo --------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on
set ARCHIVE=.\packages\AtomPortable-Part4-Python-%PYTHON_VERSION%.7z

%PACK% %ARCHIVE% -r .\packages\python -x!atom\Data -x!_home\.vimrc -x!gcc

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% %ARCHIVE% -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
