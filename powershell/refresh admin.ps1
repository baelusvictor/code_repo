Login-PowerBI
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH_MM_s")
$jsonFilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\RefreshLogs\"
$jsonFile =  $jsonFilePath + $Datum + ".json"

$uri = "https://api.powerbi.com/v1.0/myorg/admin/capacities/refreshables"
$datasets = ( Invoke-PowerBIRestMethod -Url $uri -Method GET )
#Write-Output (ConvertTo-Json $datasets )
Write-Output ($datasets )
Add-Content -Path $jsonFile -Value $datasets #Finish the file




