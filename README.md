# Windows 10 Post Install
A simple helper script to handle some post install setup duties with prompts.

Currently it can Disable Bing Search In Start Menu, Disable Hibernation, Enable Mapped Network Drive(s) With UAC Elevated Permissions, Enable Long Paths, Remove User Folders From This PC, Uninstall Edgeium And Uninstall OneDrive.

To run you'll need to start PowerShell as Admin and run ```Set-ExecutionPolicy RemoteSigned``` if PowerShell has not been configured previously to run scripts.

The file will also need to be unblocked by changing to the directory the script is in and running ```Unblock-File -Path "./Microsoft Windows 10 Post Install.ps1"```.

Right click on "Microsoft Windows 10 Post Install.ps1" and click Run With PowerShell.

Follow the prompts.
