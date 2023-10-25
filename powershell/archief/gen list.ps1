Login-PowerBI
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH_MM_s")
$jsonFilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\RefreshLogs\"
$jsonFile =  $jsonFilePath + $Datum + ".json"
$csvFile =  $jsonFilePath + $Datum + ".csv"
$datasets = ( Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/admin/datasets" -Method GET ) | ConvertFrom-Json

$output = @()

#Add-Content -Path $jsonFile -Value "["

ForEach ($ds in $datasets.value) 
{ 
$dataset = $ds.id
Write-Output $ds.name # $ds.id
$refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method GET -Body ($dataset)
$output += $refreshlog
#Add-Content -Path $jsonFile -Value (( $refreshlog) + ",") # Add object to file
}

#Add-Content -Path $jsonFile -Value "{}]" #Finish the file

#$output | ConvertTo-Json -Depth 2 | Out-File -FilePath $jsonFile -Force Write-Host "JSON log file '$jsonFile' created"

$output | 
Select-Object -Property id |
Export-Csv -Path $csvFile -Delimiter ";" -Force -NoTypeInformationWrite-Host "CSV log file '$csvFile' created"










