echo "Building shortcut creator"

g++ --static shortcuts.cpp -o ../Shortcuts.exe -mwindows -lole32 -luuid
strip ../Shortcuts.exe
../bin/rcedit.exe ../Shortcuts.exe --set-icon setup.ico

echo "Building launchers"

gcc --static launcher.c -o ../Atom.exe -mwindows -D_PROCESS_TO_EXECUTE_="\"Atom\\\Atom.Portable.exe\""
strip ../Atom.exe
../bin/rcedit.exe ../Atom.exe --set-icon atom.ico

gcc --static launcher.c -o ../Vim.exe -mwindows -D_PROCESS_TO_EXECUTE_="\"Atom\\\App\\\Vim.bat\""
strip ../Vim.exe
../bin/rcedit.exe ../Vim.exe --set-icon vim.ico

gcc --static launcher.c -o ../Meld.exe -mwindows -D_PROCESS_TO_EXECUTE_="\"meld\\\meld.exe\""
strip ../Meld.exe
../bin/rcedit.exe ../Meld.exe --set-icon meld.ico

gcc --static launcher.c -o ../Bash.exe -mwindows -D_PROCESS_TO_EXECUTE_="\"Atom\\\App\\\Bash.bat\""
strip ../Bash.exe
../bin/rcedit.exe ../Bash.exe --set-icon bash.ico

gcc --static launcher.c -o ../TMux.exe -mwindows -D_PROCESS_TO_EXECUTE_="\"Atom\\\App\\\TMux.bat\""
strip ../TMux.exe
../bin/rcedit.exe ../TMux.exe --set-icon TMux.ico
