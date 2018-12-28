@echo off
:: Copyright 2014-2015 John de Murga - Licensed under the GPLv2

start "" %~dp0\ConEmu\ConEmu.exe /loadcfgfile %~dp0\ConEmu\ConEmu.xml /cmd %~dp0\Console.bat
exit
