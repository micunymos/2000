@echo off
cd %~dp0
setlocal EnableDelayedExpansion
set r=38;2;255;63;63m
set g=38;2;63;255;63m
set b=38;2;63;63;255m
cls
if not defined _root goto is
:switches
	set verbose=0
	set nobootmenu=0
	set nologo=0
	set nofilecheck=0
	set bootfrom=0
	set bootarg=0
	set loop=1
	if exist default.txt (
		echo [[%b%INFO[0m] Detected default parametres, initialising:
		for /f "tokens=*" %%A in (default.txt) do (
			set "%%A"
			echo [[%g%%~dp0default[0m] Loaded default option: %%A
		)
		set A=
	)
	for %%a in (%*) do (
		if "%%a"=="/verbose" (
			set verbose=1
		)
		if "%%a"=="/nobootmenu" (
			set nobootmenu=1
		)
		if "%%a"=="/nologo" (
			set nologo=1
		)
		if "%%a"=="/nofilecheck" (
			set nofilecheck=1
		)
		if "%%a"=="/bootfrom" (
			set bootarg=!loop!
			set /a bootarg+=1
			set bootfrom=1
			goto bootfrom
		)
		if "%%a"=="/help" (
			goto help
		)
		set /a loop+=1
	)
	set a=
	goto bios
:bootfrom
	cd %_root%
	cd !bootarg!
	set /p start=<start
	call !start!
	echo [0m
	echo.
	echo.
	echo.
	echo.
	echo Program finished
	goto halt
:is
	echo [1;1H
	color 4f
	set loop=8
	goto isloop
:isloop
	if !loop!==0 goto istext
	if !loop!==8 echo  [47m                              [41m
	if !loop!==1 (
		echo  [47m                              [40m [41m
		echo   [40m                              [41m
	)
	if not !loop!==1 if not !loop!==8 (
		echo  [47m                              [40m [41m
	)
	set /a loop-=1
	goto isloop
:istext
	echo [2;2H[47m[30m ERROR!
	echo [4;2H YOU'VE LAUNCHED THIS SYSTEM
	echo [5;2H FROM OUTSIDE THE INTENDED
	echo [6;2H ENVIRONMENT. SYSTEM HALTED
	echo [0m
	goto halt
:halt
	pause >nul
	echo [0;0H
	goto halt
:help
	type help.txt
	goto halt
:bios
	cd %_root%
	echo [[%g%BOOT[0m] Initialising low level assets . . .
	if !nofilecheck!==0 (
		if not exist bios\high\main.bat goto fe
		if not exist bios\high\boot.bat goto fe
		if not exist bios\high\image.txt goto fe
		if %verbose%==1 echo [[%b%VERBOSE BOOT[0m] No errors found in file checking results.
	)
	goto boot
:fe
	echo [1;1H
	color 4f
	set loop=8
	goto feloop
:feloop
	if !loop!==0 goto fetext
	if !loop!==8 echo  [47m                              [41m
	if !loop!==1 (
		echo  [47m                              [40m [41m
		echo   [40m                              [41m
	)
	if not !loop!==1 if not !loop!==8 (
		echo  [47m                              [40m [41m
	)
	set /a loop-=1
	goto feloop
:fetext
	echo [2;2H[47m[30m ERROR!
	echo [4;2H CRITICAL FILES ARE MISSING
	echo [5;2H THE SYSTEM BIOS CAN'T START
	echo [6;2H SYSTEM HALTED.
	echo [0m
	goto halt
:boot
	if not %bootfrom%==1 goto inithighbios
	goto halt
:inithighbios
	cd %_root%\bios\high
	set mncmdln=main.bat
	if %verbose%==1 set mncmdln=%mncmdln% /verbose
	if %nobootmenu%==1 set mncmdln=%mncmdln% /nobootmenu
	if %nologo%==1 set mncmdln=%mncmdln% /nologo
	%mncmdln%
	goto halt