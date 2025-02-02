@echo off
cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319 
ASPNET_REGIIS -pef "connectionStrings" "C:\Users\Path" -prov "WisProvider"
pause

