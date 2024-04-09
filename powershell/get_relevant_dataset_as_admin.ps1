#login one and then comment this away
#Login-PowerBI

#api call
$Datasets_all = Get-PowerBiDataset -Scope Organization 
$Datasets_filtered = $Datasets_all | Where-Object { $_.Type -ne "PersonalGroup" } | Where-Object { $_.Type -ne "Personal" }

#let powershell write back to u via terminal or via pop up if u want (or not > comment away)
#Write-Output $Datasets_all.name 
$Datasets_filtered | Out-GridView

#save to output in as json in underlying location
$jsonFilePath = "C:\Users\victor.baelus\OneDrive - OPENLANE Europe\Desktop\testlogs\dataset.json"
$Datasets_filtered |
    ConvertTo-Json -Depth 4 |
    Out-File -FilePath $jsonFilePath -Force
Write-Host "JSON log file '$jsonFilePath' created"

