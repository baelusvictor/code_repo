Login-PowerBI

#general parameters for how to save output
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd")
$FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"

#specific parameters for this part of the script
$Datasetsfolder =  $FilePath + "Datasets\" + $Datum + ".json"

#REST api GET calls
$datasets = ( Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/admin/datasets" -Method GET ) #| ConvertFrom-Json
#Write-Output $datasets

#export
$datasets | Out-File -FilePath $Datasetsfolder -Force
Write-Output "json files datasets saved in '$Datasetsfolder'"