# This script will download the latest version of the F5-LTM PowerShell module from github and install it for the current user.
# Thanks to DarkOperator for doing all the heavy lifting for this snippet
# https://gist.github.com/darkoperator/3f9da4b780b5a0206bca
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
# Make sure the module is not loaded
Remove-Module F5-LTM -ErrorAction SilentlyContinue

# Download latest version from g-hub
$webclient = New-Object System.Net.WebClient
$url = "https://github.com/profporridge/POSH-LTM-Rest/archive/master.zip"
Write-Output "Downloading latest version of F5-LTM from $url" 
$file = "$($env:TEMP)\F5-LTM.zip"
$webclient.DownloadFile($url,$file)
Write-Output  "File saved to $file"

# Unblock and decompress
Unblock-File -Path $file
#$targetondisk = "$($env:USERPROFILE)\Documents\WindowsPowerShell\Modules"
$targetondisk = "C:\Program Files\WindowsPowerShell\Modules"
New-Item -ItemType Directory -Force -Path $targetondisk | out-null
$shell_app=new-object -com shell.application
$zip_file = $shell_app.namespace($file)
Write-Output "Uncompressing the Zip file to $($targetondisk)" 
$destination = $shell_app.namespace($targetondisk)
$destination.Copyhere($zip_file.items(), 0x10)

# Rename and import
Write-Output "Renaming folder" -ForegroundColor Cyan
Move-Item -Path ($targetondisk+"\POSH-LTM-Rest-master\F5-LTM") -Destination ($targetondisk+"\F5-LTM") -Force
Remove-Item -Path ($targetondisk+"\POSH-LTM-Rest-master") -Force -Recurse
Write-Output "Module has been installed" -ForegroundColor Green
Import-Module -Name F5-LTM
Get-Command -Module F5-LTM