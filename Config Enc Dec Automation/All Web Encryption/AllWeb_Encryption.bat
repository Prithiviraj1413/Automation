@echo off

rem Prompt the user to enter the destination path
set /p dest_path="Enter the destination path: "

rem Enable delayed expansion
setlocal enabledelayedexpansion

rem Loop through each file with prefix "web" and process them
for /f "tokens=*" %%a in ('dir /b "%dest_path%\*web.config"') do (
    set "file_name=%%a"
   
   
    rem Rename the file to "web.config"
    ren "%dest_path%\!file_name!" "web.config"
		rem Change directory to the .NET Framework directory
		cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319
		rem Execute ASPNET_REGIIS command to encrypt the connectionStrings section in web.config
		ASPNET_REGIIS -pef "connectionStrings" "%dest_path%"
		rem Revert back the file name
        ren "%dest_path%\web.config" "!file_name!"
    echo Encrypted File: "%dest_path%\!file_name!"
)

rem Pause the script to keep the command prompt window open (optional)
pause

