@echo off
setlocal EnableDelayedExpansion
cd /d %~dp0
type %0
set _root=%cd%
set bootfrom=0
set bootarg=0
set bios=0
set verbose=0
set nologo=0
set nobootmenu=0
set nofilecheck=0
set loop=1
for %%a in (%*) do (
	if "%%a"=="/verbose" (
		set verbose=1
	)
	if "%%a"=="/bootfrom" (
		set bootfrom=1
		set bootarg=!loop!
	)
	if "%%a"=="/nofilecheck" (
		set nofilecheck=1
	)
	if "%%a"=="/nologo" (
		set nologo=1
	)
	if "%%a"=="/nobootmenu" (
		set nobootmenu=1
	)
	set /a loop+=1
)
if !bootfrom!==1 (
	set /a bootarg+=1
	if !bootarg!==1 set boot=%~1
	if !bootarg!==2 set boot=%~2
	if !bootarg!==3 set boot=%~3
	if !bootarg!==4 set boot=%~4
	if !bootarg!==5 set boot=%~5
	if !bootarg!==6 set boot=%~6
	if !bootarg!==7 set boot=%~7
	if !bootarg!==8 set boot=%~8
	if !bootarg!==9 set boot=%~9
)
set bios=/start
if %verbose%==1 set bios=%bios% /verbose
if %nologo%==1 set bios=%bios% /nologo
if %nobootmenu%==1 set bios=%bios% /nobootmenu
if %nofilecheck%==1 set bios=%bios% /nofilecheck

if not "%bios%"=="/start" if %bootfrom%==1 (
	bios\low\startup.bat %bios% /bootfrom !boot!
)
if not "%bios%"=="/start" if not %bootfrom%==1 (
	bios\low\startup.bat %bios%
)
if "%bios%"=="/start" if %bootfrom%==1 (
	bios\low\startup.bat /bootfrom !boot!
)
if "%bios%"=="/start" if not %bootfrom%==1 (
	bios\low\startup.bat
)