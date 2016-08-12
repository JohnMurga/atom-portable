@echo off
lua.exe -e "package.path=[[%APP_DIR%\luaCheck\src\?.lua;%APP_DIR%\luaCheck\src\?\init.lua;]]..package.path" "%APP_DIR%\luaCheck\bin\luacheck.lua" %*
