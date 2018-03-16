# **OSSEC** Preparation Guide for CCDC
Author: Peter A Krasinski
## **OSSEC** Server Initialization
The first step is to install the dependencies required by **OSSEC** (requires privileged user for everything).
```bash
apt-get install build-essential openssl make gcc
```
You can optionally install and configure `mysql` or `postgresql` to output alerts or syslog to a database and you can find documentation for that [here](http://ossec-docs.readthedocs.io/en/latest/manual/output/database-output.html). For this guide we will be sending alerts to an email address and sending `syslog` output to a [Splunk](https://www.splunk.com/) server.

You can [install](https://ossec.github.io/downloads.html) **OSSEC** by
- Building it from their [Github](https://github.com/ossec/ossec-hids/releases),
- Using the portable Tar and the installation script
- Using their package repository

We will be using the Tar so get the Tar and the signature
```bash
wget -U ossec https://github.com/ossec/ossec-hids/archive/2.9.3.tar.gz
wget -U ossec https://github.com/ossec/ossec-hids/releases/download/2.9.3/ossec-hids-2.9.3.tar.gz.asc
gpg --verify ossec-hids-2.9.3.tar.gz.asc 2.9.3.tar.gz
```
You should get output saying `Good signature from ...`. Now unpack the tar and run the installation script. NOTE: On Debian the script should be ran with bash as dash may cause configuration issues.
```bash
tar -xvf 2.9.3.tar.gz
./install
```
Select `server` as the kind (this means the host will also be monitored). You will want to enable most of the options especially remote syslog (Splunk can consume syslog output), active response, rootkit detection, integrity check daemon and for email notification enter a valid email (assuming you have a mail server). Hope everything compiles fine and finish the setup. Navigate to the ossec directory and start it. `cd /var/ossec/; bin/ossec-control start`
NOTE: The server listens on UDP port 1514 and will be sending output on UDP port 514 so make sure those are open on the firewalls.

## **OSSEC** Adding Agents
Agent installation is almost the same as the server (for Windows look [here](https://ossec.github.io/docs/manual/installation/installation-windows.html)). The typical way to add agents is to create an entry and export a key, then import the key on the agent which provides a means of authentication. This is fine however if you need to add many agents this is time consuming and since CCDC is half about speed we will be adding agents without authentication. This will enable people to add agents with out a key as they will receive one from the . The first step is to start the agent daemon on the server.
```bash
/var/ossec/bin/ossec-authd -p 1515
# make sure you have the udp port open
```
This may output a password. On the agent run...
```bash
/var/ossec/bin/agent-authd -m <host> -p 1515 -P <password>
/var/ossec/bin/ossec-control restart
```
If an error is encountered, it's most likely an issue with OpenSSL and since time is an issue it's better to just add an agent the traditional way [here](https://ossec.github.io/docs/manual/agent/agent-management.html)

## **OSSEC** Extra Configuration
There are two main configuration files; `/var/ossec/etc/ossec.conf` which is local to each machine and, `/var/ossec/etc/shared/agent.conf` which is created on the manager and can contain configuration for specific agents. [documentation](https://ossec.github.io/docs/manual/agent/agent-configuration.html)
