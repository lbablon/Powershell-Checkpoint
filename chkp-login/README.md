
# chkp-login.ps1 - Powershell script to connect to Checkpoint webservices api

Simple powershell script to initiate a session with Checkpoint webservices API. IP address of the management server and username are mandatory as input parameters, password will be ask with a prompt.

The script will then return the api session id as $sid, so that it can be used with other api calls.

The script as been tested on R81.10 with api version 1.8.1, but it should also works with other versions.


## Example

```
.\chkp-login.ps1 -server 192.168.50.1 -user admin -password Str0nK
```

Runs the script and returns sid as global variable $sid. 


```
.\chkp-login.ps1 -server 192.168.50.1 -user admin
```

RUns the script in interactive mode so that it will ask the user for a password with a prompt.
