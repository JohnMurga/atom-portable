@echo off
REM Copyright 2014-2016 John de Murga - Licensed under the GPLv2

echo -----------------------
echo Downloading Go packages
echo -----------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\go.zip" (
    %WGET% "https://storage.googleapis.com/golang/go1.8.windows-amd64.zip" ".\\downloads\\go.zip"
) else (
    echo Go Download already present
)

echo ----------------------
echo Extracting Go binaries
echo ----------------------

rmdir /S /Q .\packages\go 2> nul

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\go.zip -o.\packages > nul

echo -------------------
echo Installing Go tools
echo -------------------

set GOROOT=%~dp0\packages\go
set GOPATH=%~dp0\packages\_home\go
set GOBIN=%GOPATH%\bin

set PATH=%PATH%;%GOBIN%;%GOROOT%\bin

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\cmd
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\usr\bin

go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/sqs/goreturns
go get -u github.com/nsf/gocode
go get -u github.com/alecthomas/gometalinter
go get -u github.com/zmb3/gogetdoc
go get -u github.com/rogpeppe/godef
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/derekparker/delve/cmd/dlv

echo ----------------------
echo Installing Go packages
echo ----------------------

call apm --color false install go-plus
call apm --color false install hyperclick
call apm --color false install go-signature-statusbar
call apm --color false install go-debug

echo ----------------------
echo Creating Go Addon pack
echo ----------------------

move .\packages\_home\.vimrc .\packages > nul

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part4-Go-1.8-64bit.7z -r .\packages\go .\packages\_home -x!atom\Data -x!_home\.vimrc

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
move %PACKAGES%\hyperclick %MY_TEMP% > nul
move %PACKAGES%\go-plus %MY_TEMP% > nul
move %PACKAGES%\go-signature-statusbar %MY_TEMP% > nul
move %PACKAGES%\go-debug %MY_TEMP% > nul

%PACK% .\packages\AtomPortable-Part4-Go-1.8-64bit.7z -r .\packages\_tmp\atom

rmdir /s /q .\packages\_tmp 2> nul
