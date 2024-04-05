#clear

#first time u run powershell u need to download the two modules below
#Find-Module -Name PowerShellGet
#Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser

#first time u run this script u need to login first, after u can comment it away
#Connect-PowerBIServiceAccount

#this will ask for a name of the workspace, so u can just call this script without editing it first
$workspace = Read-Host -Prompt "Geef naam workspace op (bv 'Finance')"

#we now have the name but need the id so make an api call for metadata
$target_workspace = Get-PowerBIWorkspace -Name $workspace -ErrorAction SilentlyContinue

#of all metadata keep the id
$target_workspace_ID = $target_workspace.id

#this will present the id
Write-Output $target_workspace_ID

#use the id to make an api call with a list of all the users (would not accept the name)
$result = Invoke-PowerBIRestMethod -url "Groups/$target_workspace_ID/Users" -Method Get

#presents the data in a human readable way
$result | ConvertFrom-Json | Select -ExpandProperty value | Select-Object -Property displayName

