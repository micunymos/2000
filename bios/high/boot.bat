@echo off
mode con cols=100 lines=40
cd %~dp0
cls
setlocal EnableDelayedExpansion
set r=8;2;255;63;63m
set g=8;2;63;255;63m
set b=8;2;63;63;255m
set y=8;2;255;255;63m
set c=8;2;63;255;255m
set m=8;2;255;63;255m
:switches
	set verbose=0
	set bootdev=0
	set devloop=0
	set nologo=0
	set loop=1
	if exist default.txt (
		echo [[%b%INFO[0m] Detected default parametres, initialising:
		for /f "tokens=*" %%A in (default) do (
			set "%%A"
			echo [[%g%%~dp0default[0m] Loaded default option: %%A
		)
	)
	set A=
	for %%a in (%*) do (
		if /i "%%a"=="/verbose" set verbose=1
		if /i "%%a"=="/bootdev" (
			set devloop=!loop!
			set /a devloop+=1
		)
		if !loop! equ !devloop! (
			set bootdev=%%a
		)
		if /i "%%a"=="/nologo" set nologo=1
		set /a loop+=1
	)
	set a=
	if not defined _root goto is
	if !bootdev!==0 goto nb
	goto main
:main
	cd %_root%
	if not exist %bootdev% goto nb
	if %nologo%==0 (
		if exist %bootdev%\bootlogo.txt type %bootdev%\bootlogo.txt
		if not exist %bootdev%\bootlogo.txt echo [[3%r%ERROR[37m] No boot logo found to display. Copy image to: %bootdev%\bootlogo.txt.
	)
	if not exist %bootdev%\osinf.txt (
		set boot.osinf.enabled=0
		set boot.osinf.bootdir=%_root%\%bootdev%
		set boot.osinf.bootfile=osloader.bat
		set boot.osinf.bootarg=
		echo %boot.osinf.bootarg:="%
		goto preboot
	)
	for /f "usebackq tokens=*" %%A in (%bootdev%\osinf.txt) do (
		if %verbose%==1 echo [[3%b%VERBOSE BOOT[37m] Loaded information: boot.osinf.%%A.
		set "boot.osinf.%%A"
	)
	goto preboot
	goto is
:is
	cls
	set loop=18
	set h=11
	set v=25
	goto isimg
:isimg
	if not %nologo%==1 if not %verbose%==1 if exist %_root%\bios\high\image.txt type %_root%\bios\high\image.txt
	if %nologo%==1 goto isverb
	if %verbose%==1 goto isverb
:isverb
	echo [[3%r%ERROR[0m] Incorrect startup!
	echo [[3%m%DETAILS[0m] You've started the system incorrectly.
	echo [[3%m%DETAILS[0m] No further details are available for this program.
	echo [[3%m%DETAILS[0m] Please press CTRL+C to close this program.
	echo [[3%y%WARN[0m] The system is halted!
	goto halt
:isloop
	if %loop%==0 (
		set loop=
		set h=
		set v=
		goto istext
	)
	if %loop%==18 (
		echo [%h%;%v%H[41m[30m[4m BIOS Error                                      [0m[30m[47m
	)
	if not %loop%==18 if not %loop%==1 (
		echo [%h%;%v%H                                                 
	)
	if %loop%==1 (
		echo [%h%;%v%H[4m                                                 
	)
	set /a h=%h%+1
	set /a loop=%loop%-1
	goto isloop
:istext
	set /a h=13
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H A fatal error occured in the system bios:
	set /a h=%h%+1
	echo [%h%;%v%H  ____________________________________________
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%Reference to undefined variable:            [47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%CHDIR ^$_ROOT^$^\BIOS^\HIGH                     [47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%                                            [47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%[4mThe system can not continue.                [0m[47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H Potential fixes for this issue:
	set /a h=%h%+1
	echo [%h%;%v%H  ^> Check boot.cmd for issues
	set /a h=%h%+1
	echo [%h%;%v%H  ^> ^\^/ Run the following commands:
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%set _root^=%%CD%%                              [47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H  [%a%.^\bios^\low^\startup.bat                      [47m[30m
	set /a h=%h%+1
	echo [%h%;%v%H    From the directory where start.cmd is.
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H [[33mWARN[30m] The system is halted.
	set /a h=%h%+1
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	goto halt
:nb
	cls
	set loop=18
	set h=11
	set v=25
	goto nbimg
:nbimg
	if not %nologo%==1 if not %verbose%==1 if exist %_root%\bios\high\image.txt type %_root%\bios\high\image.txt
	if %nologo%==1 goto nbverb
	if %verbose%==1 goto nbverb
	goto nbloop
:nbverb
	echo [[3%r%ERROR[0m] Incorrect bootdev parameter!
	echo [[3%m%DETAILS[0m] The device to be booted was not specified.
	echo [[3%m%DETAILS[0m] If you've modified bios\high\main.bat, implement a /bootdev parameter to boot.
	echo [[3%m%DETAILS[0m] The system can not find device "%bootdev%".
	echo [[3%y%WARN[0m] The system is halted!
	goto halt
:nbloop
	if %loop%==0 (
		set loop=
		set h=
		set v=
		goto nbtext
	)
	if %loop%==18 (
		echo [%h%;%v%H[41m[30m[4m Boot Error                                      [0m[30m[47m
	)
	if not %loop%==18 if not %loop%==1 (
		echo [%h%;%v%H                                                 
	)
	if %loop%==1 (
		echo [%h%;%v%H[4m                                                 
	)
	set /a h=%h%+1
	set /a loop=%loop%-1
	goto nbloop
:nbtext
	set /a h=13
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H %bootdev% was not recognised as a bootable device.
	set /a h=%h%+1
	echo [%h%;%v%H The BIOS boot manager can not continue.
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H
	set /a h=%h%+1
	echo [%h%;%v%H [[33mWARN[30m] The system is halted.
	set /a h=%h%+1
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	goto halt
:halt
	echo [0;0H
	pause >nul
	goto halt
:preboot
	if not defined boot.osinf.bootfile goto nb
	if not defined boot.osinf.bootdir goto nb
	call set boot.osinf.bootdir=%boot.osinf.bootdir%
	call set boot.osinf.bootfile=%boot.osinf.bootfile%
	call set boot.osinf.bootarg=%boot.osinf.bootarg%
	cd %boot.osinf.bootdir%
	if not defined boot.osinf.bootarg %boot.osinf.bootfile%
	if defined boot.osinf.bootarg %boot.osinf.bootfile% %boot.osinf.bootarg%
	goto nb