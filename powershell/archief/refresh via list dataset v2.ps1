Login-PowerBI

#general parameters for how to save output
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH")
$FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"

#specific parameters for this part of the script
$Refreshfolder =  $FilePath + "RefreshLogs\"+ $Datum + ".json"

#api calls
$datasets = Get-PowerBIDataset -Scope Organization | Where-Object { $_.Name -eq "source_finance" }

$refresharray = @()
foreach($ds in $datasets.id)
    {
        $refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$ds/refreshes" -Method GET 
        $jobj = ConvertFrom-Json -InputObject $refreshlog
        $jobj | add-member -Name "dataset_id" -value "$ds" -MemberType NoteProperty
        $refresharray +=  ($jobj)
    }
Write-Output $refresharray

#export
(ConvertTo-Json $output -Depth 3) | Out-File -FilePath $Refreshfolder -Force
Write-Output "json files refreshlogs saved in: '$Refreshfolder'"

