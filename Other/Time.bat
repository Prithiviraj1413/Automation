@echo off
cls
echo Time format = %time%
echo hh = %time:~0,2%
echo mm = %time:~3,2%
echo ss = %time:~6,2%
echo.
echo Timestamp = %time:~0,2%%time:~3,2%%time:~6,2%
pause

echo My First Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%%time:~0,2%%time:~3,2%%time:~6,2%.pdf
