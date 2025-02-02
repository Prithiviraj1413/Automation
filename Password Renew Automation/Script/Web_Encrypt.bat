@echo off
set Encrpt_ConfigPath=%1
echo Encrpt_ConfigPath: %Encrpt_ConfigPath%
cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319 
ASPNET_REGIIS -pef "connectionStrings" %Encrpt_ConfigPath% -prov "WisProvider" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo ***Encryption succeeded!***
) else (
    echo ***Encryption failed!***
)

exit /b %ERRORLEVEL%


