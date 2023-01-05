
# chkp-accessrules.ps1 - Powershell script to export access rules from a policy

The script uses Checkpoint webservices api to connect to a management server and export all access rules from a specified access layer into a csv file. 

The script as been tested on R81.10 with api version 1.8.1 and above, but it should also works with older versions. No compatibility ith MDS yet. 

## Usage

Mandatory input parameters include management server's ip, user with sufficient permissions, a password and the access layer named after the package policy you want to export rules from. If you do not specify a password and a path when calling the script, it will prompted to you during the execution. Otherwise, the script can be run without any interaction if you set the password and the export path using the parameter switchs.

You can optimize the execution time of the script by changing the limit value of the json body object when querying the rules. This can be done in the following section of the code :

```
#body
$body=@{

"details-level"="standard"
"name"=$AccessLayer
"use-object-dictionary"="false"
"show-hits"="true"
"offset"=$offset
"limit"=100

}
```

Execution time can change depending on your management server's sizing, also i notice that it can greetly improve the cache usage of the api on small sized management server, reducing risk of seeing error 500. Also, the less the limit is, the more precise the progress bar will be.

## Parameters

- **[-server]**, Checkpoint management server's ip address or fqdn.
- **[-user]**, user with sufficient permissions on the management server.
- **[-password]**, password for the api user.
- **[-accesslayer]**, access layer's name that corresponds to the policy package you want to export rules from.
- **[-path]**, filepath where you want to export the results. This shloud be a .csv file.

## Examples

```
"./chkp-accessrules.ps1" -Server 192.168.1.50 -user admin -AccessLayer "Standard"
```

Runs the script then asks the user for password then and exports all rules from the access layer named "Standard" then asks the user where to save the results as a csv file.

```
"./chkp-accessrules.ps1" -Server 192.168.1.50 -user admin -password Str0nK! -AccessLayer "Standard" -Path "C:\Temp\rules.csv"
```

Runs the script in non interactive mode and exports the access rules to C:\Temp\rules.csv
