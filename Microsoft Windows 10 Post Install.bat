@echo off
title Windows 10 Post Install
color 1F
echo ==========================================================================
echo Disable Hibernation, Uninstall OneDrive, Remove User Folders from This PC, &echo.and Enable Mapped Network Drive(s) With UAC Elevated Permissions.
echo ==========================================================================

rem Version 1.0

:Check Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :Disable Hibernation
) else (
    goto :Error
)

:Disable Hiberation
set input=
set /p input=Disable Hibernation? (Y/N):
if "%input%" == "" goto :Disable Hibernation
if /I "%input%" == "y" goto :Disable Hibernation Yes
if /I "%input%" == "n" goto :Uninstall OneDrive
echo Please type Y or N. & goto :Disable Hibernation

:Disable Hibernation Yes
powercfg/h off

:Uninstall OneDrive
set input=
set /p input=Uninstall OneDrive? (Y/N):
if "%input%" == "" goto :Uninstall OneDrive
if /I "%input%" == "y" goto :Uninstall OneDrive Yes
if /I "%input%" == "n" goto :Remove User Folders
echo Please type Y or N. & goto :Uninstall OneDrive

:Uninstall OneDrive Yes
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo Closing OneDrive process.
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo Uninstalling OneDrive.
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 10 > NUL 2>&1
echo Removing OneDrive leftovers.
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1
echo Removing OneDrive from the Explorer Side Panel.
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1

:Remove User Folders
set input=
set /p input=Remove User Folders in This PC (64-bit)? (Y/N):
if "%input%" == "" goto :Remove User Folders
if /I "%input%" == "y" goto :Remove User Folders Yes
if /I "%input%" == "n" goto :Enable Linked Connections
echo Please type Y or N. & goto :Remove User Folders

:Remove User Folders Yes
rem 3D Objects
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
REG DELETE "KEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f

rem Desktop
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f

rem Documents
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f

rem Downloads
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f

rem Music
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f

rem Pictures
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f

rem Videos
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f

:Enable Linked Connections
set input=
set /p input=Enable Mapped Network Drive(s) With UAC Elevated Permissions? (Y/N):
if "%input%" == "" goto :Enable Linked Connections
if /I "%input%" == "y" goto :Enable Linked Connections Yes
if /I "%input%" == "n" goto :Success
echo Please type Y or N. & goto :Enable Linked Connections

:Enable Linked Connections Yes
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 00000001 /f

:Success
echo(
echo %username%, Windows 10 is ready!
echo(
echo Press any key to close . . .
pause >null
goto :End

:Error
echo(
echo Please run this as Administrator.
echo(
echo Press any key to close . . .
pause >null

:End