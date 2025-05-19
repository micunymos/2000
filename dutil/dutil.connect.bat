@echo off
setlocal enabledelayedexpansion
cd /d %~dp0..
if /i "%*" equ "" goto eof
set connect=
set from=
for %%A in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
	if /i "%1"=="%%A" set connect=%%A
	if /i "%2"=="%%A" set from=%%A
)
if not defined connect goto eof
if defined from goto from
echo [Disk Utility] Reattaching _root\%connect% . . .
if not exist Disconnected_%connect% echo [Disk Utility] Couldn't find a disconnected %connect%. &&goto eof
echo [Disk Utility] Folder acquired: _root\Disconnected_%connect%.
echo [Disk Utility] Checking availability of slot %connect%:
if exist %connect% if exist %connect%\* echo [Disk Utility] Slot unavailable. &&goto eof
if exist %connect% rd connect
echo [Disk Utility] Slot available.
echo [Disk Utility] Connecting . . .
rename Disconnected_%connect% %connect%
goto notfrom
:from
echo [Disk Utility] Reattaching _root\%connect% . . .
if not exist Disconnected_%from% echo [Disk Utility] Couldn't find a disconnected %from%. &&goto eof
echo [Disk Utility] Folder acquired: _root\Disconnected_%from%.
echo [Disk Utility] Checking availability of slot %connect%:
if exist %connect% if exist %connect%\* echo [Disk Utility] Slot unavailable. &&goto eof
if exist %connect% rd connect
echo [Disk Utility] Slot available.
echo [Disk Utility] Connecting . . .
rename Disconnected_%from% %connect%
echo %from% %connect%
goto notfrom
:notfrom
echo [Disk Utility] Finished connecting.
echo [Disk Utility] Finished reattaching _root\%connect%.
:eof