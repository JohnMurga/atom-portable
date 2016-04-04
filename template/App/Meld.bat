@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

if not exist "%~dp0\..\..\meld\meld.exe" (
    "C:\Program Files (x86)\Beyond Compare 4\BCompare.exe" %*
) ELSE (
    %~dp0\..\..\meld\meld.exe %*
)
