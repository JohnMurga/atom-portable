@echo OFF
setlocal EnableDelayedExpansion

REM From : https://blogs.msdn.microsoft.com/david.wang/2006/03/27/howto-detect-process-bitness/

set OS=64BIT
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 set OS=32BIT
)

if %OS%==32BIT echo 32bit
if %OS%==64BIT echo 64bit
