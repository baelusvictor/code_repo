#Login-PowerBI

$Workspaces_all = Get-PowerBiWorkspace -Scope Organization -All 
$Workspaces_filtered = $Workspaces_all | Where-Object { $_.Type -ne "PersonalGroup" } | Where-Object { $_.Type -ne "Personal" }

Write-Output $Workspaces_filtered.name 
$Workspaces_filtered | Out-GridView