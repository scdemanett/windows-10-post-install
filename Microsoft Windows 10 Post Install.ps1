param([switch]$Elevated)

function testAdmin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((testAdmin) -eq $false)  {
    if ($elevated) {
        Please allow elevation to run properly.
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

Clear-Host

$title = "Windows 10 Post Install"
$host.UI.RawUI.WindowTitle = $title

Write-Host $title
Write-Host "`n"
Write-Host "====================================================================================================================="
Write-Host "Disable Bing Search In Start Menu, Disable Hibernation, Enable Mapped Network Drive(s) With UAC Elevated Permissions,"
Write-Host "Remove User Folders From This PC, Uninstall Edgeium, And Uninstall OneDrive."
Write-Host "====================================================================================================================="
Write-Host "`n"

# Version 1.00

# Main menu, allowing user selection
function Show-Menu {
    Write-Host "================ $title ================"
    Write-Host "1: Press '1' To Disable Bing Search In Start Menu."
    Write-Host "2: Press '2' To Disable Hibernation."
    Write-Host "3: Press '3' To Enable Mapped Network Drive(s) With UAC Elevated Permissions."
    Write-Host "4: Press '4' To Remove Users Folders From This PC (64-bit)."
    Write-Host "5: Press '5' To Uninstall Edgeium."
    Write-Host "6: Press '6' To Uninstall OneDrive."
    Write-Host "A: Press 'A' To Run All."
    Write-Host "Q: Press 'Q' To Quit."
    Write-Host "`n"
}

function disableBing {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 00000000 -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 00000000 -Force -ErrorAction SilentlyContinue
    Write-Host "Bing Search Disabled."
    Write-Host "`n"
}

#Functions
function disableHibernation {
    powercfg /hibernate off
    Write-Host "Hibernation Off."
    Write-Host "`n"
}

function enableMappedDrives {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Value 00000001 -Force
    Write-Host "Mapped Network Drive(s) Enabled With UAC Elevated Permissions."
    Write-Host "`n"
}

function removeUsersFolders {
    # 3D Objects
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -Force -ErrorAction SilentlyContinue

    # Desktop
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Recurse -Force -ErrorAction SilentlyContinue

    # Documents
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Recurse -Force -ErrorAction SilentlyContinue

    # Downloads
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Recurse -Force -ErrorAction SilentlyContinue

    # Music
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -Force -ErrorAction SilentlyContinue

    # Pictures
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Recurse -Force -ErrorAction SilentlyContinue

    # Videos
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Users Folders Removed From This PC."
    Write-Host "`n"
}

function uninstallEdge {
    $edge = ${Env:ProgramFiles(x86)} + "\Microsoft\Edge\Application"

    if (Test-Path $edge) {
        Get-ChildItem -Path $edge -Filter setup.exe -Recurse -ErrorAction SilentlyContinue -Force |
        Foreach-Object {
            # Write-Host $_.FullName
            Start-Process $_.FullName "-uninstall -system-level -verbose-logging -force-uninstall" -wait
            Write-Host "Edgeium Is Uninstalled."
            Write-Host "`n"
        }
    } else {
        Write-Host "Good News! Edge Is Not Insalled... Yet."
        Write-Host "`n"
    }
}

function uninstallOneDrive {
    $x86 = $Env:SystemRoot + "\System32\OneDriveSetup.exe"
    $x64 = $Env:SystemRoot + "\SysWOW64\OneDriveSetup.exe"

    $OneDriveActive = Get-Process OneDrive -ErrorAction SilentlyContinue
    if ($null -eq $OneDriveActive) {
        Write-Host "OneDrive is not running."
        Write-Host "`n"
    } else {
        Write-Host "Closing OneDrive process."
        taskkill /f /im OneDrive.exe
        Write-Host "`n"
    }

    if (Test-Path $x86, $x64) {
        Write-Host "Uninstalling OneDrive."
        Write-Host "`n"
        if (Test-Path -Path $x64) {
            Start-Process $x64 /uninstall -wait
        } else {
            Start-Process $x86 /uninstall -wait
        }
        Write-Host "Removing OneDrive leftovers."
        Remove-Item $Env:USERPROFILE"\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item $Env:APPDATA"\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item $Env:ProgramData"\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "`n"
        Write-Host "Removing OneDrive from the Explorer Side Panel."
        Remove-Item "Registry::HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "Registry::HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "`n"
    } else {
        "OneDriveSetup.exe could not be found."
        Write-Host "`n"
    }
}

function runAll {
    disableBing
    disableHibernation
    enableMappedDrives
    removeUsersFolders
    uninstallEdge
    uninstallOneDrive
}

#Main menu loop
do {
    Show-Menu
    $userInput = Read-Host "Please make a selection"
    Write-Host "`n"
    switch ($userInput) {
         '1' {
            disableBing
        } '2' {
            disableHibernation
        } '3' {
            enableMappedDrives
        } '4' {
            removeUsersFolders
        } '5' {
            uninstallEdge
        } '6' {
            uninstallOneDrive
        } 'a' {
            runAll
        } 'q' {
            stop-process -Id $PID
        }
    }
    pause
    Write-Host "`n"
}
until ($userInput -eq 'q')