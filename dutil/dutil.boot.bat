@echo off
setlocal enabledelayedexpansion
cd /d %~dp0..
if /i "%*" equ "" goto eof
set boot=
for %%A in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
	if /i "%1"=="%%A" set boot=%%A
)
if not defined boot goto eof
if not exist %boot% echo [Disk Utility] The disk %boot% couldn't be found. &&goto eof
echo [Disk Utility] Making %boot% bootable . . .
echo [Disk Utility] Creating boot files . . .
echo ^@echo off>>%boot%\start.bat
echo setlocal enabledelayedexpansion>>%boot%\start.bat
echo call MNDOS^\micunymos.bat>>%boot%\start.bat
echo ^@echo off>>%boot%\osloader.bat
echo setlocal enabledelayedexpansion>>%boot%\osloader.bat
echo MNDOS^\micunymos.bat>>%boot%\osloader.bat
echo [Disk Utility] Finished creating boot files.
echo [Disk Utility] Press X to finish, or C to install MN-DOS on the drive.
choice /c XC /n
if %errorlevel%==1 (
	md %boot%\MNDOS
	echo echo This program was not configured.>%boot%\MNDOS\micunymos.bat
	echo echo You may press any key to exit this program, and shut down.>>%boot%\MNDOS\micunymos.bat
	echo pause^>nul>%boot%\MNDOS\micunymos.bat
	echo [Disk Utility] Finished making %boot% bootable.
	goto eof
)
if %errorlevel%==2 goto mndos
:mndos
echo [Disk Utility] Copying MN-DOS . . .
md %boot%\MNDOS
copy dutil\MNDOS %boot%\MNDOS
echo [Disk Utility] Finished copying MN-DOS.
echo [Disk Utility] Finished making %boot% bootable.
:eof