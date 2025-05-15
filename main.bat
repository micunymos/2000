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
	set nobootmenu=0
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
		if "%%a"=="/nobootmenu" set nobootmenu=1
		if "%%a"=="/nologo" set nologo=1
		set /a loop+=1
	)
	set a=
	if not defined _root goto is
	goto main
:main
	if not %nologo%==1 if exist image.txt type image.txt
	echo [0m
	echo [40m
	echo [37m
	echo [0;0H
	if %verbose%==1 (
		echo [[3%b%VERBOSE BOOT[0m] BIOS Initialised.
		echo [[3%b%VERBOSE BOOT[0m] Parametres: %*
		echo [[3%b%VERBOSE BOOT[0m] Initialising boot devices . . .
	)
	goto bootdev
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
	echo [[3%m%DETAILS[0m] HDD is not attached.
	echo [[3%m%DETAILS[0m] USB is not attached.
	echo [[3%m%DETAILS[0m] FDD is not attached.
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
	echo [%h%;%v%H No boot devices are attached.
	set /a h=%h%+1
	echo [%h%;%v%H HDD(s):       [31mX[30m
	set /a h=%h%+1
	echo [%h%;%v%H USB(s):       [31mX[30m
	set /a h=%h%+1
	echo [%h%;%v%H FDD(s):       [31mX[30m
	set /a h=%h%+1
	echo [%h%;%v%H What to do to attach a boot device:
	set /a h=%h%+1
	echo [%h%;%v%H 1. Create a folder inside of the root folder.
	set /a h=%h%+1
	echo [%h%;%v%H 2. Place the contents of the device inside.
	set /a h=%h%+1
	echo [%h%;%v%H 3. Name the folder HDD, USB or FDD.
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
	echo [1;1H
	pause >nul
	goto halt
:bootdev
	echo [0m
	if %verbose%==1 (
		set count=1
		for %%D in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
			echo !count!: %%D
			set /a count=!count!+1
		)
		set count=
		set /p %bootdev%=[[3%b%VERBOSE BOOT[37m] [[3%c%INPUT[37m] Enter boot device number^> 
		goto bdverb
	)
	if %nobootmenu%==1 (
		if not exist %_root%\hdd if not exist %_root%\usb if not exist %_root%\fdd goto nb
		set bootdev=0
		echo [[3%y%WARN[30m] No boot menu. Booting from device %bootdev%
		goto preboot
	)
	goto bd
:bd
	set loop=18
	set h=8
	set v=25
	goto bdimg
:bdimg
	if not %nologo%==1 if not %verbose%==1 if exist image.txt (
		type image.txt
		goto bdloop
	)
	goto bdverb
:bdverb
	echo [[3%b%VERBOSE BOOT[0m] Booting . . .
	echo [[3%m%DETAILS[0m] Device selected is %bootdev%.
	echo [[3%m%DETAILS[0m] Device name: %!bootdevDevice name ^= !DEVNAME!
	echo [[3%m%DETAILS[0m] Device type: %!bootdevDevice type ^= !DEVTYPE!
	goto preboot
:bdloop
	if %loop%==0 (
		set loop=
		set h=
		set v=
		goto bdtext
	)
	if %loop%==18 (
		echo [%h%;%v%H[41m[30m[4m Select Boot Device                              [0m[30m[47m
	)
	if not %loop%==18 if not %loop%==1 (
		echo [%h%;%v%H                                                 
	)
	if %loop%==1 (
		echo [%h%;%v%H[4m                                                 
	)
	set /a h=%h%+1
	set /a loop=%loop%-1
	goto bdloop
:bdtext
	set count=0
	for %%D in (hdd hdd1 hdd2 hdd3 usb usb1 usb2 usb3 fdd fdd1 fdd2 fdd3) do (
		set currentloop=!_root!\%%D\deviceinfo.txt
		if exist !currentloop! for /f "usebackq tokens=1,2" %%K in ("!currentloop!") do (
			set "%%K!count!=%%L"
		)
		if exist !currentloop! set /a count=!count!+1
	)
	set currentloop=
	if not !count!==0 goto bd0
	if !count!=0 goto nb
:bd0
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME0!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE0!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM0!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB0!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd1
	if %errorlevel%==2 goto bd%count%
	if %errorlevel%==3 (
		set bootdev=0
		goto preboot
	)
:bd1
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME1!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE1!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM1!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB1!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd2
	if %errorlevel%==2 goto bd0
	if %errorlevel%==3 (
		set bootdev=1
		goto preboot
	)
:bd2
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME2!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE2!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM2!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB2!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd3
	if %errorlevel%==2 goto bd1
	if %errorlevel%==3 (
		set bootdev=2
		goto preboot
	)
:bd3
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME3!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE3!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM3!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB3!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd4
	if %errorlevel%==2 goto bd2
	if %errorlevel%==3 (
		set bootdev=3
		goto preboot
	)
:bd4
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME4!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE4!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM4!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB4!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd5
	if %errorlevel%==2 goto bd3
	if %errorlevel%==3 (
		set bootdev=4
		goto preboot
	)
:bd5
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME5!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE5!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM5!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB5!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd6
	if %errorlevel%==2 goto bd4
	if %errorlevel%==3 (
		set bootdev=5
		goto preboot
	)
:bd6
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME6!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE6!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM6!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB6!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd7
	if %errorlevel%==2 goto bd5
	if %errorlevel%==3 (
		set bootdev=6
		goto preboot
	)
:bd7
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME7!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE7!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM7!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB7!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd8
	if %errorlevel%==2 goto bd6
	if %errorlevel%==3 (
		set bootdev=7
		goto preboot
	)
:bd8
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME8!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE8!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM8!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB8!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd9
	if %errorlevel%==2 goto bd7
	if %errorlevel%==3 (
		set bootdev=8
		goto preboot
	)
:bd9
	set /a h=10
	set /a v=26
	set a=48;2;127;127;127m
	echo [0m
	echo [47m[30m
	echo [%h%;%v%H Device name ^= !DEVNAME9!
	set /a h=%h%+1
	echo [%h%;%v%H Device type ^= !DEVTYPE9!
	set /a h=%h%+1
	echo [%h%;%v%H Device number ^= !DEVNUM9!
	set /a h=%h%+1
	echo [%h%;%v%H Device address ^= !DEVLIB9!
	set /a h=%h%+1
	echo [%h%;%v%H Use W and S to cycle boot devices.
	set /a h=%h%+1
	echo [%h%;%v%H Use X to select and boot current device.
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
	echo [%h%;%v%H[4m                                               [0m[47m[30m
	set h=
	set v=
	set a=
	echo [0m
	choice /c WSX /n
	if %errorlevel%==1 goto bd0
	if %errorlevel%==2 goto bd8
	if %errorlevel%==3 (
		set bootdev=9
		goto preboot
	)
:preboot
	set count=
	set mncmdln=%_root%\bios\high\boot.bat /bootdev %bootdev%
	if %verbose%==1 set mncmdln=%mncmdln% /verbose
	if %nologo%==1 set mncmdln=%mncmdln% /nologo
	goto boot
:boot
	%mncmdln%