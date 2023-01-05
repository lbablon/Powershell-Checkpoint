
# chkp-logout.ps1 - Powershell script to end an api session

Simple powershell script to terminate a session with a Checkpoint management server, webservices version.

## Usage

The script as been tested on R81.10 with api version 1.8.1, but it should also works with other versions.

## Parameters

- **[-server]**, Checkpoint management server's ip address or fqdn
- **[-sid]**, curretn api session id you want to terminate

## Example

```
.\chkp-logout.ps1 -Server 192.168.50.1 -Sid "PLrHAIT3LOdgTlf187kPXvF6YwqF9oSqUsubgR2WGNQ"
```

Runs the script and kills the api session with corresponding id. 
