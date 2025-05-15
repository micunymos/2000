@echo off
mode con cols=100 lines=40
cd %~dp0
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
	set nologo=0
	set loop=1
	if exist default (
		echo [[%b%INFO[0m] Detected default parametres, initialising:
		for /f "tokens=*" %%A in (default) do (
			set "%%A"
			echo [[%g%%~dp0default[0m] Loaded default option: %%A
		)
	)
	set A=
	for /f "tokens=1" %%a in ("%*") do (
		if "%%a"=="/verbose" set verbose=1
		if "%%a"=="/bootdev" set bootdev=1
		if "%%a"=="/nologo" set nologo=1
		set /a loop+=1
	)
	set a=
	if not defined _root goto is
	if %bootdev%==0 goto nb
	goto main
:main
	goto halt
:is
	set loop=18
	set h=11
	set v=25
	goto isimg
:isimg
	if not %nologo%==1 if not %verbose%==1 if exist image.txt (
		type image.txt
		goto isloop
	)
	goto isverb
:isverb
	echo [[3%r%ERROR[0m] Incorrect startup!
	echo [[3%m%DETAILS[0m] _root variable is not defined,
	echo [[3%m%DETAILS[0m] but is strictly required
	echo [[3%m%DETAILS[0m] to access devices.
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
	set loop=18
	set h=11
	set v=25
	goto nbimg
:nbimg
	if not %nologo%==1 if not %verbose%==1 if exist image.txt (
		type image.txt
		goto nbloop
	)
	goto nbverb
:nbverb
	echo [[3%r%ERROR[0m] No boot devices were found!
	echo [[3%m%DETAILS[0m] The device to be booted was not specified.
	echo [[3%m%DETAILS[0m] If you've modified bios\high\main.bat, implement a /bootdev parameter for launching this program.
	echo [[3%m%DETAILS[0m] 
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