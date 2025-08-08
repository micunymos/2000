@echo off
setlocal EnableDelayedExpansion
echo ================
echo   Disk Utility
echo ================
echo.
if /i "%*" equ "" set utilloop=1 &&goto util
if /i not "%*" equ "" goto runcmd
:util
	echo =======================================================
	echo   You've not entered a subcommand to be executed.
	echo   This is the Disk Utility Shell.
	echo   Enter any Disk Utility command, and we will run it.
	echo   Type "exit" to leave this shell.
	echo =======================================================
	echo.
	goto utilloop
:utilloop
	set exec=
	set loop=
	set /p exec=SHELL^> 
	if not defined exec goto utilloop
	if "%exec%"=="help" goto help
	if "%exec%"=="exit" goto eof
	set launch=dutil.
	set loop=1
	set list=0
	set add=0
	set disconnect=0
	set boot=0
	set connect=0
	set act=
	for %%A in (%exec%) do (
		if /i "%%A"=="list" set list=!loop! &&set act=list
		if /i "%%A"=="add" set add=!loop! &&set act=add
		if /i "%%A"=="disconnect" set disconnect=!loop! &&set act=disconnect
		if /i "%%A"=="boot" set boot=!loop! &&set act=boot
		if /i "%%A"=="connect" set connect=!loop! &&set act=connect
		set "A!loop!=%%A"
		set /a loop+=1
	)
	if not defined act goto utilloop
	goto %act%
	goto utilloop
:runcmd
	set loop=1
	set list=0
	set add=0
	set disconnect=0
	set boot=0
	set act=
	set launch=dutil.
	for %%A in (%*) do (
		if /i "%%A"=="list" set list=!loop! &&set act=list
		if /i "%%A"=="add" set add=!loop! &&set act=add
		if /i "%%A"=="disconnect" set disconnect=!loop! &&set act=disconnect
		if /i "%%A"=="boot" set boot=!loop! &&set act=boot
		if /i "%%A"=="connect" set connect=!loop! &&set act=connect
		set "A!loop!=%%A"
		set /a loop+=1
	)
	if not defined act goto eof
	goto %act%
:list
	set /a list+=1
	if !list!==1 set list=%A1%
	if !list!==2 set list=%A2%
	if !list!==3 set list=%A3%
	if !list!==4 set list=%A4%
	if !list!==5 set list=%A5%
	if !list!==6 set list=%A6%
	if !list!==7 set list=%A7%
	if !list!==8 set list=%A8%
	if !list!==9 set list=%A9%
	call set "launch=%launch%list.bat !list!"
	goto run
:add
	set /a add+=1
	if !add!==1 set add=%A1%
	if !add!==2 set add=%A2%
	if !add!==3 set add=%A3%
	if !add!==4 set add=%A4%
	if !add!==5 set add=%A5%
	if !add!==6 set add=%A6%
	if !add!==7 set add=%A7%
	if !add!==8 set add=%A8%
	if !add!==9 set add=%A9%
	call set "launch=%launch%add.bat !add!"
	goto run
:disconnect
	set /a disconnect+=1
	if !disconnect!==1 set disconnect=%A1%
	if !disconnect!==2 set disconnect=%A2%
	if !disconnect!==3 set disconnect=%A3%
	if !disconnect!==4 set disconnect=%A4%
	if !disconnect!==5 set disconnect=%A5%
	if !disconnect!==6 set disconnect=%A6%
	if !disconnect!==7 set disconnect=%A7%
	if !disconnect!==8 set disconnect=%A8%
	if !disconnect!==9 set disconnect=%A9%
	call set "launch=%launch%disconnect.bat !disconnect!"
	goto run
:boot
	set /a boot+=1
	if !boot!==1 set boot=%A1%
	if !boot!==2 set boot=%A2%
	if !boot!==3 set boot=%A3%
	if !boot!==4 set boot=%A4%
	if !boot!==5 set boot=%A5%
	if !boot!==6 set boot=%A6%
	if !boot!==7 set boot=%A7%
	if !boot!==8 set boot=%A8%
	if !boot!==9 set boot=%A9%
	call set "launch=%launch%boot.bat !boot!"
	goto run
:connect
	set /a connect+=1
	if !connect!==1 set connect=%A1%
	if !connect!==2 set connect=%A2%
	if !connect!==3 set connect=%A3%
	if !connect!==4 set connect=%A4%
	if !connect!==5 set connect=%A5%
	if !connect!==6 set connect=%A6%
	if !connect!==7 set connect=%A7%
	if !connect!==8 set connect=%A8%
	if !connect!==9 set connect=%A9%
	call set "launch=%launch%connect.bat !connect!"
	goto run
:run
	call dutil\%launch%
	echo [Disk Utility] Returned from the operation. Press any key to proceed.
	pause >nul
	if %utilloop%==1 goto utilloop
	goto eof
:help
	echo =================================================================
	echo   You can use this to manage your disks in Micunymos 2000.
	echo   The subcommands are:
	echo.
	echo   HELP        - Display this message.
	echo   LIST        - List the active disks.
	echo   ADD         - Create a disk.
	echo   DISCONNECT  - Disconnect a disk.
	echo   CONNECT     - Reconnect a disk.
	echo   BOOT        - Copy default boot files to a disk.
	echo.
	echo   You can only delete a disk's folder from a file explorer.
	echo.
	echo   To get into the Disk Utility Shell, run me without arguments.
	echo =================================================================
:eof
	set loop=
	set exec=
	set launch=
	set utilloop=
	set a1=
	set a2=
	set a3=
	set a4=
	set a5=
	set a6=
	set a7=
	set a8=
	set a9=