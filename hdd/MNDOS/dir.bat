cd /d %prevcd%
dir /b /w > temp
type temp
del /s /q temp >nul
pause