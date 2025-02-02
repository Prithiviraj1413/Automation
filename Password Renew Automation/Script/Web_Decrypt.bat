@echo off
set Decrpt_ConfigPath=%1
echo Decrpt_ConfigPath: %Decrpt_ConfigPath%
cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319
ASPNET_REGIIS -pdf "connectionStrings" %Decrpt_ConfigPath% >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo ***Decryption succeeded!***
) else (
    echo ***Decryption failed!***
)

exit /b %ERRORLEVEL%
