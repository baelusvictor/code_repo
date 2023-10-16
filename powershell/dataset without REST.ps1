Login-PowerBI

#general parameters for how to save output
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH")
$FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"

#specific parameters for this part of the script
$Datasetsfolder =  $FilePath + "Datasets\" + $Datum + ".json"

#api calls
$datasets = Get-PowerBIDataset -Scope Organization | Where-Object { $_.Name -eq "source_finance" } | ConvertTo-Json

#export
$datasets | Out-File -FilePath $Datasetsfolder -Force
Write-Output "json files datasets saved in '$Datasetsfolder'"
