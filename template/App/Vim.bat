@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

call %~dp0\setPaths.bat

start "" %~dp0\ConEmu\ConEmu.exe /loadcfgfile %~dp0\ConEmu.xml /cmd %~dp0\..\..\git\usr\bin\vim.exe %*
