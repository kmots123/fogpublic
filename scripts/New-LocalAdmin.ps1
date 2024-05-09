[CmdletBinding()]

Param (
    [string]$Username,
    [string]$Password
)

New-LocalUser $Username -Password (ConvertTo-SecureString -String $Password -AsPlainText -Force)
Add-LocalGroupMember -Group "Administrators" -Member $Username
