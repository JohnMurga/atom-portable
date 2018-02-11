@echo off
:: Copyright 2014-2016 John de Murga - Licensed under the GPLv2

call %~dp0\setPaths.bat

cd /D %HOME%

mintty --title "TMUX Window" --size 140,40 tmux new bash
