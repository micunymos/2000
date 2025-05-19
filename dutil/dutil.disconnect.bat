@echo off
setlocal enabledelayedexpansion
cd /d %~dp0..
set delete=
for %%A in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
	if /i "%1"=="%%A" set delete=%%A
)
if not defined delete goto eof
if not exist %delete% (
	echo [Disk Utility] The disk %delete% was not found.
	goto eof
)
echo Are You SURE You want to delete _root\%delete%?
echo Deleting disk data can only be done using a file explorer.
echo.
echo Press X three times to confirm. Pressing C will exit this program.
echo.
echo 0
choice /c XC /n
if %errorlevel%==2 goto eof
echo 1
choice /c XC /n
if %errorlevel%==2 goto eof
echo 2
choice /c XC /n
if %errorlevel%==2 goto eof
echo 3
echo Proceeding . . .
rename %delete% "Disconnected_%delete%"
echo [Disk Utility] Disconnected %delete%. Deleting a disk's data can only be done using a file explorer.
:eof