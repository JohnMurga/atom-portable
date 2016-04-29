@echo off
@setlocal enabledelayedexpansion

:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
   subst %%a: . > nul
   if !ERRORLEVEL! EQU 0 (
       endlocal
       if 1%1 NEQ 1 (
           set %1=%%a
       ) else (
           echo %%a
       )
       subst %%a: /D > nul
       exit /b
   )
)
