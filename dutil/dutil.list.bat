@echo off
setlocal EnableDelayedExpansion
cd /d %~dp0..
if /i not "%1"=="hdd" if /i not "%1"=="usb" if /i not "%1"=="fdd" goto listall
if /i "%1"=="hdd" goto hdd
if /i "%1"=="usb" goto usb
if /i "%1"=="fdd" goto fdd
goto help
:help
	echo List storage devices.
	echo.
	echo Usage:
	echo Command line: %n0 [HDD/USB/FDD]
	echo DUTIL:        LIST [HDD/USB/FDD]
	echo.
	echo HDD : List HDD devices.
	echo USB : List USB devices.
	echo FDD : List FDD devices.
	goto eof
:hdd
	for %%A in (hdd hdd1 hdd2 hdd3) do (
		if exist %%A\deviceinfo.txt echo Device folder: _root\%%A
		if exist %%A\deviceinfo.txt if exist %%A\start.bat echo IS  SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\start.bat echo NOT SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if exist %%A\osloader.bat echo IS  BIOS BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\osloader.bat echo NOT BIOS BOOTABLE
	)
	goto eof
:usb
	for %%A in (usb usb1 usb2 usb3) do (
		if exist %%A\deviceinfo.txt echo Device folder: _root\%%A
		if exist %%A\deviceinfo.txt if exist %%A\start.bat echo IS  SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\start.bat echo NOT SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if exist %%A\osloader.bat echo IS  BIOS BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\osloader.bat echo NOT BIOS BOOTABLE
	)
	goto eof
:fdd
	for %%A in (fdd fdd1 fdd2 fdd3) do (
		if exist %%A\deviceinfo.txt echo Device folder: _root\%%A
		if exist %%A\deviceinfo.txt if exist %%A\start.bat echo IS  SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\start.bat echo NOT SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if exist %%A\osloader.bat echo IS  BIOS BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\osloader.bat echo NOT BIOS BOOTABLE
	)
	goto eof
:listall
	for %%A in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
		if exist %%A\deviceinfo.txt echo Device folder: _root\%%A
		if exist %%A\deviceinfo.txt if exist %%A\start.bat echo IS  SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\start.bat echo NOT SIMPLE BOOTABLE
		if exist %%A\deviceinfo.txt if exist %%A\osloader.bat echo IS  BIOS BOOTABLE
		if exist %%A\deviceinfo.txt if not exist %%A\osloader.bat echo NOT BIOS BOOTABLE
	)
	goto eof
:eof