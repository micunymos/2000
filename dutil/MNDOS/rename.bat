@echo off
%prevcd:~0,2%
cd %prevcd%
set originalname=%1
set newname=%2
:start
	cls
	setlocal enabledelayedexpansion
	echo [41mCONFIRM RENAMING %originalname% TO %newname%???[0m
	set /p confirm=
	if /i %confirm% equ "" goto start
	if /i %confirm%==y rename %originalname% %newname% &&exit /b
	if /i %confirm%==n exit /b
	goto start