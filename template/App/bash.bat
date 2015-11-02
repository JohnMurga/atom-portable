@echo off
cls
call start "" /B /W "%~dp0\..\..\git\bin\bash" %* & exit
