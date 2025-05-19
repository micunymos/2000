%prevcd:~0,2%
cd %prevcd%
for /r "%prevcd%" %%A in (*) do (
	echo %%A
)
pause