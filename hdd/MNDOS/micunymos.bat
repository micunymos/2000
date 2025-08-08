:reset
color 02
@echo off
title Micunymos 6.5
cd /d %~dp0
set pcd=%dp0
set prevcd=%CD%
:loading
echo I
echo. &&ping localhost -n 0 >NUL
cls
echo /
echo. &&ping localhost -n 0 >NUL
cls
echo -
echo. &&ping localhost -n 0 >NUL
cls
echo \
echo. &&ping localhost -n 0 >NUL
cls
echo I
echo. &&ping localhost -n 0 >NUL
cls
echo /
echo. &&ping localhost -n 0 >NUL
cls
echo -
echo. &&ping localhost -n 0 >NUL
cls
echo \
echo. &&ping localhost -n 0 >NUL
cls
echo I
echo. &&ping localhost -n 0 >NUL
cls
echo /
echo. &&ping localhost -n 0 >NUL
cls
echo -
echo. &&ping localhost -n 0 >NUL
cls
echo \
echo. &&ping localhost -n 0 >NUL
cls
echo I
echo. &&ping localhost -n 0 >NUL
cls
echo /
echo. &&ping localhost -n 0 >NUL
cls
echo -
echo. &&ping localhost -n 0 >NUL
cls
echo \
echo. &&ping localhost -n 0 >NUL
cls
echo I
echo. &&ping localhost -n 0 >NUL
cls
echo /
echo. &&ping localhost -n 0 >NUL
cls
echo -
echo. &&ping localhost -n 0 >NUL
cls
echo \
echo. &&ping localhost -n 0 >NUL
cls
:home
cls
cd /d %~dp0
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo Micunymos 6
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
set /p exec=%PREVCD%^> 
call %exec%
goto home