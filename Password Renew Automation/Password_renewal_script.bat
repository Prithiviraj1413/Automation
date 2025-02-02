@echo off
echo Welcome to the Web.config Password Update Script!
echo This script will help you update the password in your Web.config file's connection string.
echo Please follow the prompts to enter the required information.

echo.

set "Config_basepath=C:\Users\Path"
set "DB_Name=DB_Name"

set "configPath=%Config_basepath%\web.config"
set "backupPath=%Config_basepath%\BK"
set "decrypt_configPath=%Config_basepath%"
set "encrypt_configPath=%Config_basepath%"


set /p newPassword="Enter the new password: "

powershell -ExecutionPolicy Bypass -File .\Script\update-webconfig.ps1 -configPath "%configPath%" -backupPath "%backupPath%" -newPassword %newPassword% -decrypt_configPath "%decrypt_configPath%" -encrypt_configPath "%encrypt_configPath%" -DB_Name %DB_Name%
pause


