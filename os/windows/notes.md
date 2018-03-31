# Windows Cheat Sheet

## Useful Windows variables

```
echo %LOGONSERVER%
echo %USERDOMAIN%
```

### Shell Folders

Windows has this weird thing called "shell folders" that let you jump to
different useful places with a shortcut. You can invoke them by typing Win+R to open the Run dialog and entering one of the names.

Common ones:

```
shell:Administrative Tools
Displays shortcuts to the applets in your Control Panel\Administrative Tools folder (if any)
Applies to XP, Vista, 7, 8

shell:ChangeRemoveProgramsFolder
Open the Control Panel "Uninstall or change a program" applet
Applies to Vista, 7, 8

shell:Common Administrative Tools
Displays shortcuts to the Public applets in your Control Panel\Administrative Tools folder
Applies to XP, Vista, 7, 8

shell:ConnectionsFolder
Open the list of Network Connections
Applies to Vista, 7, 8

shell:ControlPanelFolder
Displays Control Panel
Applies to Vista, 7, 8

shell:ProgramFiles
Open the Program Files folder
Applies to XP, Vista, 7, 8

shell:ProgramFilesX86
Displays 32-bit programs stored on 64-bit Windows, or the \Program Files folder on 32-bit Windows
Applies to Vista, 7, 8

shell:AppUpdatesFolder
Displays installed Windows Updates
Applies to Vista, 7, 8

shell:Common Startup
Open the Public Startup folder
Applies to XP, Vista, 7, 8

shell:RecycleBinFolder
Open the Recycle Bin
Applies to XP, Vista, 7, 8

shell:System
Open the Windows System folder
Applies to Vista, 7, 8

shell:Systemx86
Open the Windows System folder for 32-bit files on 64-bit Windows, or \Windows\System32 on 32-bit Windows
Applies to Vista, 8

shell:Windows
Open the Windows installation folder (usually \Windows)
Applies to XP, Vista, 7, 8

shell:AppData
Open the user Application Data folder
Applies to XP, Vista, 7, 8

shell:CredentialManager
Open the user Credentials folder
Applies to Vista, 7, 8

shell:Cryptokeys
Open the user encryption keys folder
Applies to Vista, 7, 8

shell:CSCFolder
Open the Client Side Cache Offline Files folder, if supported
Applies to XP, Vista, 7

shell:Downloads
Open the user downloads folder
Applies to Vista, 7, 8

shell:DpAPIKeys
Opens the users AppData\Roaming\Microsoft\Protect folder
Applies to Vista, 7, 8

shell:Local AppData
Open the user Application Data folder
Applies to XP, Vista, 7, 8

shell:NetHood
Open the user Network Places folder
Applies to XP, Vista, 7, 8

shell:Startup
Open the user Startup folder
Applies to XP, Vista, 7, 8

shell:SystemCertificates
Open the user certificates folder
Applies to Vista, 7
```

More at this page: [Shell folders: the best-kept Windows time-saving secret](https://www.techradar.com/news/computing/pc/shell-folders-the-best-kept-windows-time-saving-secret-464668).

## WMIC

```batch
:: Get all users
wmic useraccount

:: Get domain
wmic computersystem get domain

:: Get startup programs
wmic startup

:: Example of output formatting
:: Valid formats are list, csv, htable, xml, xsl
wmic /output:C:\\outfile.csv useraccount /format:csv

:: Example of a remote WMIC command
wmic /node:FILESERVER1 computersystem get domain
```


For more, see [this page][wmic].

## Using `clip`
`clip` can easily copy to the clipboard:

```
C:\\> tasklist.exe | clip
```

## Firewall 

Network Discovery

* LLMR
* SSDP
* UPnP
* WSD EventsSecure

Remote Assistance

PNRP-Out

Disable:

* Windows Media Player
* Remote Assistance
* nslookup

## Native Mode

'Native Mode' is a property of a domain controller who only controls computers
with an equal or higher software version. You can check if your DC is in native
mode By looking at the “Raise domain functional level” check on the top of the
domain in Active Directory Users and Computers. Also referred to as the
'functional level' of the domain.

from http://www.grouppolicy.biz/2011/08/tutorial-how-to-setup-default-and-fine-grain-password-policy/

## Important Programs

TODO Fix everything about this

```
lusrmgr.msc
services.msc
msconfig

IIS Manager C:\\inetpub
```

## Group Policy

## Create and Link a Group Policy Object in Active Directory

From [this page](https://www.petri.com/how-to-create-and-link-a-group-policy-object-in-active-directory):

Requirements:

* You need the Group Policy Management Console (GPMC), present by default on
  domain controllers, or can be installed as part of the Remote Server
  Administration Tools (RSAT) on member servers or client devices. Just Google
  for a link.
* User account that has permission to create new Group Policy Objects (GPOs)
  and/or be admin.

Steps:

* Open GPMC with **Start -> Search "Group Policy Management"** (Win 8 and up,
  otherwise name may be different).
* Under your domain, right click Group Policy Objects and select **New** from the
  menu.
* In the New GPO dialog, give the GPO a name and click OK.
* Expand the Group Policy Objects container in the left pane, right click your
  new GPO and select **Edit** from the menu. This will open the Group Policy
  Management Editor window.
* In the left pane of the Group Policy Management Editor window, navigate to the
  location of the setting you want to change.
* Once you’ve found the location, double click the setting in the right pane,
  and then check Enabled in the dialog box.
* Click OK and close the Group Policy Management Editor
  window.

[net-ref]: https://technet.microsoft.com/en-us/library/bb490949.aspx
[env]: http://environmentvariables.org/
[wmic]: https://projectzme.wordpress.com/2013/03/14/windows-tip-wmic-command-cheat-sheet/
[win-RA]: https://www.urtech.ca/2011/05/everything-i-know-about-windows-remote-assistance-easy-assist-and-pnrp-peer-name-resolution-protocol/


[Windows batch scripting](https://en.wikibooks.org/wiki/Windows_Batch_Scripting#REM)
[SS64 Powershell Reference](https://ss64.com/ps/)
