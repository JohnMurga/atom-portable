@echo off
lua.exe -e "package.path=[[%~dp0luaCheck\src\?.lua;%~dp0luaCheck\src\?\init.lua;]]..package.path" "%~dp0luaCheck\bin\luacheck.lua" %*
