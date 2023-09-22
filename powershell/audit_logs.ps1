
Login-PowerBI
foreach ($i in 1..14) {
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
    $csvFile = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\AuditLogs\" + $dateString + ".csv"
    $activities = (Get-PowerBIActivityEvent -StartDateTime $StartString -EndDateTime $EndString -ResultType JsonString |
    ConvertFrom-Json) | 
    Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
    Export-Csv -NoTypeInformation -Path $csvFile 
}