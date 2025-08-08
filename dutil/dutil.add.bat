@echo off
setlocal enabledelayedexpansion
cd /d %~dp0..
set add=
for %%A in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
	if /i "%1"=="%%A" set add=%%A
)
if not defined add goto eof
if exist %add% (
	echo.
	echo The device at _root\%add% is connected. Please confirm that ...
	echo.
	echo ... Your important data on that device is BACKED UP.
	echo ... You are SURE You want to create device %add%.
	echo.
	echo Press X three times to confirm. Pressing C will exit this program.
	echo.
	echo 0
	choice /c XC /n
	if !errorlevel!==2 goto eof
	echo 1
	choice /c XC /n
	if !errorlevel!==2 goto eof
	echo 2
	choice /c XC /n
	if !errorlevel!==2 goto eof
	echo 3
	echo Proceeding . . .
)
if not exist %add% (
	echo [Disk Utility] Creating device _root\%add% . . .
	md %add%
	if %errorlevel%==0 echo [Disk Utility] Finished creating folder _root\%add%.
)
if exist %add%\deviceinfo.txt (
	echo [Disk Utility] Deleting old device information file . . .
	del %add%\deviceinfo.txt
	if %errorlevel%==0 echo [Disk Utility] Finished deleting old device information file.
)
echo [Disk Utility] Creating new device information file . . .
set /p DEVNAMEX=[Disk Utility] Enter device name (Max. 16 Characters!) ^> 
set DEVNAMEX=%DEVNAMEX:~0,16%
echo DEVNAME %DEVNAMEX% >> %add%\deviceinfo.txt
if /i %ADD:~0,3%==hdd set devtypeX=HDD
if /i %ADD:~0,3%==usb set devtypeX=USB
if /i %ADD:~0,3%==fdd set devtypeX=FDD
echo DEVTYPE %DEVTYPEX% >> %add%\deviceinfo.txt
if %devtypeX%==HDD set devnumX=0
if %devtypeX%==USB set devnumX=4
if %devtypeX%==FDD set devnumX=8
set temp=%ADD:~3,1%
if /i "%temp%" equ "" set /a devnumX+=0
if /i "%temp%" equ "1" set /a devnumX+=1
if /i "%temp%" equ "2" set /a devnumX+=2
if /i "%temp%" equ "3" set /a devnumX+=3
echo DEVNUM %DEVNUMX% >> %add%\deviceinfo.txt
echo DEVLIB %add% >> %add%\deviceinfo.txt
echo [Disk Utility] Finished creating new device information file.
if not exist %add%\start.bat (if not exist %add%\osloader.bat (echo [Disk Utility] This device is not bootable. )) ELSE (echo [Disk Utility] This device contains the original bootloader.)
echo [Disk Utility] Finished creating device _root\%add%.
echo [Disk Utility] Checking the device information file's integrity . . .
for /f "usebackq tokens=1,2" %%A in (%add%\deviceinfo.txt) do (
	set "%%A=%%B"
)
if /i not "%devname%"=="%devnamex%" (echo [Disk Utility] [ERROR] Mismatch of device name in the current database compared to the device information file.) ELSE (echo [Disk Utility] Device name is correctly registered.)
if /i not "%devtype%"=="%devtypex%" (echo [Disk Utility] [ERROR] Mismatch of device type in the current database compared to the device information file.) ELSE (echo [Disk Utility] Device type is correctly registered.)
echo [Disk Utility] Finished checking the device information file's integrity.
:eof
	exit /b