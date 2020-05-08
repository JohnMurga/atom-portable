@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

cmd /c clean.bat

echo ------------------------------------------------------
echo Unzipping downloads and preparing "packages" directory
echo ------------------------------------------------------

set UNZIP=cscript /nologo tools\unzip.js
set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

msiexec /a %~dp0\downloads\7Zip.msi /qb TARGETDIR=%~dp0\tools\7Zip /quiet
move %~dp0\tools\7Zip\Files\7-Zip\* %~dp0\tools\7Zip > nul
rmdir /s /q %~dp0\tools\7Zip\File 2> nul

:: msiexec /a %~dp0\downloads\Node.msi /qb TARGETDIR=%~dp0\packages\node_tmp /quiet
:: move %~dp0\packages\node_tmp\nodejs %~dp0\packages\nodejs  > nul
:: rmdir /s /q %~dp0\packages\node_tmp 2> nul

msiexec /a %~dp0\downloads\Meld.msi /qb TARGETDIR=%~dp0\packages\meld /quiet

%UN7ZIP% %~dp0\downloads\ConEmu.7z -o.\packages\atom\App\ConEmu > nul
%UN7ZIP% %~dp0\downloads\Atom-windows.zip -o.\packages\atom\App > nul
%UN7ZIP% %~dp0\downloads\PortableGit.7z -o.\packages\git > nul
%UN7ZIP% %~dp0\downloads\Fossil.zip -o.\packages\git\usr\bin > nul

%UN7ZIP% %~dp0\downloads\VsCodium.zip -o.\packages\VsCodium > nul

mkdir .\packages\_home

%UN7ZIP% -so %~dp0\downloads\Sqlite.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\libsqlite.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\libevent.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\zsh.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\RSync.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\xz.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul
%UN7ZIP% -so %~dp0\downloads\zstd.tar.xz | %UN7ZIP% -si -ttar -o.\packages\git > nul

.\packages\git\usr\bin\zstdcat.exe %~dp0\downloads\tmux.tar.zst | %UN7ZIP% -si -ttar -o.\packages\git > nul

del .\packages\git\.* > nul

%UN7ZIP%  %~dp0\downloads\CMake.zip -o.\packages\extract_tmp > nul
move .\packages\extract_tmp\cmake-* .\packages\extract_tmp\tmp_source > nul
xcopy .\packages\extract_tmp\tmp_source .\packages\git\usr /e /i > nul
rmdir /s /q .\packages\extract_tmp 2> nul

%UN7ZIP%  %~dp0\downloads\graphviz.zip -o.\packages\extract_tmp > nul
xcopy .\packages\extract_tmp\release .\packages\git\usr /e /i > nul
rmdir /s /q .\packages\extract_tmp 2> nul

%UN7ZIP%  %~dp0\downloads\ImageMagick.zip -o.\packages\extract_tmp > nul
xcopy .\packages\extract_tmp .\packages\git\usr\bin /e /i > nul
rmdir /s /q .\packages\extract_tmp 2> nul

copy %~dp0\downloads\youtube-dl.exe .\packages\git\usr\bin > nul

move .\packages\atom\App\Atom* .\packages\atom\App\Atom > nul 2> nul

set PATH=%PATH%;%~dp0\packages\atom\App\Atom\resources\app\apm\bin
set PATH=%PATH%;%~dp0\packages\atom\App\Atom\resources\app\apm\node_modules\.bin

call npm --color false install marked highlight.js > nul 2> nul
call node scripts\renderMarkup.js

xcopy .\template\* .\packages\atom /e /i > nul

rmdir /s /q node_modules 2> nul
