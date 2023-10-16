Login-PowerBI

#general parameters for how to save output
$FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH")
$Refreshfolder =  $FilePath + "RefreshLogs\"+ $Datum + ".json"
$Datasetsfolder =  $FilePath + "Datasets\" + $Datum + ".json"
Write-Output "script activited on '$Datum'"

#api calls
$datasets = Get-PowerBIDataset -Scope Organization #| Where-Object { $_.Name -eq "source_finance" }
Write-Output $datasets.name

$refresh = @()
foreach($ds in $datasets.id)
    {
        $refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$ds/refreshes" -Method GET 
        $jobj = ConvertFrom-Json -InputObject $refreshlog
        $jobj | add-member -Name "dataset_id" -value "$ds" -MemberType NoteProperty
        $refresh +=  ($jobj)
    }
Write-Output $refresh

#export
(ConvertTo-Json  $datasets -Depth 3) | Out-File -FilePath $Datasetsfolder -Force
Write-Output "json files datasets saved in '$Datasetsfolder'"

(ConvertTo-Json $refresh -Depth 3) | Out-File -FilePath $Refreshfolder -Force
Write-Output "json files refreshlogs saved in: '$Refreshfolder'"



