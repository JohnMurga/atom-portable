@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

if not exist "%~dp0\..\..\meld\bin\meld" (
    "C:\Program Files (x86)\Beyond Compare 4\BCompare.exe" %*
) ELSE (
    pythonw %~dp0\..\..\meld\bin\meld %*
)
