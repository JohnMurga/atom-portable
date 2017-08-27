@echo off
REM Copyright 2014-2017 John de Murga - Licensed under the GPLv2

echo -----------------------
echo Downloading Go packages
echo -----------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\go.zip" (
    %WGET% "https://storage.googleapis.com/golang/go1.9.windows-amd64.zip" ".\\downloads\\go.zip"
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
echo Setting environment
echo -------------------

set ATOM_HOME=%~dp0\packages\Atom\Data\AtomProfile

set PATH=%PATH%;%ATOM_HOME%\..\..\App\Atom\resources\app\apm\bin

set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\bin
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\cmd
set PATH=%PATH%;%ATOM_HOME%\..\..\App\..\..\git\usr\bin

echo -------------------
echo Installing Go tools
echo -------------------

set GOROOT=%~dp0\packages\go
set GOPATH=%~dp0\packages\_home\go
set GOBIN=%GOPATH%\bin

set PATH=%PATH%;%GOBIN%;%GOROOT%\bin

go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/sqs/goreturns
go get -u github.com/nsf/gocode
go get -u github.com/alecthomas/gometalinter
go get -u github.com/zmb3/gogetdoc
go get -u github.com/rogpeppe/godef
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/fatih/gomodifytags
go get -u github.com/derekparker/delve/cmd/dlv

:: Some default packages
go get -u google.golang.org/grpc
go get -u github.com/gopherjs/gopherjs

echo ----------------------
echo Installing Go packages
echo ----------------------

SET PACKAGE_LIST=go-plus go-signature-statusbar go-debug
::SET PACKAGE_LIST=go-plus hyperclick go-signature-statusbar go-debug

FOR %%G IN (%PACKAGE_LIST%) DO (
	call apm --color false install %%G
)

echo ----------------------
echo Creating Go Addon pack
echo ----------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part4-Go-1.9-64bit.7z -r .\packages\go .\packages\_home -x!atom\Data -x!_home\.vimrc

set MY_TEMP=.\packages\_tmp\atom\Data\AtomProfile\packages
set PACKAGES=.\packages\atom\Data\AtomProfile\packages

mkdir %MY_TEMP%
FOR %%G IN (%PACKAGE_LIST%) DO (
	move %PACKAGES%\%%G %MY_TEMP% > nul
)

%PACK% .\packages\AtomPortable-Part4-Go-1.9-64bit.7z -r .\packages\_tmp\atom

FOR %%G IN (%PACKAGE_LIST%) DO (
	move %MY_TEMP%\%%G %PACKAGES% > nul
)

rmdir /s /q .\packages\_tmp 2> nul
