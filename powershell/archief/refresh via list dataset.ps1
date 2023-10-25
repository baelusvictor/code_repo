Login-PowerBI

#general parameters for how to save output
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd_HH")
$FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"

#specific parameters for this part of the script
$Refreshfolder =  $FilePath + "RefreshLogs\"+ $Datum + ".json"

#REST api GET calls
#$datasets = ( Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/admin/datasets" -Method GET ) | ConvertFrom-Json #admin
$datasets = ( Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets" -Method GET ) | ConvertFrom-Json #not admin
$output = @()
ForEach ($ds in $datasets.value) 
    { 
    $dataset = $ds.id
    Write-Output $ds.name 
    $refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method GET -Body ($dataset)

    $jobj = ConvertFrom-Json -InputObject $refreshlog
    $jobj | add-member -Name "dataset_id" -value "$dataset" -MemberType NoteProperty

    $finalobj = (ConvertTo-Json $jobj)
    write-host $test
    $output +=  (ConvertFrom-JSON $finalobj)
    }
Write-Output $output

#export
(ConvertTo-Json $output -Depth 3) | Out-File -FilePath $Refreshfolder -Force
Write-Output "json files refreshlogs saved in '$Refreshfolder'"

