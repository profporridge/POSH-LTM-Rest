﻿Function Get-F5session{
<#
.SYNOPSIS
    Generate an F5 session object to be used in querying and changing the F5 LTM
.DESCRIPTION
    This function takes the DNS name or IP address of the F5 LTM device, and a username for an account 
    with the privileges modify the LTM via the REST API, and the user's password as a secure string.
    To generate a secure string from plain text, use:
    $F5Password = ConvertTo-SecureString -String $Password -AsPlainText -Force  
#>
    param(
        [Parameter(Mandatory=$true)][string]$LTMName,
        [Parameter(Mandatory=$true)][System.Management.Automation.PSCredential]$LTMCredentials
    )

    $BaseURL = "https://$LTMName/mgmt/tm/ltm/"

    #Create custom credential object for connecting to REST API
    [pscustomobject]@{BaseURL = $BaseURL; Credential = $LTMCredentials}

}