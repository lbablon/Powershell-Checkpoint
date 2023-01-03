<#

.SYNOPSIS
This script is intended to terminate an active session with checkpoint webservices api.

.DESCRIPTION
The script will shut an active session on a Checkpoint management server using webservices. The user needs to provide the script with the api server's ip address and 
the sessiond id (sid) he wants to terminate. This is done by using the input parameter -server and -sid when calling the script. The script has been tested on R81.10
with webservices API in version v1.8.1, but it should also works with previous api versions.

.EXAMPLE
"./chkp-logout.ps1" -Server 192.168.1.50 -Sid "YlaPwxyXUyPRYzaLliWN8TU99s_WKrnbRc1R6DgsBFw"

.INPUTS
Server : ip address of the Checkpoint management server
Sid :  Session id of the current api session you want to terminate

.NOTES
Written by : Lucas Bablon
Version : 1.1
Link : https://github.com/lbablon
    
#>


#params
param (

    [Parameter(Mandatory=$true, HelpMessage="Checkpoint Management api's ip")]
    [string]$server,
    [Parameter(Mandatory=$true, HelpMessage="API session id")]
    [string]$sid

)


#reset variables from previous run
$response=""


#headers
$headers=@{

    "x-chkp-sid"=$sid

}

$global:headers=$headers | ConvertTo-Json -Compress


#body
$body=@{}
$body=$body | ConvertTo-Json -Compress
$body

#create logout URI
$callURI="https://${server}/web_api/logout"


#api call
$response=Invoke-WebRequest -Uri $callURI -Body $body -Headers $headers -ContentType application/json -Method POST
