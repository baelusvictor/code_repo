#Run next two lines the first time u ever use powershell in a pbi context only, afterwarts comment them
#Find-Module -Name PowerShellGet
#Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser

Login-PowerBI
foreach ($i in 0..14) {
    #onderstaande parameter is de enige die je in een andere context zou moeten aanpassen
    $pathfile = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\AuditLogs\"
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
    $csvFile =  $pathfile + $dateString + ".csv"
    $activities = (Get-PowerBIActivityEvent -StartDateTime $StartString -EndDateTime $EndString -ResultType JsonString |
    ConvertFrom-Json) | 
    Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
    Export-Csv -NoTypeInformation -Path $csvFile 

    Write-Host $dateString " download complete"
}

Write-Host "script auditlogs completed"

Write-Host "start refresh"
#audit logs example hardcoded refresh
$dataset = "9fb4ee53-334b-4880-ac5b-0d420e4ab6e3"
$refresh = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method POST -Body ($dataset)
$refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method GET -Body ($dataset) #| ConvertFrom-Json
$refreshlog