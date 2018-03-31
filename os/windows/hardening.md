# Additional Information

## Networking

### Firewall Configuration

`Start Menu -> ??? -> Windows Firewall`.

Refer to the table of ports. Use the principle of least privilege, eg. if a
server needs 443 open because it's a web server with SSL, then leave it,
otherwise DENY.
 
### Remote Access Configuration

**Disable remote powershell**: Simply run the following command:

```powershell
Disable-PSRemoting
```
There are some caveats, see [this page][psremote].

**Whitelisting RDP users**: from https://serverfault.com/questions/598278/how-to-disable-rdp-access-for-administrator

> To deny a user or a group logon via RDP, explicitly set the "Deny logon through
> Remote Desktop Services" privilege. To do this access a group policy editor
> (either local to the server or from a OU) and set this privilege:
> 
> > Start > Run > Gpedit.msc if editing the local policy or chose the appropriate policy and edit it.
> > Computer Configuration | Windows Settings | Security Settings | Local Policies | User Rights Assignment.
> > Find and double click "Deny logon through Remote Desktop Services"
> > Add the user and / or the group that you would like to deny access.
> > Click ok.
> > Either run gpupdate /force /target:computer or wait for the next policy refresh for this setting to take effect.

**Set an RDP timeout**: For Windows Server 2008 R2, you may configure the following
registry value to configure the timeout:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
```

> Name: LogonTimeout (DWORD).
> Value: Specifies the time in seconds – Decimal Value – 300. Hex - (12c) its 5 minutes.

Reboot after adding.

**Disable telnet**: To disable telnet, `Win+R` and search for `appwiz.cpl`.
Click `Turn Windows Features On or Off` and then find telnet in the list.
Uncheck it and restart.

### NTP Configuration

*A time difference of merely 5 minutes will completely break Windows logons and
various other functions that rely on Kerberos security.* Servers that are domain
members will automatically have their time synched with a domain controller upon
joining the domain, but stand alone servers need to have NTP set up to sync to
an external source so the clock remains accurate. Domain controllers should also
have their time synched to a time server, ensuring the entire domain remains
within operational range of actual time.

## Software and OS

### User Configuration

Modern Windows Server editions force you to do this, but 

* Make sure the password for the local Administrator account is reset to something secure. 
* Disable the local administrator whenever possible.
* Set up an admin account to use. Either:
    1. Add an appropriate domain account, if your server is a member of an Active Directory (AD), or
    2. create a new local account and put it in the administrators group.
* Verify that the local guest account is disabled where applicable.

### Update Installation

`Start Menu > ??? > Windows Update`, duh.

### Check Installed Programs

TODO Complete section.

### Service Configuration

* Windows server has a set of default services that start automatically and run
  in the background.
* Disable everything other than primary functionality. 
* Older versions of MS server have more unneeded services than newer, so
  carefully check any 2008 or 2003 (!) servers.

TODO Format this section better.

Finally, every service runs in the security context of a specific user. For
default Windows services, this is often as the Local System, Local Service or
Network Service accounts. This configuration may work most of the time, but for
application and user services, best practice dictates setting up service
specific accounts, either locally or in AD, to handle these services with the
minimum amount of access necessary. This keeps malicious actors who have
compromised an application from extending that compromise into other areas of
the server or domain.

### Windows Features and Roles Configuration

Microsoft uses roles and features to manage OS packages. Roles are basically a
collection of features designed for a specific purpose, so generally roles can
be chosen if the server fits one, and then the features can be customized from
there. Roles are managed with the "Server Manager" program:
https://msdn.microsoft.com/en-us/library/dd184080.aspx

Two equally important things to do are:

1. Make sure everything you need is installed. (This might be a .NET framework
   version or IIS, but without the right pieces your applications won’t work.)
2. Uninstall everything you don’t need.

### Task Scheduler

TODO

### Other Startup Tasks

* `msconfig.msc` or in newer versions, the 'Startup' tab of the Task Manager.
* `shell:startup`.

## Common Inject Tasks

### Centralized Logging

**Splunk forwarder**: The Splunk forwarder can be downloaded from [this page](https://www.splunk.com/en_us/download/universal-forwarder.html), however you need an account. Installation instructions can be found [here](https://docs.splunk.com/Documentation/MSApp/1.4.3/MSInfra/InstallauniversalforwarderoneachWindowshost).

**OSSEC Agent**: The agent can be downloaded from [this page](https://ossec.github.io/downloads.html); Installation instructions are found [here](https://ossec.github.io/docs/manual/agent/agent-auth.html?highlight=ossec%20add%20agent).

### Password policy

(Mostly stolen from this page [How to Setup Default and Fine-Grained Passwords](http://www.grouppolicy.biz/2011/08/tutorial-how-to-setup-default-and-fine-grain-password-policy/))

If your server is a member of AD, the password policy will be set at the domain
level in the Default Domain Policy. Stand alone servers can be set in the local
policy editor (`gpedit.msc`). A good password policy will at least
establish the following:

* Complexity and length requirements - how strong the password must be
* Password expiration - how long the password is valid
* Password history - how long until previous passwords can be reused
* Account lockout - how many failed password attempts before the account is suspended

Setting a default Domain Password Policy:

1. Create a new Group Policy Object at the top level of the domain (e.g. “Domain
   Password Policy”). Link it to the domain, and set the Enforce option. This is
   so the defaults are preserved.
2. Edit the “Domain Password Policy” GPO and go to **Computer Configurations ->
   Policies -> Windows Settings -> Security Settings -> Account Policy ->
   Password Policy** and configured the password policies settings to the
   configuration you desire. This may trigger domain users to change their
   password the next time they logon.
3. You're done!
 
## Further Hardening

TODO Make this... better

* Logging works differently depending on whether your server is part of a
  domain. 
* Domain logons are processed by domain controllers, and as such, they have the
  audit logs for that activity, not the local system. Stand alone servers will
  have * security audits available and can be configured to show passes and/or
  failures.
* Set the max size of your logs and scope them to an appropriate size, they are
  usually too small.
* Disk space should be allocated during server builds for logging, especially
  for applications like MS Exchange.

# Resources

1. [The Windows Server Hardening Checklist][wshc] (what this guide was based on)

[wshc]: https://www.upguard.com/blog/the-windows-server-hardening-checklist
[psremote]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/disable-psremoting?view=powershell-5.1