﻿Function Test-VirtualServer { 
<#
.SYNOPSIS
    Test whether the specified virtual server exists
.NOTES
    Pool names are case-specific.
#>

    param (
        [Parameter(Mandatory=$true)]$F5session,
        [Parameter(Mandatory=$true)][string]$VirtualServerName
    )

    Write-Verbose "NB: Virtual server names are case-specific."

    #Build the URI for this virtual server
    $URI = $F5session.BaseURL + 'virtual/{0}' -f ($VirtualServerName -replace '[/\\]','~')

    Try {
        Invoke-RestMethodOverride -Method Get -Uri $URI -Credential $F5session.Credential | out-null
        $true
    }
    Catch{
        $false
    }

}