@echo off
set "folder_path=C:\Users\X166147\Downloads"

if not exist "%folder_path%" (
    echo Downloads folder does not exist.
    exit /b
)

cd /d "%folder_path%"
del *.rdp /q
echo All RDP files deleted from Downloads folder.
