#login one and then comment this away
#Login-PowerBI

#api call
$Workspaces_all = Get-PowerBiWorkspace -Scope Organization -All 
$Workspaces_filtered = $Workspaces_all | Where-Object { $_.Type -ne "PersonalGroup" } | Where-Object { $_.Type -ne "Personal" }

#let powershell write back to u via terminal or via pop up if u want (or not > comment away)
#Write-Output $Workspaces_filtered.name 
#$Workspaces_filtered | Out-GridView

#save to output in as json in underlying location
$jsonFilePath = "C:\Users\victor.baelus\OneDrive - OPENLANE Europe\Desktop\testlogs\workspace.json"
$Workspaces_filtered |
    ConvertTo-Json -Depth 4 |
    Out-File -FilePath $jsonFilePath -Force
Write-Host "JSON log file '$jsonFilePath' created"