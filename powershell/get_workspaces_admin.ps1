#Login-PowerBI

$Workspaces_all = Get-PowerBiWorkspace -Scope Organization -All 
$Workspaces_filtered = $Workspaces_all | Where-Object { $_.Type -ne "PersonalGroup" } | Where-Object { $_.Type -ne "Personal" }

Write-Output $Workspaces_filtered.name 
#$Workspaces_filtered | Out-GridView

#export json
$jsonFilePath = "C:\Users\victo\OneDrive\Desktop\refreshlogs\workspaces.json"
$Workspaces_filtered |
    ConvertTo-Json -Depth 4 |
    Out-File -FilePath $jsonFilePath -Force
Write-Host "JSON log file '$jsonFilePath' created"