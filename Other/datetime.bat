@echo off
REM for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
REM set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
REM set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

REM set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
REM set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
REM echo datestamp: "%datestamp%"
REM echo timestamp: "%timestamp%"
REM echo fullstamp: "%fullstamp%"
REM pause


for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
echo %dt%
set "formattedDateTime=%dt:~0,4%%dt:~4,2%%dt:~6,2%%dt:~8,2%%dt:~10,2%%dt:~12,2%"
echo %formattedDateTime%
pause

REM set "formattedDateTime=%date:~-4,4%%date:~-10,2%%date:~-7,2%%time:~0,2%%time:~3,2%%time:~6,2%"
