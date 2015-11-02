if not exist "%~dp0\..\..\meld\bin\meld" (
    "C:\Program Files (x86)\Beyond Compare 4\BCompare.exe" %*
) ELSE (
    pythonw %~dp0\..\..\meld\bin\meld %*
)
