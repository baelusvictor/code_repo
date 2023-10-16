Login-PowerBI

#general parameters for how to save output
    $FilePath = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\"
    $CurrentDate = Get-Date
    $Datum = $CurrentDate.ToString("yyyy_MM_dd")
    $Refreshfolder =  $FilePath + "RefreshLogs\"+ $Datum + ".json"
    $Datasetsfolder =  $FilePath + "Datasets\" + $Datum + ".json"
    Write-Output "script activited on '$Datum'"

#api calls for dataset
    $datasets = Get-PowerBIDataset -Scope Organization #| Where-Object { $_.Name -eq "source_finance" }
    #Write-Output $datasets.name
    (ConvertTo-Json  $datasets -Depth 3) | Out-File -FilePath $Datasetsfolder -Force
    Write-Output "json files datasets saved in '$Datasetsfolder'"

#api calls for refresh
    $refresh = @()
    foreach($ds in $datasets.id)
        {
            $refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$ds/refreshes" -Method GET 
            $jobj = ConvertFrom-Json -InputObject $refreshlog
            $jobj | add-member -Name "dataset_id" -value "$ds" -MemberType NoteProperty
            $refresh +=  ($jobj)
        }
    #Write-Output $refresh
    (ConvertTo-Json $refresh -Depth 3) | Out-File -FilePath $Refreshfolder -Force
    Write-Output "json files refreshlogs saved in: '$Refreshfolder'"

#api calls for auditlogs
    foreach ($i in 0..14) {
    #bij activatie script wordt huidige datum als input gebruikt, niet inzitten met overlap want duplicaten worden via power query verwijderd en bestanden op zelfde datum overschreven
    #gaat twee weken terug
    $CurrentDate = Get-Date
    $Datum = $CurrentDate.ToString("yyyy-MM-dd")
    #je kan enkel data downloaden van dezelfde dag, werkt enkel met DateTime, vandaar deze onhandige omweg
    $End = $Datum+'T23:59:59'
    $EndTime = [datetime]::ParseExact($End, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
    $EndTimeVar = $EndTime.AddDays(-$i)
    $EndString = $EndTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")
    $Begin = $Datum+'T00:00:00'
    $BeginTime = [datetime]::ParseExact($Begin, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
    $BeginTimeVar = $BeginTime.AddDays(-$i)
    $StartString = $BeginTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")
    #$dateString = "download"+$CurrentDate.ToString("yyyy_MM_dd_HH_mm_ss")+"_datum"+$BeginTimeVar.ToString("yyyy_MM_dd")
    $dateString = $BeginTimeVar.ToString("yyyy_MM_dd")
    $csvFile =  $FilePath + "AuditLogs\"+ $dateString + ".csv"
    $activities = (Get-PowerBIActivityEvent -StartDateTime $StartString -EndDateTime $EndString -ResultType JsonString |
    ConvertFrom-Json) | 
    Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
    Export-Csv -NoTypeInformation -Path $csvFile 
    Write-Host $dateString " download complete"
}
    Write-Host "csv files auditlogs saved in: '$Auditfolder'"

#refresh dataset in PBI service that reports on these metrics
    Write-Host "start refresh PBI service"
    #audit logs example hardcoded refresh
    $auditlogs = "9fb4ee53-334b-4880-ac5b-0d420e4ab6e3"
    $refresh = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method POST -Body ($dataset)
    #$refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method GET -Body ($dataset) #| ConvertFrom-Json
    #$refreshlog