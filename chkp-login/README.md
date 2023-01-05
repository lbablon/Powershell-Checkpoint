
# chkp-login.ps1 - Powershell script to connect to Checkpoint webservices api

Simple powershell script to initiate a session with Checkpoint webservices API. 

The script as been tested on R81.10 with api version 1.8.1 and above, but it should also works with older versions.

## Usage

IP address of the management server and username are mandatory as input parameters, password will be ask with a prompt but it can also be specified as an input.

The script will then return the api session id as $sid, so that it can be used with other api calls. You can uncomment the following lines in the script so that it will also return the sid already prepared as a header :

```
#uncomment below if you also want to return full header ready for other api calls
$global:headers=@{"x-chkp-sid"=$sid}
```

## Parameters

- **[-server]**, Checkpoint management server's ip address or fqdn
- **[-username]**, user with sufficient permissions on the management server
- **[-password]**, password for the api user

## Examples

```
.\chkp-login.ps1 -server 192.168.50.1 -user admin -password Str0nK
```

Runs the script and returns sid as global variable $sid. 

```
.\chkp-login.ps1 -server 192.168.50.1 -user admin
```

Runs the script in interactive mode so that it will ask the user for a password with a prompt.

