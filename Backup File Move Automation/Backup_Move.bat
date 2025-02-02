@echo off setlocal enabledelayedexpansion


:: Set the source and destination directories 
set "source=C:\Users\Path\" 
set "destination=C:\Users\Path\"
set "folderName=Raj_FolderName"


:: Get the current date and time 
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
echo %dt%
set "formattedDateTime=%dt:~0,4%%dt:~4,2%%dt:~6,2%%dt:~8,2%%dt:~10,2%%dt:~12,2%"
echo %formattedDateTime%

:: Create a new folder in the destination with the specified name 
set "newFolderName=%folderName% -%formattedDateTime%" 
mkdir "%destination%%newFolderName%"

:: Move all files from the source to the new destination folder
 move "%source%*" "%destination%%newFolderName%"
 
 echo %errorlevel%
 
if  %errorlevel%==0 (
echo "Files have been moved successfully." ) else (echo "***********error.....*************")
pause
