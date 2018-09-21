@ECHO off

:start
ECHO Enter File Name to import list from [Use {TAB} for autocomplition]
SET /p file=
ECHO \\\\\\\\\\\\\\\\\ %file% -- is chosen
ECHO What Product Are We Looking For?
SET /p product=

FOR /F "tokens=*" %%A in (%file%) do (
	ping %%A -n 1 >> %%A.txt | find "Reply" > nul 
	IF /I NOT errorlevel==0 (
		ECHO Computer cannot be reached via network.
		ECHO Consider to check connectivity.	
	)
   ELSE (
	WMIC /node:%%A product get name, version, vendor | findstr /i /C:"%product%"
		IF errorlevel 1 ECHO %product% Product Not Found >> %%~dp.txt
		ELSE ECHO %product% is ^Installed^ >> %%~dp.txt
   )
)
pause