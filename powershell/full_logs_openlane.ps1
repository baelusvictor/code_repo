#Login-PowerBI

#some time intel that is used troughout
$CurrentDate = Get-Date
$Datum = $CurrentDate.ToString("yyyy_MM_dd")

#where to store the data
$path = "C:\Users\victor.baelus\OneDrive - OPENLANE Europe\Documents - BI\02 - BI - REPORTING\03 - POWER BI\_pbix sources\18. Administration\logs\"
$auditfolder = $path + "auditlog\"
$refreshfolder = $path + "refresh\"
$refreshfile = $refreshfolder + $Datum + ".json"
$datasetfile = $path + "dataset"+ ".json"
$workspacefile = $path + "workspace"+ ".json"

#admin api call for dataset
    $datasets = Get-PowerBIDataset -Scope Organization #| Where-Object { $_.Name -eq "source_finance" }
    #Write-Output $datasets.name
    (ConvertTo-Json  $datasets -Depth 3) | Out-File -FilePath $datasetfile -Force
    #$datasets | Out-GridView

#admin api call for workspace
    $workspaces = Get-PowerBiWorkspace -Scope Organization -All #| Where-Object { $_.Type -ne "PersonalGroup" } | Where-Object { $_.Type -ne "Personal" }
    #Write-Output $workspaces.name 
    (ConvertTo-Json  $workspaces -Depth 4) | Out-File -FilePath $workspacefile -Force
    
    #$workspaces | Out-GridView

#non-admin api calls for refresh -- WILL RETURN ERROR MESSAGES WHEN TRYING TO GET REFRESH DATA FROM PERSONAL WORKSPACES
    $refresh = @() # iterate through de datasets_id
    foreach($ds in $datasets.id)
        {
            clear # no need for so many error messages
            $refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$ds/refreshes" -Method GET 
            $jobj = ConvertFrom-Json -InputObject $refreshlog
            $jobj | add-member -Name "dataset_id" -value "$ds" -MemberType NoteProperty
            $refresh +=  ($jobj)
        }
    #Write-Output $refresh
    (ConvertTo-Json $refresh -Depth 4) | Out-File -FilePath $refreshfile -Force

#admin api call for audit logs
    foreach ($i in 0..14) { #repeat same api call for each day in two weeks
        #bij activatie script wordt huidige datum als input gebruikt, niet inzitten met overlap want duplicaten worden via power query verwijderd en bestanden op zelfde datum overschreven
        #gaat twee weken terug
        #je kan enkel data downloaden van dezelfde dag, werkt enkel met DateTime, vandaar deze onhandige omweg
        $CurrentDate = Get-Date
        $Datum = $CurrentDate.ToString("yyyy-MM-dd")
        $End = $Datum+'T23:59:59'
        $EndTime = [datetime]::ParseExact($End, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
        $EndTimeVar = $EndTime.AddDays(-$i)
        $EndString = $EndTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")
        $Begin = $Datum+'T00:00:00'
        $BeginTime = [datetime]::ParseExact($Begin, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
        $BeginTimeVar = $BeginTime.AddDays(-$i)
        $StartString = $BeginTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")
        $dateString = $BeginTimeVar.ToString("yyyy_MM_dd")
        $auditfile =  $auditfolder + $dateString + ".csv"
        $activities = (Get-PowerBIActivityEvent -StartDateTime $StartString -EndDateTime $EndString -ResultType JsonString |
        ConvertFrom-Json) | 
        Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
        Export-Csv -NoTypeInformation -Path $auditfile 
        Write-Host $dateString " download complete"
    }

#output confirmation
Write-Output "json files datasets saved in '$datasetfile'"
Write-Output "json files workspace saved in '$workspacefile'"
Write-Output "json files refreshlogs saved in: '$refreshfile'"
Write-Output "csv files auditlogs saved in: '$auditfolder'"