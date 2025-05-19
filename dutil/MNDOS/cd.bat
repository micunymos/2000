:cd
%prevcd:~0,2%
cd %prevcd%
cd %~1
set prevcd="%cd%"
;