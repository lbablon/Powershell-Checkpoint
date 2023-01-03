<#

.SYNOPSIS
This script will establish a session with Checkpoint webservices api.

.DESCRIPTION
The script will initiate a session with Checkpoint webservices API. The user will be asked for the ip address of the Checkpoint asset where the management 
api blade is enabled, a username with management api permissions and a password. These information can also be used as input parameters when calling the 
script. If the user does not provide any password, it will be prompt to him. The script has been tested on a R81.10 plateform with webservices API in version 
v1.8.1, but it should also works with previous api versions.

.EXAMPLE
"./chkp-login.ps1" -Server 192.168.1.50 -User admin
Interactive mode

.EXAMPLE
"./chkp-login.ps1" -Server 192.168.1.50 -User admin -Password Str0nkP@sSw0rD
Non interactive mode

.INPUTS
Server : ip address of the checkpoint management server
User : user with api management permission on Checkpoint
Password : password for user

.OUTPUTS
Sid : Session id to use in x-chkp-sid headers for other api calls

.NOTES
Written by : Lucas Bablon
Version : 1.0
Link : https://github.com/lbablon
    
#>


#params
param (

    [Parameter(Mandatory=$true, HelpMessage="Checkpoint Management api's ip")]
    [string]$server,
    [Parameter(Mandatory=$true, HelpMessage="Username with api management permission")]
    [string]$username,
    [Parameter(Mandatory=$false, HelpMessage="Password")]
    [string]$password

)


#reset variables from previous run
$response=""
$sid=""


#password prompt
if (! $password) {

    $creds=get-credential -message "Please enter password" -username $username
    $password=$creds.GetNetworkCredential().password

}


#body
$body=@{

    "user"="$username"
    "password"="$password"
    "enter-last-published-session"="true"

}
    
$body=$body| convertto-json -compress
$body

#create login URI
$loginURI="https://${server}/web_api/login"


#allow self-signed certificates
[System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true}


#api call
$response=Invoke-WebRequest -Uri $loginURI -Body $body -ContentType application/json -Method POST


#make the content of the response a powershell object
$responsecontent=$response.Content | ConvertFrom-Json


#get sid
$sid=$responsecontent.sid


#return sid
$global:sid=$sid


#uncomment below if you also want to return full header ready for other api calls
#$global:header=@{"x-chkp-sid"=$sid}
